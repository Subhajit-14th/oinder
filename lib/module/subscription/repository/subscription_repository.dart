import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/subscription/model/subscription_api_response_model.dart';

class SubscriptionRepository {
  final ApiService _apiService;

  SubscriptionRepository(this._apiService);

  /// Get Subscription Details
  Future<SubscriptionResponseModel> getSubscriptionDetails({
    required String token,
  }) async {
    final response = await _apiService.getRequest(
      ApiContants.getSubscriptionDetails,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      return SubscriptionResponseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load subscription details');
    }
  }
}
