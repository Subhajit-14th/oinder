import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/explore/model/discory_by_vibe_api_response_model.dart';

class ExploreRepository {
  final ApiService _apiService;

  ExploreRepository(this._apiService);

  /// Get Discover By Vive List
  Future<LookingForOptionsResponse> getDiscoverByVibeList({
    required String token,
  }) async {
    final response = await _apiService.getRequest(
      ApiContants.getDiscoverByVibeList,
      headers: {"Authorization": "Bearer $token"},
    );
    return LookingForOptionsResponse.fromJson(response.data);
  }
}
