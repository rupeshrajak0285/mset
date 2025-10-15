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
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final pr = pullRequests[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22,
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
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PR title
                      Text(
                        pr.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),

                      // Metadata row
                      Row(
                        children: [
                          Icon(Icons.tag, size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            "${pr.number}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 12),
                          _buildStatusChip(status),
                          const SizedBox(width: 12),
                          Icon(Icons.schedule,
                              size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(pr.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),
                      Text(
                        "by ${pr.user.login}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  /// 🔹 Format created date
  String _formatTime(String createdAt) {
    if (createdAt.isEmpty) return "";
    final date = DateTime.tryParse(createdAt);
    if (date == null) return createdAt;

    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) {
      return "${diff.inDays}d ago";
    } else if (diff.inHours > 0) {
      return "${diff.inHours}h ago";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}m ago";
    } else {
      return "just now";
    }
  }

  /// 🔹 Shimmer effect while loading
  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const CircleAvatar(
                      radius: 22, backgroundColor: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 14, width: 180, color: Colors.white),
                        const SizedBox(height: 8),
                        Container(height: 12, width: 120, color: Colors.white),
                        const SizedBox(height: 6),
                        Container(height: 12, width: 80, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
