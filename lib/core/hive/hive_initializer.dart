// lib/core/hive/hive_initializer.dart

import 'package:hive/hive.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';

Future<void> registerHiveAdapters() async {
  // Register TenantModel adapter
  if (!Hive.isAdapterRegistered(TenantModelAdapter().typeId)) {
    Hive.registerAdapter(TenantModelAdapter());
  }

  // Register PaymentModel adapter
  if (!Hive.isAdapterRegistered(PaymentModelAdapter().typeId)) {
    Hive.registerAdapter(PaymentModelAdapter() as TypeAdapter<dynamic>);
  }
}

extension on PaymentModelAdapter {
  int get typeId => null;
}

class PaymentModelAdapter {
}
