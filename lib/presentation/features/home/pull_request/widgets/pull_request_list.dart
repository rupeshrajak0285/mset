

import 'package:shimmer/shimmer.dart';

import '../../../../../common_libraries.dart';

class PullRequestList extends StatelessWidget {
  final List<PullRequest> pullRequests;
  final PageStatus pageStatus;
  final String status;

  const PullRequestList({
    Key? key,
    required this.pullRequests,
    required this.pageStatus,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pageStatus == PageStatus.loading) {
      return _buildShimmerList();
    }
    if (pullRequests.isEmpty) {
      return const Center(
        child: Text("No pull requests found"),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: pullRequests.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final pr = pullRequests[index];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.shade100,
            backgroundImage: pr.user.avatarUrl.isNotEmpty
                ? NetworkImage(pr.user.avatarUrl)
                : null,
            child: pr.user.avatarUrl.isEmpty
                ? Text(
              pr.user.login.isNotEmpty
                  ? pr.user.login[0].toUpperCase()
                  : "",
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            )
                : null,
          ),
          title: Text(
            pr.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PR #${pr.number}", style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildStatusChip(status),
                  const SizedBox(width: 8),
                  Text(
                    "by ${pr.user.login} • ${_formatTime(pr.createdAt)}",
                    style:
                    const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 Status chip widget
  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;

    switch (status) {
      case "Open":
        bg = Colors.green.shade100;
        text = Colors.green.shade800;
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

  /// 🔹 Format created date (simple version)
  String _formatTime(String createdAt) {
    if (createdAt.isEmpty) return "";
    final date = DateTime.tryParse(createdAt);
    if (date == null) return createdAt;

    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) {
      return "${diff.inDays} days ago";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} hours ago";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes} minutes ago";
    } else {
      return "just now";
    }
  }
  /// 🔹 Shimmer effect while loading
  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: 6, // show 6 shimmer items
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListTile(
            leading: const CircleAvatar(radius: 20, backgroundColor: Colors.white),
            title: Container(height: 14, width: 120, color: Colors.white),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Container(height: 12, width: 80, color: Colors.white),
                const SizedBox(height: 4),
                Container(height: 12, width: 140, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
