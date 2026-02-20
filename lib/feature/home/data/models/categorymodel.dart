import 'dart:io';

class Categorymodel {
  String name;
  String description;
  File image;

  Categorymodel({
    required this.description,
    required this.image,
    required this.name,
  });
}
