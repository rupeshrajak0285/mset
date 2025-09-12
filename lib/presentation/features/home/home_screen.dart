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
              backgroundImage:
                   const NetworkImage("https://avatars.githubusercontent.com/u/183290071?v=4"),
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

  /// ✅ GitHub shimmer loader

}
