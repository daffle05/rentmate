import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';

// Import only your Hive adapters/models that exist
import 'core/hive/hive_initializer.dart'; // this should contain your adapter registration
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await registerHiveAdapters(); // Register your tenant/payment adapters

  await Hive.openBox<TenantModel>('tenants');
  await Hive.openBox('payments'); // can also use PaymentModel if you have it

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TenantsPage(),
    const PaymentsPage(),
    const DashboardPage(),
    const ReportsPage(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[600],
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tenants'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

// ------------------ Tenant Page ------------------
class TenantsPage extends StatefulWidget {
  const TenantsPage({super.key});

  @override
  State<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends State<TenantsPage> {
  late Box<TenantModel> tenantBox;

  @override
  void initState() {
    super.initState();
    tenantBox = Hive.box<TenantModel>('tenants');
  }

  void _addTenant() {
  final nameController = TextEditingController();
  final roomController = TextEditingController();
  final rentController = TextEditingController();
  final dueDateController = TextEditingController(); // Optional, can be added

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Tenant'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Tenant Name')),
          TextField(controller: roomController, decoration: const InputDecoration(labelText: 'Room')),
          TextField(controller: rentController, decoration: const InputDecoration(labelText: 'Rent'), keyboardType: TextInputType.number),
          TextField(controller: dueDateController, decoration: const InputDecoration(labelText: 'Due Date (day)'), keyboardType: TextInputType.number),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            // Use the same controllers created above, DO NOT re-declare them
            final tenant = TenantModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: nameController.text,
              roomNumber: roomController.text,
              rentAmount: double.tryParse(rentController.text) ?? 0.0,
              dueDate: int.tryParse(dueDateController.text) ?? 1,
            );

            tenantBox.put(tenant.id, tenant);
            setState(() {}); // refresh the list
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tenants')),
      body: ValueListenableBuilder(
        valueListenable: tenantBox.listenable(),
        builder: (context, Box<TenantModel> box, _) {
          final tenants = box.values.toList();
          if (tenants.isEmpty) return const Center(child: Text('No tenants yet'));

          return ListView.builder(
            itemCount: tenants.length,
            itemBuilder: (context, index) {
              final tenant = tenants[index];
              return ListTile(
                title: Text(tenant.name),
                subtitle: Text('Room: ${tenant.roomNumber} | Rent: ${tenant.rentAmount}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    tenantBox.delete(tenant.id);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTenant,
        child: const Icon(Icons.add),
      ),
    );
  }
}

mixin dueDateController {
  late String text;
}

// ------------------ Payments Page (placeholder) ------------------
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Payments CRUD goes here'));
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Dashboard'));
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Reports'));
  }
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});
  final List<String> otherFeatures = const ['Settings', 'Notifications', 'Support', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView.separated(
        itemCount: otherFeatures.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) => ListTile(title: Text(otherFeatures[index]), trailing: const Icon(Icons.chevron_right)),
      ),
    );
  }
}
