import '../../../../../common_libraries.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommitHistoryTabView extends StatefulWidget {
  const CommitHistoryTabView({super.key});

  @override
  State<CommitHistoryTabView> createState() => _CommitHistoryTabViewState();
}

class _CommitHistoryTabViewState extends State<CommitHistoryTabView> {
  @override
  void initState() {
    super.initState();
    context.read<PullRequestViewModelBloc>().add(FetchAllCommitHistory());
  }

  Future<void> _onRefresh() async {
    context.read<PullRequestViewModelBloc>().add(FetchAllCommitHistory());
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullRequestViewModelBloc, PullRequestViewModelState>(
      builder: (context, state) {
        if (state.pageStatus.isLoading) {
          // Shimmer loading effect
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (_, __) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 90,
                ),
              );
            },
          );
        }

        if (state.commitHistory.isEmpty) {
          return const Center(child: Text("No commits found."));
        }

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemCount: state.commitHistory.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final GitCommit commit = state.commitHistory[index];
              final author = commit.commit?.author ?? CommitAuthor();
              final avatarUrl = commit.author?.avatarUrl ?? '';
              final commitMessage = commit.commit?.message ?? 'No commit message';
              final isLatest = index == 0;

              return Card(
                elevation: 3,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Commit message + SHA chip
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              commitMessage,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Text(
                              commit.sha.isNotEmpty
                                  ? commit.sha.substring(0, 7)
                                  : '',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Author + avatar + date
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: avatarUrl.isNotEmpty
                                ? NetworkImage(avatarUrl)
                                : const AssetImage(
                                'assets/images/default_avatar.png')
                            as ImageProvider,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  author.name.isNotEmpty
                                      ? author.name
                                      : 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (author.email?.isNotEmpty ?? false)
                                  Text(
                                    author.email!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            _formatDate(author.date),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      if (isLatest) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Latest Commit",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
