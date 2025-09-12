import '../../../../common_libraries.dart';

class PullRequestScreen extends StatefulWidget {
  const PullRequestScreen({super.key});

  @override
  State<PullRequestScreen> createState() => _PullRequestScreenState();
}

class _PullRequestScreenState extends State<PullRequestScreen> {
  int selectedIndex = 0;

  final List<String> tabs = ["Approved", "Pending", "Closed"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
              children: [
                _buildList("Approved"),
                _buildList("Pending"),
                _buildList("Closed"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(String status) {
    // fake PRs
    final prs = List.generate(6, (i) => {
      "title": "Fix bug in authentication flow #$i",
      "subtitle": "feature/auth → main",
      "author": "RupeshRajak",
      "time": "${i + 1} days ago",
      "status": status,
    });

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: prs.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final pr = prs[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              pr["author"]![0].toUpperCase(),
              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            pr["title"]!,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pr["subtitle"]!, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildStatusChip(pr["status"]!),
                  const SizedBox(width: 8),
                  Text(
                    "by ${pr["author"]} • ${pr["time"]}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;

    switch (status) {
      case "Approved":
        bg = Colors.green.shade100;
        text = Colors.green.shade800;
        break;
      case "Pending":
        bg = Colors.orange.shade100;
        text = Colors.orange.shade800;
        break;
      case "Closed":
        bg = Colors.red.shade100;
        text = Colors.red.shade800;
        break;
      default:
        bg = Colors.grey.shade200;
        text = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }
}
