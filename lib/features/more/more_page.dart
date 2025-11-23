import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      "Backup & Restore",
      "Settings",
      "Export Data",
      "About RentMate",
      "Help & Support",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              items[index],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to actual screen later
            },
          );
        },
      ),
    );
  }
}
