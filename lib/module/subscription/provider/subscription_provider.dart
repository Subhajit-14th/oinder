import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/subscription/model/subscription_api_response_model.dart';
import 'package:oinder/module/subscription/repository/subscription_repository.dart';

/// Repository Provider
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SubscriptionRepository(apiService);
});

/// Subscription Details Provider
final subscriptionProvider =
    FutureProvider.autoDispose<SubscriptionResponseModel>((ref) async {
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);

      if (token == null || token.isEmpty) {
        throw Exception("User not authenticated");
      }
      final repository = ref.read(subscriptionRepositoryProvider);
      return repository.getSubscriptionDetails(token: token);
    });
