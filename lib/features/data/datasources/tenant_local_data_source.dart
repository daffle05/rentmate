import '../models/tenant_model.dart';

abstract class TenantLocalDataSource {
  Future<TenantModel> insertTenant(TenantModel tenant);
  Future<List<TenantModel>> getAllTenants();
  Future<TenantModel> updateTenant(TenantModel tenant);
  Future<void> deleteTenant(String id);
}
