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

  Future<List<GitCommit>> getCommitHistory() async {
    try {
      final response = await getRequest(BaseAPIUrls.commitHistoryUrl);

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          return (response.data as List)
              .cast<Map<String, dynamic>>()
              .map((json) => GitCommit.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected response format: expected a List");
        }
      } else {
        throw Exception("Failed to fetch commit history. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching commit history: $e");
    }
  }


}
