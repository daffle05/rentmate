import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/hive/hive_initializer.dart';
import 'core/theme/theme.dart'; // <--- Theme import


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register all Hive adapters
  await registerHiveAdapters();

  // Open Hive boxes
  await Hive.openBox('tenants');
  await Hive.openBox('payments');

  runApp(const MyApp()); // <--- FIXED (added const correctly)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // <--- FIXED constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // <--- Applying your theme here
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RentMate Home'),
        ),
        body: const Center(
          child: Text(
            'Welcome to RentMate!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
