part of 'pull_request_view_model_bloc.dart';

class PullRequestViewModelEvent {}
/// ✅ Fetch Open PRs
class FetchOpenPullRequests extends PullRequestViewModelEvent {}

/// ✅ Fetch Closed PRs
class FetchClosedPullRequests extends PullRequestViewModelEvent {}