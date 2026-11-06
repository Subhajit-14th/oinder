import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/core/services/locationUpdate/model/location_update_api_response_model.dart';

class LocationUpdateRepository {
  final ApiService _apiService;

  LocationUpdateRepository(this._apiService);

  /// Location Update API
  Future<UpdateLocationResponse> getLocationUpdate({
    required String token,
    required String lat,
    required String lng,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.updateLocationToServer,
      data: {"latitude": lat, "longitude": lng},
    );
    return UpdateLocationResponse.fromJson(response.data);
  }
}
