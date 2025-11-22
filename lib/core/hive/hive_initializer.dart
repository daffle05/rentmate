import 'package:hive/hive.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart'; // Ensure this is the correct path or define the adapter

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(DashboardSummaryModelAdapter() as TypeAdapter); // Ensure DashboardSummaryModelAdapter is correctly imported and defined
  }
}

class DashboardSummaryModelAdapter {
}
