import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story_app_initial/model/story/add_story_request.dart';
import 'package:story_app_initial/model/story/add_story_response.dart';
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

  Future<AddStoryResponse> addStory(
    AddStoryRequest addStoryData,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/stories"),
      headers: {
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(addStoryData.toJson()),
    );
    if (response.statusCode == 201) {
      return AddStoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add story");
    }
  }
}
