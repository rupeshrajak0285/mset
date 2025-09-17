import 'package:App/presentation/features/dashboard_page/widgets/dashboard_page.dart';

import '../../../common_libraries.dart';
export 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
     DashboardScreen(), // 👈 show Dashboard on index 0
    const Center(child: Text("History Page", style: TextStyle(fontSize: 22))),
    const Center(child: Text("Time Page", style: TextStyle(fontSize: 22))),
    const Center(child: Text("Profile Page", style: TextStyle(fontSize: 22))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFCC00),
      body: _pages[_selectedIndex], // 👈 display selected page
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFFFFCC00), // Yellow background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey.shade700,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 32),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history, size: 32),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time, size: 32),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 32),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
