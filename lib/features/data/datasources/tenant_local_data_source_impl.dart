import 'package:hive/hive.dart';
import '../models/tenant_model.dart';
import 'tenant_local_data_source.dart';

class TenantLocalDataSourceImpl implements TenantLocalDataSource {
  final Box<TenantModel> tenantBox;

  TenantLocalDataSourceImpl(this.tenantBox);

  @override
  Future<TenantModel> insertTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
    return tenant;
  }

  @override
  Future<List<TenantModel>> getAllTenants() async {
    return tenantBox.values.toList();
  }

  @override
  Future<TenantModel> updateTenant(TenantModel tenant) async {
    await tenant.save();
    return tenant;
  }

  @override
  Future<void> deleteTenant(String id) async {
    await tenantBox.delete(id);
  }
}
