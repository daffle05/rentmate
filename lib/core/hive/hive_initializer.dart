import 'package:hive/hive.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';

Future<void> registerHiveAdapters() async {
  // Use the same typeId as in TenantModelAdapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }
}
