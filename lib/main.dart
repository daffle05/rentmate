import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
import 'core/theme/theme.dart';
import 'features/navigation/bottom_nav.dart';
import 'features/tenant/data/models/payment_model.dart';

// Providers for Hive boxes to use in Riverpod
final tenantBoxProvider = Provider<Box<TenantModel>>((ref) {
  return Hive.box<TenantModel>('tenants');
});

final paymentBoxProvider = Provider<Box<PaymentModel>>((ref) {
  return Hive.box<PaymentModel>('payments');
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  await registerHiveAdapters();

  // Open typed boxes
  await Hive.openBox<TenantModel>('tenants');
  await Hive.openBox<PaymentModel>('payments');
  await Hive.openBox('dashboard'); // dynamic box for simple key-values

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentMate',
      theme: buildAppTheme(),
      home: const BottomNav(),
    );
  }
}

// Example CRUD functions using Riverpod
class TenantRepository {
  final Box<TenantModel> box;

  TenantRepository(this.box);

  // CREATE
  Future<void> addTenant(TenantModel tenant) async {
    await box.put(tenant.id, tenant);
  }

  // READ all tenants
  List<TenantModel> getAllTenants() {
    return box.values.toList();
  }

  // READ by ID
  TenantModel? getTenant(String id) {
    return box.get(id);
  }

  // UPDATE
  Future<void> updateTenant(TenantModel tenant) async {
    await box.put(tenant.id, tenant);
  }

  // DELETE
  Future<void> deleteTenant(String id) async {
    await box.delete(id);
  }
}

class PaymentRepository {
  final Box<PaymentModel> box;

  PaymentRepository(this.box);

  // CREATE
  Future<void> addPayment(PaymentModel payment) async {
    await box.put(payment.id, payment);
  }

  // READ all payments
  List<PaymentModel> getAllPayments() {
    return box.values.toList();
  }

  // READ by tenantId
  List<PaymentModel> getPaymentsByTenant(String tenantId) {
    return box.values.where((p) => p.tenantId == tenantId).toList();
  }

  // UPDATE
  Future<void> updatePayment(PaymentModel payment) async {
    await box.put(payment.id, payment);
  }

  // DELETE
  Future<void> deletePayment(String id) async {
    await box.delete(id);
  }
}
