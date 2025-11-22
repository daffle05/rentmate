import 'package:hive/hive.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
import 'package:rentmate/features/data/models/payment_model.dart';
import 'package:rentmate/features/data/dashboards/dashboard_model.dart';

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
