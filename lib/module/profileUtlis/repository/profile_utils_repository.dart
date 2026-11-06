import 'dart:developer';

import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/profileUtlis/model/get_blocked_user_api_response.dart';
import 'package:oinder/module/profileUtlis/model/post_blocked_user_api_response.dart';
import 'package:oinder/module/profileUtlis/model/post_hide_my_profile_api_response.dart';

class ProfileUtilsRepository {
  final ApiService _apiService;

  ProfileUtilsRepository(this._apiService);

  /// Get Blocked Users List
  Future<BlockedUserResponse> getBlockedUsersList({
    required String token,
  }) async {
    final response = await _apiService.getRequest(
      ApiContants.getBlockedUsers,
      headers: {"Authorization": "Bearer $token"},
    );
    return BlockedUserResponse.fromJson(response.data);
  }

  /// Post Blocked User
  Future<PostBlockedUserResponse> postBlockedUser({
    required String token,
    required String userId,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.postBlockedUsers,
      data: {"userId": userId},
    );
    return PostBlockedUserResponse.fromJson(response.data);
  }

  /// Hide My Profile
  Future<HideProfileResponse> hideMyProfile({
    required String token,
    required bool isHide,
  }) async {
    log("My token is: $token");
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.hideMyProfile,
      data: {"is_hide": isHide},
    );
    return HideProfileResponse.fromJson(response.data);
  }
}
