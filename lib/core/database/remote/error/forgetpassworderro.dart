class Forgetpassworderror {
  String error;

  Forgetpassworderror({required this.error});

  factory Forgetpassworderror.fromjson(json) {
    print(json);
    return Forgetpassworderror(error: json["message"] ?? "error");
  }
}
