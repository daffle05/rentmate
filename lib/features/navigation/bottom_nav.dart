import 'package:flutter/material.dart';
import 'package:rentmate/features/presentation/dashboard_page.dart';
import '../tenant/presentation/pages/tenant_list_page.dart';
import '../tenant/presentation/payment_overview_page.dart';
import '../reports/presentation/reports_page.dart';
import '../more/more_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    TenantListPage(),
    PaymentOverviewPage(),
    ReportsPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Tenants",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: "Payments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "More",
          ),
        ],
      ),
    );
  }
}
