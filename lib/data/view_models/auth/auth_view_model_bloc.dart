import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common_libraries.dart';

part 'auth_view_model_event.dart';
part 'auth_view_model_state.dart';

class AuthViewModelBloc extends Bloc<AuthViewModelEvent, AuthViewModelState> {
  final BuildContext context;
  late AuthRepository authRepository;
  AuthViewModelBloc(this.context) : super(const AuthViewModelState()) {
    authRepository = RepositoryProvider.of(context);
    on<AuthViewModelLoginClickEvent>(_onAuthViewModelLoginClickEvent);
    on<AuthViewModelLogOutClickEvent>(_onAuthViewModelLogOutClickEvent);
    on<AuthViewModelSignupClickEvent>(_onAuthViewModelSignupClickEvent);
  }

  Future<void> _onAuthViewModelLoginClickEvent(
      AuthViewModelLoginClickEvent event,
      Emitter<AuthViewModelState> emit) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      var loginResponse = await authRepository.userLogin(event.loginRequestModel);

     // Save values from flat response
      Prefs.accessToken.set(loginResponse.token);
      Prefs.givenName.set(loginResponse.username);
      Prefs.userRole.set(loginResponse.userRole);


      emit(state.copyWith(pageStatus: PageStatus.success, loginResponseData: loginResponse));

    } catch (ex) {
      emit(state.copyWith(pageStatus: PageStatus.success));
      AppToaster(
        context: context,
        notifyType: AppNotifyType.error,
        content: ex.toString(),
      ).show();
    }
  }
  Future<void> _onAuthViewModelSignupClickEvent(
      AuthViewModelSignupClickEvent event,
      Emitter<AuthViewModelState> emit,
      ) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));

      // Call API
      var signupResponse =
      await authRepository.userSignup(event.signupRequestModel);

      // Save values from response (if API returns token, user info, etc.)
      Prefs.accessToken.set(signupResponse.token ?? '');
      Prefs.givenName.set(signupResponse.username ?? '');
      Prefs.userRole.set(signupResponse.userRole ?? '');

      emit(state.copyWith(
        pageStatus: PageStatus.success,
        loginResponseData: signupResponse,
      ));
    } catch (ex) {
      emit(state.copyWith(pageStatus: PageStatus.failure));
      AppToaster(
        context: context,
        notifyType: AppNotifyType.error,
        content: ex.toString(),
      ).show();
    }
  }

  void _onAuthViewModelLogOutClickEvent(
      AuthViewModelLogOutClickEvent event,
      Emitter<AuthViewModelState> emit){
  Prefs.clear();
  AppToaster(
    context: context,
    notifyType: AppNotifyType.success,
    content: "Logout successfully",
  ).show();
  emit(state.copyWith(pageStatus: PageStatus.success, isLogout: true));
  }

}
