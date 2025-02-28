import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/story/story_detail_response.dart';
import '../model/story/story_list_response.dart';

class ApiService {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<StoryListResponse> getStories(String token) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return StoryListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load story list");
    }
  }

  Future<StoryDetailResponse> getStoryDetail(String token, String id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories/$id"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return StoryDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load story detail");
    }
  }
}
