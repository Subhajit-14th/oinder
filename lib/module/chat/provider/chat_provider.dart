import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/chat/model/chat_details_api_response_model.dart';
import 'package:oinder/module/chat/model/chat_send_message_api_response_model.dart';
import 'package:oinder/module/chat/model/cometchat_credential_api_response_model.dart';
import 'package:oinder/module/chat/model/match_and_message_api_response_model.dart';
import 'package:oinder/module/chat/repository/chat_repository.dart';

/// Repository Provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ChatRepository(apiService);
});

/// Get CometChat Credential Provider
final chatCredentialProvider = FutureProvider<CometChatCredentialResponse>((
  ref,
) async {
  final deviceId = await ref.watch(deviceIdProvider.future);
  final token = await AuthStorage.getToken(deviceId);
  if (token == null || token.isEmpty) {
    throw Exception("User not authenticated");
  }
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChatToken(token: token);
});

/// Send Message Params
class SendMessageParams {
  final String receiverId;
  final String message;

  const SendMessageParams({required this.receiverId, required this.message});
}

/// Send Message Provider
final sendMessageProvider =
    FutureProvider.family<ChatSendMessageResponse, SendMessageParams>((
      ref,
      params,
    ) async {
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("User token not found");
      }
      final repository = ref.read(chatRepositoryProvider);
      return repository.sendMessage(
        receiverId: params.receiverId,
        message: params.message,
        token: token,
      );
    });

final chatItemsAndListProvider =
    FutureProvider<ChatMatchesMessagesResponseModel>((ref) async {
      final repository = ref.read(chatRepositoryProvider);
      final deviceId = await ref.read(deviceIdProvider.future);
      final uid = await AuthStorage.getCometChatUid(deviceId);
      final token = await AuthStorage.getToken(deviceId);
      if (uid == null || token == null) {
        throw Exception("Authentication token not found");
      }
      return repository.getChatItemsAndList(userId: uid, token: token);
    });

final chatDetailsProvider = FutureProvider.autoDispose
    .family<ThreadMessagesResponse, String>((ref, threadId) async {
      final deviceId = await ref.read(deviceIdProvider.future);
      final token = await AuthStorage.getToken(deviceId);
      if (token == null || token.isEmpty) {
        throw Exception("User token not found");
      }
      final repository = ref.read(chatRepositoryProvider);
      return await repository.getChatDetails(threadId: threadId, token: token);
    });
