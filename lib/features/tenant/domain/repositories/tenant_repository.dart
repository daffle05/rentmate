import 'package:dartz/dartz.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
import '../../../../core/error/failure.dart';


abstract class TenantRepository {
  Future<Either<Failure, TenantModel>> addTenant(TenantModel tenant);
  Future<Either<Failure, List<TenantModel>>> getAllTenants();
  Future<Either<Failure, TenantModel>> updateTenant(TenantModel tenant);
  Future<Either<Failure, bool>> deleteTenant(String id);
}
