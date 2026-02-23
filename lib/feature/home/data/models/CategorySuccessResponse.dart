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
    print(json);
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
    print(json);
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
// {id: 8, 
//name:
// 42d7ba3e69@webxio.pro42d7ba3e69@webxio.pro42d7ba3e6ba3e69@webx.pro42d7ba3e69@webxio.pro421$1$1$d7ba3e69@w42d7ba3e69@webxio.proebxio.pro42d7ba3e69@webxio.pro42d7ba3e69@webxio.pro42d7ba3e69@w42d7ba3e69@webxio.proebxio.pro, 
//description
//: @webxio.pro1111$1$1, 
//imagePath: http://localhost:8000/api/uploads/1771637360592.jpg, 
//createdAt: 2026-02-21 03:29:20.630465,
// updatedAt: 2026-02-21 03:29:20.630465,
// userId: 90},
// message: Category created successfully}


// {id: 18, name: 42d7ba3e69@bxio.pro42ae69@webxio.pro42d7ba3e6ba9@wbx.pro42d7ba3e69@webxio.pro421$1$1$d7ba3e69@w42d7ba3e69@webxio.proebxio.pro42d7ba3e69@webxio.pro42d7ba3e69@webxio.pro42d7ba3e69@w42d7ba3e69@webxio.proebxio.pro, 
// description: @webxio.pr$11$1$1,
//  imagePath: http://localhost:8000/api/uploads/1771637651337.jpg, 
//  createdAt: 2026-02-21 03:34:11.379654, 
//  updatedAt: 2026-02-21 03:34:11.379654,
//   userId: 90}