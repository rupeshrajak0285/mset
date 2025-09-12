import 'package:App/common_libraries.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = Prefs.givenName.get();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // GitHub dark colors
    final bgColor = isDarkMode ? const Color(0xFF0D1117) : Colors.blue.shade50;
    final appBarColor = isDarkMode ? const Color(0xFF161B22) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Hi, Rupesh Rajak",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? const Color(0xFFC9D1D9)
                      : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: isDarkMode
                  ? const Color(0xFF8B949E)
                  : Colors.black87,
            ),
            tooltip: "Logout",
            onPressed: () {
              context.read<AuthViewModelBloc>().add(
                AuthViewModelLogOutClickEvent(),
              );
            },
          ),
        ],
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const PullRequestScreen(),
        ),
      ),
    );
  }

  // ✅ GitHub shimmer loader
  Widget _buildShimmerList(bool isDarkMode) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
          highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
          child: ListTile(
            leading: const CircleAvatar(radius: 20, backgroundColor: Colors.white),
            title: Container(
              height: 14,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
            subtitle: Container(
              height: 12,
              width: 120,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        );
      },
    );
  }
}
