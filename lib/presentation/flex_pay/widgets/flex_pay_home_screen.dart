import 'package:flutter/material.dart';

import 'flex_pay_dashboard_screen.dart';
import 'flex_pey_wallet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    WalletScreen(),
    FlexPeyWallet(),
    CardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (_currentIndex == index) {
      // same page tapped → do nothing
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // show page by index
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF1F2937), // light grey border (adjust as needed)
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF111827),
          selectedItemColor: Color(0xFF22D3EE),
          unselectedItemColor: const Color(0xFF6B7280),
          currentIndex: _currentIndex,
          onTap: _onItemTapped, // handle navigation
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          ],
        ),
      ),
    );
  }
}



class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Chart Screen", style: TextStyle(color: Colors.white)),
    );
  }
}

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Card Screen", style: TextStyle(color: Colors.white)),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Screen", style: TextStyle(color: Colors.white)),
    );
  }
}
