import 'package:dartz/dartz.dart';
import 'package:rentmate/features/tenant/domain/repositories/tenant_repository.dart';
import '../../../../core/error/failure.dart';
import '../datasources/tenant_local_data_source.dart';
import '../models/tenant_model.dart';

class TenantRepositoryImpl implements TenantRepository {
  final TenantLocalDataSource localDataSource;

  TenantRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, TenantModel>> addTenant(TenantModel tenant) async {
    try {
      final result = await localDataSource.insertTenant(tenant);
      return Right(result); // Ensure a boolean value is returned
    } catch (_) {
      return Left(CacheFailure('Failed to insert tenant.'));
    }
  }

  @override
  Future<Either<Failure, List<TenantModel>>> getAllTenants() async {
    try {
      final result = await localDataSource.getAllTenants;
      return Right(result);
    } catch (_) {
      return Left(CacheFailure('Failed to load tenants.'));
    }
  }

  @override
  Future<Either<Failure, TenantModel>> updateTenant(TenantModel tenant) async {
    try {
      await localDataSource.updateTenant(tenant);
      return Right(tenant);
    } catch (_) {
      return Left(CacheFailure('Failed to update tenant.'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTenant(String id) async {
    try {
      await localDataSource.deleteTenant(id);
      return Right(true);
    } catch (_) {
      return Left(CacheFailure('Failed to delete tenant.'));
    }
  }
}
