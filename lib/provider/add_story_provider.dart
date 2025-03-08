import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:story_app_initial/api/api_service.dart';
import 'package:story_app_initial/db/auth_repository.dart';
import 'package:story_app_initial/model/story/add_story_request.dart';
import 'package:story_app_initial/model/story/add_story_response.dart';

class AddStoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  AddStoryProvider(this.apiService, this.authRepository);

  bool isAddStoryLoading = false;

  String? _token;
  String? get token => _token;

  bool _isPosted = false;
  bool get isPosted => _isPosted;


  Future<bool> addStory(AddStoryRequest addStoryData) async {
    isAddStoryLoading = true;
    notifyListeners();

    try {
      _token = await authRepository.getToken();
      AddStoryResponse response = await apiService.addStory(addStoryData, _token!);

      _isPosted = !response.error;
      notifyListeners();
    } catch (e) {
      log("Error saat menambahkan story: $e");
      _isPosted = false;
    } finally {
      isAddStoryLoading = false;
      notifyListeners();
    }

    return _isPosted;
  }
}