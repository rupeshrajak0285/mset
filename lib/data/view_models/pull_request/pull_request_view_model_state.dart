part of 'pull_request_view_model_bloc.dart';

class PullRequestViewModelState extends Equatable {
  final PageStatus pageStatus;
  final List<PullRequest> openPullRequests;
  final List<PullRequest> closePullRequests;
  final String? errorMessage;

  const PullRequestViewModelState({
    this.pageStatus = PageStatus.initial,
    this.openPullRequests = const [],
    this.closePullRequests = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    pageStatus,
    openPullRequests,
    closePullRequests,
    errorMessage,
  ];

  PullRequestViewModelState copyWith({
    PageStatus? pageStatus,
    List<PullRequest>? openPullRequests,
    List<PullRequest>? closePullRequests,
    String? errorMessage,
  }) {
    return PullRequestViewModelState(
      pageStatus: pageStatus ?? this.pageStatus,
      openPullRequests: openPullRequests ?? this.openPullRequests,
      closePullRequests: closePullRequests ?? this.closePullRequests,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
