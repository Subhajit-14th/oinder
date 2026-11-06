import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/likes/model/likes_you_api_response_model.dart';

class LikesRepository {
  final ApiService _apiService;

  LikesRepository(this._apiService);

  /// Get Likes Data
  Future<LikesYouResponse> getLikesData({required String token}) async {
    final response = await _apiService.getRequest(
      ApiContants.getLikes,
      headers: {"Authorization": "Bearer $token"},
    );
    return LikesYouResponse.fromJson(response.data);
  }
}
