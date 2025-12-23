import 'package:flutter/material.dart';
import 'Pages/home_page.dart';
import 'Pages/profile_page.dart';
import 'Pages/budget_page.dart';
import 'Pages/stats_page.dart';

void main() {
  runApp(const MyApp());
}

List pages = [
  const HomePage(),
  const BudgetPage(),
  const StatsPage(),
  const ProfilePage(),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: "Budget",
          ),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: "Stats"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
