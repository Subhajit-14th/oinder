import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/profileDetails/model/profile_details_api_response_model.dart';

class ProfileDetailsRepository {
  final ApiService _apiService;

  ProfileDetailsRepository(this._apiService);

  /// Get User Profile Details
  Future<ProfileDetailsResponse> getUserProfileDetails({
    required String token,
    required String userId,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.getUsersProfileDetails,
      data: {"userId": userId},
    );
    return ProfileDetailsResponse.fromJson(response.data);
  }
}
