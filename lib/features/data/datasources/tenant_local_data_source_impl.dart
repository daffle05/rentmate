import 'package:hive/hive.dart';
import '../models/tenant_model.dart';
import 'tenant_local_data_source.dart';

class TenantLocalDataSourceImpl implements TenantLocalDataSource {
  @override
  final Box<TenantModel> tenantBox;

  TenantLocalDataSourceImpl(this.tenantBox);

  Future<TenantModel> insertTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
    return tenant;
  }

  @override
  Future<void> addTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
  }

  @override
  List<TenantModel> get getAllTenants {
    return tenantBox.values.toList();
  }

  @override
  TenantModel? getTenant(String id) {
    return tenantBox.get(id);
  }

  @override
  Future<TenantModel> updateTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
    return tenant;
  }

  @override
  Future<void> deleteTenant(String id) async {
    await tenantBox.delete(id);
  }
}
