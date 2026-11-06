import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/edirProfile/model/profile_update_success_api_response_model.dart';

class EditProfileRepository {
  final ApiService _apiService;

  EditProfileRepository(this._apiService);

  /// Update User Profile
  Future<UpdateProfileResponseModel> updateProfile({
    required String token,
    required Map<String, dynamic> profileData,
  }) {
    return _apiService
        .postRequest(
          {"Authorization": "Bearer $token"},
          ApiContants.getUsersProfileUpdate,
          data: profileData,
        )
        .then((response) {
          return UpdateProfileResponseModel.fromJson(response.data);
        });
  }
}
