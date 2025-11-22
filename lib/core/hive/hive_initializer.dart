import 'package:hive/hive.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
import 'package:rentmate/features/data/models/payment_model.dart';
import 'package:rentmate/features/data/adapters/payment_model_adapter.dart'; // Ensure this is the correct path
import 'package:rentmate/features/data/dashboards/dashboard_model.dart';
import 'package:rentmate/features/data/adapters/dashboard_summary_model_adapter.dart'; // Ensure this is the correct path and contains DashboardSummaryModelAdapter
// If the adapter is not implemented, define it in the imported file.
import 'package:rentmate/features/tenant/data/models/payment_model.dart'; // Ensure this is the correct path or define the adapter

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(DashboardSummaryModelAdapter()); // Ensure DashboardSummaryModelAdapter is correctly imported and defined
  }
}
