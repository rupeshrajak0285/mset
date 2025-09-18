import '../../common_libraries.dart';

class SignupRequestModel extends Equatable {
  final String name;
  final String email;
  final String username;
  final String password;
  final int grade;
  final bool checked;

  const SignupRequestModel({
    this.name = '',
    this.email = '',
    this.username = '',
    this.password = '',
    this.grade = 0,
    this.checked = false,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "username": username,
    "password": password,
    "grade": grade,
    "checked": checked,
  };

  @override
  List<Object?> get props => [name, email, username, password, grade, checked];
}
