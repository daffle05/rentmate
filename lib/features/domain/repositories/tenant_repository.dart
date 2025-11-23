import 'package:rentmate/features/data/datasources/tenant_local_data_source.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';


class TenantRepository {
  final TenantLocalDataSource datasource;

  TenantRepository(this.datasource);

  Future<void> addTenant(TenantModel tenant) => datasource.addTenant(tenant);

  List<TenantModel> getTenants() => datasource.getAllTenants;

  TenantModel? getTenantById(String id) => datasource.getTenant(id);

  Future<void> updateTenant(TenantModel tenant) =>
      datasource.updateTenant(tenant);

  Future<void> deleteTenant(String id) => datasource.deleteTenant(id);
}
