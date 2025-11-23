import 'package:hive/hive.dart';
import '../models/tenant_model.dart';

class TenantLocalDataSource {
  final Box<TenantModel> tenantBox;

  TenantLocalDataSource(this.tenantBox);

  // CREATE
  Future<void> addTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
  }

  // READ ALL
  List<TenantModel> get getAllTenants {
    return tenantBox.values.toList();
  }

  // READ ONE
  TenantModel? getTenant(String id) {
    return tenantBox.get(id);
  }

  // UPDATE
  Future<void> updateTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
  }

  // DELETE
  Future<void> deleteTenant(String id) async {
    await tenantBox.delete(id);
  }

  Future insertTenant(TenantModel tenant) async {}
}
