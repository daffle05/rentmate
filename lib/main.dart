import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';

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

  // ------------------ Add or Edit Tenant ------------------
  void _showTenantDialog({TenantModel? tenant}) {
    final nameController = TextEditingController(text: tenant?.name ?? '');
    final roomController = TextEditingController(text: tenant?.roomNumber ?? '');
    final rentController = TextEditingController(text: tenant != null ? tenant.rentAmount.toString() : '');
    final dueDateController = TextEditingController(text: tenant != null ? tenant.dueDate.toString() : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tenant == null ? 'Add Tenant' : 'Edit Tenant'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Tenant Name')),
              TextField(controller: roomController, decoration: const InputDecoration(labelText: 'Room')),
              TextField(controller: rentController, decoration: const InputDecoration(labelText: 'Rent'), keyboardType: TextInputType.number),
              TextField(controller: dueDateController, decoration: const InputDecoration(labelText: 'Due Date (day)'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newTenant = TenantModel(
                id: tenant?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                roomNumber: roomController.text,
                rentAmount: double.tryParse(rentController.text) ?? 0.0,
                dueDate: int.tryParse(dueDateController.text) ?? 1,
              );

              tenantBox.put(newTenant.id, newTenant);
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ------------------ Delete Tenant ------------------
  void _deleteTenant(String id) {
    tenantBox.delete(id);
    setState(() {});
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
                subtitle: Text('Room: ${tenant.roomNumber} | Rent: \$${tenant.rentAmount.toStringAsFixed(2)} | Due: ${tenant.dueDate}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _showTenantDialog(tenant: tenant),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTenant(tenant.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTenantDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
