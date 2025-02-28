import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/story_list_response.dart';

class ApiService {
  static const String baseUrl = "https://story-api.dicoding.dev/v1";

  Future<StoryListResponse> getStories(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/stories"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return StoryListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load story list");
    }
  }
}
