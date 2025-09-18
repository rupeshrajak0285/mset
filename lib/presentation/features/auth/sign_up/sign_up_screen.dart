import '../../../../common_libraries.dart';

/// Signup Screen where user can register a child account
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  /// 🔹 Form key to validate the form
  final _formKey = GlobalKey<FormState>();

  /// 🔹 Text controllers for input fields
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// 🔹 List of grades for dropdown
  final List<String> _grades = [
    AppStrings.selectGradeHint,
    AppStrings.grade1,
    AppStrings.grade2,
    AppStrings.grade3,
    AppStrings.grade4,
    AppStrings.grade5,
  ];

  /// 🔹 Selected grade value
  String _selectedGrade = AppStrings.selectGradeHint;

  /// 🔹 Checkbox state for terms agreement
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    /// 🔹 Listen to all text fields to update the button state dynamically
    _childNameController.addListener(_refresh);
    _emailController.addListener(_refresh);
    _usernameController.addListener(_refresh);
    _passwordController.addListener(_refresh);
    _confirmPasswordController.addListener(_refresh);
  }

  /// 🔹 Refresh UI
  void _refresh() => setState(() {});

  @override
  void dispose() {
    _childNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// 🔹 Check if the form is valid to enable the signup button
  bool get _isFormValid {
    return _childNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text &&
        _selectedGrade != AppStrings.selectGradeHint &&
        _isChecked;
  }

  /// 🔹 Handle signup button press
  Future<void> _onSignup(BuildContext blocContext) async {
    if (!_formKey.currentState!.validate()) return;

    final signupRequestModel = SignupRequestModel(
      name: _childNameController.text.trim(),
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      grade: int.tryParse(_selectedGrade.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      checked: _isChecked,
    );

    blocContext
        .read<AuthViewModelBloc>()
        .add(AuthViewModelSignupClickEvent(signupRequestModel));
  }


  /// 🔹 Validator for email field
  String? _validateEmail(String? val) {
    if (val == null || val.isEmpty) return AppStrings.emailRequired;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(val)) return AppStrings.invalidEmail;
    return null;
  }

  /// 🔹 Validator for password fields
  String? _validatePassword(String? val) {
    if (val == null || val.isEmpty) return AppStrings.passwordRequired;
    if (val.length < 6) return AppStrings.passwordTooShort;
    return null;
  }

  /// 🔹 Validator for confirm password
  String? _validateConfirmPassword(String? val) {
    if (val == null || val.isEmpty) return AppStrings.confirmPasswordRequired;
    if (val != _passwordController.text) return AppStrings.passwordsNotMatch;
    return null;
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
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: AspirantCardWidget(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// 🔹 Top Image
                        const AspirantCardImageWidget(
                          imagePath: "assets/student.jpg",
                          height: 200,
                        ),
                        const SizedBox(height: 25),

                        /// 🔹 Title and subtitle
                        const AspirantTitleWidget(
                          title: AppStrings.signupTitle,
                          subtitle: AppStrings.signupSubtitle,
                        ),
                        const SizedBox(height: 25),

                        /// 🔹 Child Name
                        AspirantTextFormField(
                          controller: _childNameController,
                          hint: AppStrings.childNameHint,
                          icon: Icons.person_outline,
                          validator: (val) => val == null || val.isEmpty
                              ? AppStrings.childNameRequired
                              : null,
                        ),
                        const SizedBox(height: 18),

                        /// 🔹 Email
                        AspirantTextFormField(
                          controller: _emailController,
                          hint: AppStrings.emailHint,
                          icon: Icons.email_outlined,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 18),

                        /// 🔹 Username
                        AspirantTextFormField(
                          controller: _usernameController,
                          hint: AppStrings.usernameHint,
                          icon: Icons.person,
                          validator: (val) => val == null || val.isEmpty
                              ? AppStrings.usernameRequired
                              : null,
                        ),
                        const SizedBox(height: 18),

                        /// 🔹 Password
                        AspirantTextFormField(
                          controller: _passwordController,
                          hint: AppStrings.passwordHint,
                          icon: Icons.lock,
                          isPassword: true,
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 18),

                        /// 🔹 Confirm Password
                        AspirantTextFormField(
                          controller: _confirmPasswordController,
                          hint: AppStrings.confirmPasswordHint,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          validator: _validateConfirmPassword,
                        ),
                        const SizedBox(height: 18),

                        /// 🔹 Grade Dropdown
                        AspirantDropdown(
                          items: _grades,
                          value: _selectedGrade,
                          onChanged: (val) {
                            if (val != null)
                              setState(() => _selectedGrade = val);
                          },
                          hint: AppStrings.selectGradeHint,
                        ),
                        const SizedBox(height: 18),

                        /// 🔹 Terms and Conditions Checkbox
                        AspirantCheckbox(
                          value: _isChecked,
                          onChanged: (val) =>
                              setState(() => _isChecked = val ?? false),
                          textSpans: const [
                            TextSpan(text: AppStrings.agreeText1),
                            TextSpan(
                              text: AppStrings.terms,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: AppStrings.andText),
                            TextSpan(
                              text: AppStrings.privacy,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        /// 🔹 Signup Button
                        AspirantGradientButton(
                          text: AppStrings.signupButton,
                          isLoading: state.pageStatus.isLoading,
                          isEnabled: _isFormValid,
                          onPressed: () {
                            _onSignup(context); // pass context from inside BlocProvider
                          },
                        ),
                        const SizedBox(height: 20),

                        const SizedBox(height: 20),

                        /// 🔹 Row for sign up / login prompt
                        AspirantSignUpRow(
                          text: "Already have an account ? ",
                          actionText: " Login",
                          onActionTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
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
