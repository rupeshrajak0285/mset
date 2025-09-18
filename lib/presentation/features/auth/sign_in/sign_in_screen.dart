import 'package:App/common_libraries.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get _isFormValid =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthViewModelBloc(context),
      child: BlocBuilder<AuthViewModelBloc, AuthViewModelState>(
        builder: (context, state) {
          if (Prefs.accessToken.get().isNotEmpty) {
            return const DashboardScreen();
          }
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AspirantCardWidget(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AspirantCardImageWidget(
                              imagePath: "assets/book.jpg"),
                          const SizedBox(height: 25),

                          const AspirantTitleWidget(
                            title: AppStrings.loginTitle,
                            subtitle: AppStrings.loginSubtitle,
                          ),
                          const SizedBox(height: 25),

                          AspirantTextFormField(
                            controller: _usernameController,
                            hint: AppStrings.usernameHint,
                            onChanged: (_) => setState(() {}),
                            icon: Icons.person,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return AppStrings.userNameRequired;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),

                          AspirantTextFormField(
                            controller: _passwordController,
                            hint: AppStrings.passwordHint,
                            icon: Icons.lock,
                            isPassword: true,
                            onChanged: (_) => setState(() {}),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return AppStrings.passwordRequired;
                              }
                              if (val.length < 6) {
                                return AppStrings.passwordTooShort;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),

                          AspirantLinkRow(
                            leftText: AppStrings.forgotUsername,
                            rightText: AppStrings.forgotPassword,
                            onLeftTap: () {},
                            onRightTap: () {},
                          ),
                          const SizedBox(height: 25),

                          /// ✅ Gradient Button with loading state
                          AspirantGradientButton(
                            text: AppStrings.loginButton,
                            isLoading: state.pageStatus.isLoading,
                            isEnabled:
                                _isFormValid ,
                            onPressed: () {
                              context.read<AuthViewModelBloc>().add(
                                  AuthViewModelLoginClickEvent(LoginRequestModel(
                                      email: _usernameController.text,
                                      password: _passwordController.text)));
                            },
                          ),
                          const SizedBox(height: 20),

                          AspirantSignUpRow(
                            text: AppStrings.dontHaveAccount,
                            actionText: AppStrings.signUpForFree,
                            onActionTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
