part of 'pull_request_view_model_bloc.dart';

class PullRequestViewModelEvent {}
/// ✅ Event for fetching Approved Pull Requests
class FetchApprovedPullRequests extends PullRequestViewModelEvent {}

/// ✅ Event for fetching Pending Pull Requests
class FetchPendingPullRequests extends PullRequestViewModelEvent {}

/// ✅ Event for fetching Closed Pull Requests
class FetchClosedPullRequests extends PullRequestViewModelEvent {}