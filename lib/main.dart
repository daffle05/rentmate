import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/hive/hive_initializer.dart';
import 'core/theme/theme.dart'; // Theme import

void main() async {
WidgetsFlutterBinding.ensureInitialized();

// Initialize Hive
await Hive.initFlutter();

// Register all Hive adapters
await registerHiveAdapters();

// Open Hive boxes
await Hive.openBox('tenants');
await Hive.openBox('payments');

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
textTheme: GoogleFonts.latoTextTheme(), // Google Fonts applied
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
const Center(child: Text('Tenants Page')),
const Center(child: Text('Payments Page')),
const Center(child: Text('Dashboard Page')),
const Center(child: Text('Reports Page')),
const MoreScreen(), // The 5th "More" page
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
onTap: (index) {
setState(() {
_currentIndex = index;
});
},
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

class MoreScreen extends StatelessWidget {
const MoreScreen({super.key});

final List<String> otherFeatures = const [
'Settings',
'Notifications',
'Support',
'Profile',
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('More')),
body: ListView.separated(
itemCount: otherFeatures.length,
separatorBuilder: (context, index) => const Divider(),
itemBuilder: (context, index) {
return ListTile(
title: Text(otherFeatures[index], style: GoogleFonts.roboto()),
trailing: const Icon(Icons.chevron_right),
onTap: () {
// TODO: Navigate to respective feature pages
},
);
},
),
);
}
}
