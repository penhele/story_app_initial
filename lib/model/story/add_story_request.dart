import 'dart:io';

class AddStoryRequest {
  String description;
  File photo;
  double? lat;
  double? lon;

  AddStoryRequest({
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
