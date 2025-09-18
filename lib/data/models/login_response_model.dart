class LoginResponseModel {
  final bool isVerified;
  final String profileImage;
  final String token;
  final String userRole;
  final String username;
  final int yearGrade;

  LoginResponseModel({
    this.isVerified = false,
    this.profileImage = "",
    this.token = "",
    this.userRole = "",
    this.username = "",
    this.yearGrade = 0,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      isVerified: json["isverified"] ?? false,
      profileImage: json["profile_image"] ?? "",
      token: json["token"] ?? "",
      userRole: json["user_role"] ?? "",
      username: json["username"] ?? "",
      yearGrade: json["yeargrade"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isverified": isVerified,
      "profile_image": profileImage,
      "token": token,
      "user_role": userRole,
      "username": username,
      "yeargrade": yearGrade,
    };
  }
}
