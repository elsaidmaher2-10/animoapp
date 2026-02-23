class Failuerresponse {
  int statusCode;
  List<String> error;
  Failuerresponse({required this.error, required this.statusCode});

  factory Failuerresponse.fromjson(json) {
    print(json);
    return Failuerresponse(
      error: List<String>.from((json["error"])),
      statusCode: json["statusCode"],
    );
  }
}
