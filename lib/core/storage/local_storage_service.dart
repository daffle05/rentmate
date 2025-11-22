// lib/core/storage/local_storage_service.dart

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../error/failure.dart';

/// Hive box names used across the app.
class HiveBoxes {
  static const tenants = 'tenants';
  static const payments = 'payments';
  static const dashboard = 'dashboard'; // optional
}

/// A small service that centralizes Hive open/close, export/import, and simple
/// housekeeping for offline storage. All public methods return Either<Failure, T>.
class LocalStorageService {
  LocalStorageService._private();
  static final LocalStorageService instance = LocalStorageService._private();

  bool _initialized = false;

  /// Initialize service - open required boxes. Call this early (main).
  Future<Either<Failure, void>> init({
    List<String> boxesToOpen = const [
      HiveBoxes.tenants,
      HiveBoxes.payments,
      HiveBoxes.dashboard,
    ],
  }) async {
    try {
      // open every box if not opened already
      for (final name in boxesToOpen) {
        if (!Hive.isBoxOpen(name)) {
          await Hive.openBox(name);
        }
      }
      _initialized = true;
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to initialize local storage: ${e.toString()}'));
    }
  }

  /// Close all open boxes (optional shutdown)
  Future<Either<Failure, void>> closeAllBoxes() async {
    try {
      await Hive.close();
      _initialized = false;
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to close boxes: ${e.toString()}'));
    }
  }

  /// Convenience getters for boxes (untyped dynamic to avoid import conflicts).
  /// Use Box<T> if you want strong typing in your code.
  Box get tenantsBox {
    return Hive.box(HiveBoxes.tenants);
  }

  Box get paymentsBox {
    return Hive.box(HiveBoxes.payments);
  }

  Box get dashboardBox {
    return Hive.box(HiveBoxes.dashboard);
  }

  // ----------------------
  // Export / Import
  // ----------------------

  /// Export box contents as a serializable Map.
  ///
  /// Result shape:
  /// {
  ///   "tenants": [ { "id": "...", "name": "...", ... }, ... ],
  ///   "payments": [ { "id": "...", "tenantId": "...", ... }, ... ],
  ///   "dashboard": [ ... ] // if any
  /// }
  Future<Either<Failure, Map<String, dynamic>>> exportAllDataToMap() async {
    try {
      if (!_initialized) {
        return Left(CacheFailure('Local storage not initialized.'));
      }

      final Map<String, dynamic> result = {};

      // Export tenants
      final tenants = tenantsBox.values.map((dynamic t) {
        try {
          // reading fields dynamically (works as long as model properties exist)
          return {
            'id': (t as dynamic).id,
            'name': (t as dynamic).name,
            'roomNumber': (t as dynamic).roomNumber,
            'rentAmount': (t as dynamic).rentAmount,
            'dueDate': (t as dynamic).dueDate,
          };
        } catch (_) {
          // fallback: try to use HiveObject.toMap-like behaviour via binary representation
          return t.toString();
        }
      }).toList();
      result['tenants'] = tenants;

      // Export payments
      final payments = paymentsBox.values.map((dynamic p) {
        try {
          return {
            'id': (p as dynamic).id,
            'tenantId': (p as dynamic).tenantId,
            'amount': (p as dynamic).amount,
            'datePaid': (p as dynamic).datePaid?.toIso8601String(),
            'monthCovered': (p as dynamic).monthCovered,
            'notes': (p as dynamic).notes,
            'paymentMethod': (p as dynamic).paymentMethod,
          };
        } catch (_) {
          return p.toString();
        }
      }).toList();
      result['payments'] = payments;

      // Export dashboard entries (if used)
      if (Hive.isBoxOpen(HiveBoxes.dashboard)) {
        final dashboard = dashboardBox.values.map((dynamic d) {
          try {
            return {
              'totalTenants': (d as dynamic).totalTenants,
              'paidCount': (d as dynamic).paidCount,
              'unpaidCount': (d as dynamic).unpaidCount,
              'overdueCount': (d as dynamic).overdueCount,
            };
          } catch (_) {
            return d.toString();
          }
        }).toList();
        result['dashboard'] = dashboard;
      }

      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to export data: ${e.toString()}'));
    }
  }

  /// Writes exported JSON to a file and returns the file path.
  Future<Either<Failure, String>> exportAllToFile({
    String filename = 'rentmate_backup.json',
  }) async {
    try {
      final exportedEither = await exportAllDataToMap();
      return await exportedEither.fold(
        (failure) async => Left(failure),
        (map) async {
          final json = jsonEncode(map);
          final dir = await getApplicationDocumentsDirectory();
          final file = File('${dir.path}/$filename');
          await file.writeAsString(json);
          return Right(file.path);
        },
      );
    } catch (e) {
      return Left(CacheFailure('Failed to write backup file: ${e.toString()}'));
    }
  }

  /// Import/restore from a JSON Map (the same structure produced by exportAllDataToMap).
  /// This will overwrite matching entries (by id) and add new ones.
  Future<Either<Failure, void>> importFromMap(Map<String, dynamic> data, {bool clearBeforeImport = false}) async {
    try {
      if (!_initialized) {
        return Left(CacheFailure('Local storage not initialized.'));
      }

      if (clearBeforeImport) {
        await tenantsBox.clear();
        await paymentsBox.clear();
        if (Hive.isBoxOpen(HiveBoxes.dashboard)) {
          await dashboardBox.clear();
        }
      }

      // Import tenants
      final tenants = data['tenants'] as List<dynamic>? ?? [];
      for (final dynamic t in tenants) {
        if (t is Map<String, dynamic>) {
          final id = t['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
          await tenantsBox.put(id, t); // store Map; using Map keeps data accessible
          // If you prefer to re-create model objects, map them to model constructors here.
        }
      }

      // Import payments
      final payments = data['payments'] as List<dynamic>? ?? [];
      for (final dynamic p in payments) {
        if (p is Map<String, dynamic>) {
          final id = p['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
          // Convert date string back to DateTime if needed
          if (p['datePaid'] is String) {
            try {
              p['datePaid'] = DateTime.parse(p['datePaid']);
            } catch (_) {}
          }
          await paymentsBox.put(id, p);
        }
      }

      // Dashboard entries (optional)
      final dashboardEntries = data['dashboard'] as List<dynamic>? ?? [];
      if (dashboardEntries.isNotEmpty && Hive.isBoxOpen(HiveBoxes.dashboard)) {
        for (final dynamic d in dashboardEntries) {
          if (d is Map<String, dynamic>) {
            final key = DateTime.now().millisecondsSinceEpoch.toString();
            await dashboardBox.put(key, d);
          }
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to import data: ${e.toString()}'));
    }
  }

  /// Read JSON from a file and import it.
  Future<Either<Failure, void>> importFromFile(String filePath, {bool clearBeforeImport = false}) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return Left(CacheFailure('Backup file not found at $filePath'));
      }
      final content = await file.readAsString();
      final decoded = jsonDecode(content) as Map<String, dynamic>;
      return await importFromMap(decoded, clearBeforeImport: clearBeforeImport);
    } catch (e) {
      return Left(CacheFailure('Failed to import from file: ${e.toString()}'));
    }
  }

  /// Clear all data from the standard boxes (tenants, payments, dashboard).
  Future<Either<Failure, void>> clearAllData() async {
    try {
      await tenantsBox.clear();
      await paymentsBox.clear();
      if (Hive.isBoxOpen(HiveBoxes.dashboard)) {
        await dashboardBox.clear();
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear data: ${e.toString()}'));
    }
  }
}
