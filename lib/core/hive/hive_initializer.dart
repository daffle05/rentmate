import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart';

import '../../features/data/models/tenant_model.dart';

class HiveInitializer {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(TenantModelAdapter());
    Hive.registerAdapter(PaymentModelAdapter());

    // Open boxes
    await Hive.openBox<TenantModel>('tenants');
    await Hive.openBox<PaymentModel>('payments');
  }
}
