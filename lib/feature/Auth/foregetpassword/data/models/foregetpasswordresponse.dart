class Forgetpassworduccesresponse {
  int statusCode;
  String message;
  Forgetpassworduccesresponse({
    required this.message,
    required this.statusCode,
  });
  factory Forgetpassworduccesresponse.fromjosn(json) {
    return Forgetpassworduccesresponse(
      message: json["message"],
      statusCode: json["statusCode"] ?? 0,
    );
  }
}
