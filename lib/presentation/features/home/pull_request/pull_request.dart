import '../../../../common_libraries.dart';
export 'widgets/widgets.dart';

class PullRequestScreen extends StatefulWidget {
  const PullRequestScreen({super.key});

  @override
  State<PullRequestScreen> createState() => _PullRequestScreenState();
}

class _PullRequestScreenState extends State<PullRequestScreen> {
  int selectedIndex = 0;

  final List<String> tabs = ["Commits","Open PR", "Closed PR"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => PullRequestViewModelBloc(context),
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0D1117) : Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 12),

            // ✅ Custom Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomTabBar(
                tabs: tabs,
                selectedIndex: selectedIndex,
                onTabSelected: (index) {
                  setState(() => selectedIndex = index);
                },
              ),
            ),

            const SizedBox(height: 12),

            // ✅ Tab Views
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: const [ CommitHistoryTabView(),OpenPullRequestTabView(), ClosePullRequestTabView()],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
