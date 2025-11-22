import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/hive/hive_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await registerHiveAdapters();
  await Hive.openBox('tenants');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body: Center(child: Text('Hello RentMate!')),
      ),
    );
  }
}
