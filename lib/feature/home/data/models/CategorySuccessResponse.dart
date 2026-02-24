class Categorysuccessresponse {
  String message;
  int statuscode;
  Category category;
  Categorysuccessresponse({
    required this.category,
    required this.message,
    required this.statuscode,
  });

  factory Categorysuccessresponse.fromjson(json) {
    return Categorysuccessresponse(
      category: Category.fromjson(json["Category"]),
      message: json["message"],
      statuscode: json["statusCode"],
    );
  }
}

class Category {
  int id;
  String name;
  String description;
  String imagepath;
  String createAt;
  String updatedAt;
  int userID;

  Category({
    required this.createAt,
    required this.description,
    required this.id,
    required this.imagepath,
    required this.name,
    required this.updatedAt,
    required this.userID,
  });

  factory Category.fromjson(json) {
    return Category(
      createAt: json["createdAt"],
      description: json["description"] ?? "",
      id: json["id"] ?? "",
      imagepath: json["imagePath"] ?? "",
      name: json["name"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      userID: json["userId"] ?? "",
    );
  }
}

class GetCategorysuccessresponse {
  int statuscode;
  List<Category> category;
  GetCategorysuccessresponse({
    required this.category,
    required this.statuscode,
  });

  factory GetCategorysuccessresponse.fromjson(json) {
    return GetCategorysuccessresponse(
      category: (json["Categories"] as List)
          .map((e) => Category.fromjson(e))
          .toList(),
      statuscode: json["statusCode"],
    );
  }
}
