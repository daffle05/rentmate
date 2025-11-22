import 'package:hive/hive.dart';
import 'package:rentmate/features/data/dashboards/dashboard_model.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
// Corrected import path
import 'package:rentmate/features/tenant/data/models/payment_model.dart'; // Import generated adapter

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }

  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(DashboardSummaryModelAdapter());
  }
}
