import '../../common_libraries.dart';

class LoginRequestModel extends Equatable {
  final String email;
  final String password;


  const LoginRequestModel({
     this.email='',
     this.password='',

  });

  Map<String, dynamic> toJson() => {
    "username": email,
    "password": password,
  };

  @override
  List<Object?> get props => [email, password];
}
