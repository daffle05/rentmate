import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/hive/hive_initializer.dart';
import 'features/app/my_app.dart'; // Your main app widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register all Hive adapters
  await registerHiveAdapters();

  // Open required Hive boxes (Tenant + Payment)
  await Hive.openBox('tenants');
  await Hive.openBox('payments'); // <--- NEW payment box

  runApp(MyApp());
}
