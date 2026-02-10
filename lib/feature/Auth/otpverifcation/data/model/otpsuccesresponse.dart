import 'package:animoapp/feature/Auth/register/data/models/userResponsemodel.dart';

class OtpSuccessResponse {
  final int statusCode;
  final String message;
  final String accessToken;
  final String refreshToken;
  final User? user;

  OtpSuccessResponse({
    required this.accessToken,
    required this.message,
    required this.refreshToken,
    required this.statusCode,
    this.user,
  });

  factory OtpSuccessResponse.fromJson(Map<String, dynamic> json) {
    return OtpSuccessResponse(
      accessToken: json['access_token'] ?? "",
      message: json['message'] ?? "",
      refreshToken: json['refresh_token'] ?? "",
      statusCode: json["statusCode"] ?? 0,

      user: json["user"] != null ? User.fromjson(json["user"]) : null,
    );
  }

  @override
  String toString() {
    return '''
OtpSuccessResponse(
 statusCode: $statusCode,
 message: $message,
 accessToken: $accessToken,
 refreshToken: $refreshToken,
 user: $user
)
''';
  }
}
