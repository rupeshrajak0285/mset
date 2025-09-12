import '../../common_libraries.dart';

class PullRequestRepository extends BaseRepository {
  /// Generic method to fetch pull requests by state
  Future<List<PullRequest>> getPullRequests({String state = "open"}) async {
    try {
      final response = await getRequest(
        "${BaseAPIUrls.pullRequestUrl}?state=$state",
      );

      if (response.statusCode == 200 && response.data != null) {
        // Convert response list into List<PullRequest>
        return (response.data as List)
            .map((json) => PullRequest.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to fetch pull requests: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching pull requests: $e");
    }
  }

  /// Fetch open pull requests
  Future<List<PullRequest>> getOpenPullRequests() =>
      getPullRequests(state: "open");

  /// Fetch closed pull requests
  Future<List<PullRequest>> getClosedPullRequests() =>
      getPullRequests(state: "closed");

  /// Fetch all pull requests (open + closed)
  Future<List<PullRequest>> getAllPullRequests() =>
      getPullRequests(state: "all");

  /// Fetch merged pull requests (special case of closed)
  Future<List<PullRequest>> getMergedPullRequests() async {
    final closedPRs = await getClosedPullRequests();
    return closedPRs.where((pr) => pr.mergedAt != null).toList();
  }

  /// Fetch only "closed but not merged" pull requests
  Future<List<PullRequest>> getOnlyClosedNotMergedPullRequests() async {
    final closedPRs = await getClosedPullRequests();
    return closedPRs.where((pr) => pr.mergedAt == null).toList();
  }
}
