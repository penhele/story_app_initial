import 'dart:io';

class Story {
  String description;
  File photo;
  double? lat;
  double? lon;

  Story({
    required this.description,
    required this.photo,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toJson() => {
    "description": description,
    "photo": photo,
    "lat": lat,
    "lon": lon,
  };
}
