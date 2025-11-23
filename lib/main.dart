import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/hive/hive_initializer.dart';
import 'core/theme/theme.dart';
import 'features/navigation/bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await registerHiveAdapters();

  await Hive.openBox('tenants');
  await Hive.openBox('payments');
  await Hive.openBox('dashboard');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentMate',
      theme: buildAppTheme(), // FIXED
      home: const BottomNav(),
    );
  }
}
