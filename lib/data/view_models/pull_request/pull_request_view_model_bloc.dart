import 'package:App/data/repositories/pull_request_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common_libraries.dart';

part 'pull_request_view_model_event.dart';

part 'pull_request_view_model_state.dart';

class PullRequestViewModelBloc
    extends Bloc<PullRequestViewModelEvent, PullRequestViewModelState> {
  final BuildContext context;
  late PullRequestRepository repository;

  PullRequestViewModelBloc(this.context)
      : super(const PullRequestViewModelState()) {
    repository = RepositoryProvider.of(context);
    on<FetchOpenPullRequests>(_onFetchOpenPullRequests);
    on<FetchClosedPullRequests>(_onFetchClosedPullRequests);
    on<FetchAllCommitHistory>(_onFetchAllCommitHistory);
  }

  Future<void> _onFetchOpenPullRequests(FetchOpenPullRequests event,
      Emitter<PullRequestViewModelState> emit) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      var pullRequests = await repository.getOpenPullRequests();

      emit(state.copyWith(pageStatus: PageStatus.success, openPullRequests: pullRequests));
    } catch (ex) {
      emit(state.copyWith(pageStatus: PageStatus.failure));
      AppToaster(
        context: context,
        notifyType: AppNotifyType.error,
        content: ex.toString(),
      ).show();
    }
  }

  Future<void> _onFetchClosedPullRequests(FetchClosedPullRequests event,
      Emitter<PullRequestViewModelState> emit) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      var pullRequests = await repository.getClosedPullRequests();
      emit(state.copyWith(pageStatus: PageStatus.success, closePullRequests: pullRequests));
    } catch (ex) {
      emit(state.copyWith(pageStatus: PageStatus.failure));
      AppToaster(
        context: context,
        notifyType: AppNotifyType.error,
        content: ex.toString(),
      ).show();
    }
  }
  Future<void> _onFetchAllCommitHistory(FetchAllCommitHistory event,
      Emitter<PullRequestViewModelState> emit) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      var commitHistory = await repository.getCommitHistory();
      emit(state.copyWith(pageStatus: PageStatus.success, commitHistory: commitHistory));
    } catch (ex) {
      emit(state.copyWith(pageStatus: PageStatus.failure));
      AppToaster(
        context: context,
        notifyType: AppNotifyType.error,
        content: ex.toString(),
      ).show();
    }
  }
}
