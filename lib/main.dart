import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/hive/hive_initializer.dart';
// Your main app widget

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      home: Scaffold(
        appBar: AppBar(
          title: Text('RentMate Home'),
        ),
        body: Center(
          child: Text('Welcome to RentMate!'),
        ),
      ),
    );
  }
}
