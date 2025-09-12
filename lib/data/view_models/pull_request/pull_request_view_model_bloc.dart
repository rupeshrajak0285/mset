import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common_libraries.dart';

part 'pull_request_view_model_event.dart';
part 'pull_request_view_model_state.dart';

class PullRequestViewModelBloc extends Bloc<PullRequestViewModelEvent, PullRequestViewModelState> {
  final BuildContext context;
  PullRequestViewModelBloc(this.context) : super(const PullRequestViewModelState()) {
on<FetchApprovedPullRequests>(_onFetchApprovedPullRequests);
  }

  Future<void> _onFetchApprovedPullRequests(
      FetchApprovedPullRequests event,
      Emitter<PullRequestViewModelState> emit) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      var chatData = await repository.getChatData(userId);

      emit(state.copyWith(pageStatus: PageStatus.success, chatResponseModel: chatData));

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
