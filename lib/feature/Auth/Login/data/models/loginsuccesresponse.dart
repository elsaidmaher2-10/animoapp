
import 'package:animoapp/feature/Auth/register/data/models/userResponsemodel.dart';

class Loginsuccesresponse {
  int statusCode;
  String message;
  String access_token;
  String refresh_token;

  User? user;
  Loginsuccesresponse({
    required this.access_token,
    required this.message,
    required this.refresh_token,
    required this.statusCode,
    required this.user,
  });
  factory Loginsuccesresponse.fromjosn(json) {
    return Loginsuccesresponse(
      access_token: json["access_token"],
      message: json["message"],
      refresh_token: json["refresh_token"],
      statusCode: json["statusCode"],
      user: json["user"] == null ? null : User.fromjson(json["user"]),
    );
  }
}