import 'package:flutter/material.dart';

void main() {
  runApp(const RentMateApp());
}

class RentMateApp extends StatelessWidget {
  const RentMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int _selectedIndex = 0;

  // Screens for 4 top features + placeholder for More
  static const List<Widget> _screens = [
    Center(child: Text('Dashboard')),
    Center(child: Text('Tenants')),
    Center(child: Text('Payments')),
    Center(child: Text('Reports')),
    MoreScreen(), // 5th "More" screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Tenants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

// "More" screen showing other features
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  final List<String> otherFeatures = const [
    'Settings',
    'Notifications',
    'Help',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More Features')),
      body: ListView.separated(
        itemCount: otherFeatures.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(otherFeatures[index]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to feature screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${otherFeatures[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}
