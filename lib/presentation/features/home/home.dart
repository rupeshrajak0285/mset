import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common_libraries.dart';

/// Dashboard Screen showing user info, dashboard cards, and latest news
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userName = "";

  /// Dummy data for latest news section
  final List<Map<String, String>> _dummyNews = List.generate(
    5,
        (index) => {
      "title": "News Title ${index + 1}",
      "description": "This is a brief description for news ${index + 1}.",
      "image": "https://picsum.photos/seed/news${index + 1}/200/120",
    },
  );

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setStatusBar();
  }

  /// Load user name from preferences
  Future<void> _loadUserName() async {
    final name = await Prefs.givenName.get() ?? AppStrings.defaultUserName;
    setState(() => _userName = name);
  }

  /// Set the status bar color and icon brightness
  void _setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Clear user data and navigate to sign-in screen
  void _logout(BuildContext context) {
    Prefs.accessToken.clear();
    Prefs.userId.clear();
    Prefs.givenName.clear();
    Prefs.userRole.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SignInScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUserInfoCard(),
            const SizedBox(height: 24),
            _buildDashboardGrid(),
            const SizedBox(height: 24),
            _buildLatestNewsSection(),
          ],
        ),
      ),
    );
  }

  /// AppBar with title and logout button
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(AppStrings.dashboardTitle),
      backgroundColor: Colors.orange,
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: AppStrings.logout,
          onPressed: () => _logout(context),
        ),
      ],
    );
  }

  /// User Info Card with gradient background and action buttons
  Widget _buildUserInfoCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade300, Colors.orange.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade300.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: Colors.white,
                child: Text(
                  _userName.isNotEmpty ? _userName[0].toUpperCase() : "U",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(child: _buildUserDetails()),
            ],
          ),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  /// User details: name, centre, and account balance
  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _userName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            text: AppStrings.centre,
            style: const TextStyle(color: Colors.white70),
            children: [
              TextSpan(
                text: AppStrings.defaultCentre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text.rich(
          TextSpan(
            text: AppStrings.accountBalance,
            style: const TextStyle(color: Colors.white70),
            children: const [
              TextSpan(
                text: "£0.00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Action buttons under user info card
  Widget _buildActionButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _buildActionButton(
          icon: Icons.assignment,
          label: AppStrings.assessment,
          onPressed: () {},
        ),
        _buildActionButton(
          icon: Icons.build,
          label: AppStrings.buildSkill,
          onPressed: () {},
        ),
      ],
    );
  }

  /// Reusable action button widget
  ElevatedButton _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        elevation: 4,
      ),
    );
  }

  /// Dashboard grid cards
  Widget _buildDashboardGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      children: const [
        DashboardCard(
          title: AppStrings.physicalMockTest,
          icon: Icons.fitness_center,
          child: Text(AppStrings.noPhysicalMockTest),
        ),
        DashboardCard(
          title: AppStrings.gamePerformance,
          icon: Icons.sports_esports,
          child: Text(AppStrings.noGamePlayed),
        ),
        DashboardCard(
          title: AppStrings.skillsProgress,
          icon: Icons.auto_graph,
          child: Text(AppStrings.noDataAvailable),
        ),
        DashboardCard(
          title: AppStrings.onlineTest,
          icon: Icons.quiz,
          child: Text(AppStrings.noOnlineTest),
        ),
      ],
    );
  }

  /// Latest News section with dummy data
  Widget _buildLatestNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.latestNews,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _dummyNews.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final news = _dummyNews[index];
              return _buildNewsCard(news);
            },
          ),
        ),
      ],
    );
  }

  /// Individual news card
  Widget _buildNewsCard(Map<String, String> news) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.network(
              news["image"]!,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news["title"]!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  news["description"]!,
                  style:
                  const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable Dashboard Card widget
class DashboardCard extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: Colors.orange.shade100,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.orange, size: 28),
              const SizedBox(height: 10),
            ],
            Text(
              title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
