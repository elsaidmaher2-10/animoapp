class AnimalResponseModel {
  int statusCode;
  AnimalModel animal;
  String message;
  AnimalResponseModel({
    required this.statusCode,
    required this.animal,
    required this.message,
  });
  factory AnimalResponseModel.fromJson(Map<String, dynamic> json) {
    return AnimalResponseModel(
      statusCode: json['status_code'],
      animal: AnimalModel.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class AnimalModel {
  int animalId;
  String animalName;
  String animalDescription;
  String animalImage;
  double animalPrice;
  int categoryId;
  int userId;
  DateTime animalCreatedAt;
  DateTime animalUpdatedAt;

  AnimalModel({
    required this.animalId,
    required this.animalName,
    required this.animalDescription,
    required this.animalImage,
    required this.animalPrice,
    required this.categoryId,
    required this.userId,
    required this.animalCreatedAt,
    required this.animalUpdatedAt,
  });
  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      animalId: json['animal_id'],
      animalName: json['animal_name'],
      animalDescription: json['animal_description'],
      animalImage: json['animal_image'],
      animalPrice: json['animal_price'],
      categoryId: json['category_id'],
      userId: json['user_id'],
      animalCreatedAt: json['animal_created_at'],
      animalUpdatedAt: json['animal_updated_at'],
    );
  }
}
