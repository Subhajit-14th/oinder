import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/home/model/get_users_profile_api_response_model.dart';
import 'package:oinder/module/home/model/user_like_match_api_response_model.dart';
import 'package:oinder/module/home/model/user_super_like_api_response_model.dart';

class HomeRepository {
  final ApiService _apiService;

  HomeRepository(this._apiService);

  /// Get Users Profile
  Future<UsersResponseModel> getUsersProfile({
    required String token,
    String? lookingFor,
    String? interestedIn,
    int? minAge,
    int? maxAge,
    int? maxDistance,
    bool? isVerified,
  }) async {
    final Map<String, dynamic> queryParameters = {};

    if (lookingFor != null && lookingFor.isNotEmpty) {
      queryParameters['lookingFor'] = lookingFor;
    }

    if (interestedIn != null && interestedIn.isNotEmpty) {
      queryParameters['interestedIn'] = interestedIn;
    }

    if (minAge != null) {
      queryParameters['minAge'] = minAge;
    }

    if (maxAge != null) {
      queryParameters['maxAge'] = maxAge;
    }

    if (maxDistance != null) {
      queryParameters['maxDistance'] = maxDistance;
    }

    if (isVerified != null) {
      queryParameters['isVerified'] = isVerified;
    }

    final response = await _apiService.getRequestWithParams(
      ApiContants.getUsersProfile,
      headers: {"Authorization": "Bearer $token"},
      queryParameters: queryParameters,
    );
    return UsersResponseModel.fromJson(response.data);
  }

  /// Get Users Match Profile
  Future<LikeResponseModel> getUsersMatchProfile({
    required String token,
    required String userId,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.getUsersMatchProfile,
      data: {"userId": userId},
    );
    return LikeResponseModel.fromJson(response.data);
  }

  /// Get Users Super Like Profile
  Future<UserSuperLikeResponse> getUserSuperLikeProfile({
    required String token,
    required String userId,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.getUsersSuperLike,
      data: {"userId": userId, "is_super_like": true},
    );
    return UserSuperLikeResponse.fromJson(response.data);
  }
}
