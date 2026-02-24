class Forgetpassworderror {
  String error;

  Forgetpassworderror({required this.error});

  factory Forgetpassworderror.fromjson(json) {
    return Forgetpassworderror(error: json["message"] ?? "error");
  }
}
