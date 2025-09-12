part of 'pull_request_view_model_bloc.dart';


class PullRequestViewModelState extends Equatable {
  final PageStatus pageStatus;


  const PullRequestViewModelState({
    this.pageStatus = PageStatus.initial,

  });

  @override
  List<Object?> get props => [
    pageStatus,

  ];

  PullRequestViewModelState copyWith({
    PageStatus? pageStatus,

  }) {
    return PullRequestViewModelState(
      pageStatus: pageStatus ?? this.pageStatus,

    );
  }
}
