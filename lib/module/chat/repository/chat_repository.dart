import 'dart:developer';

import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/chat/model/chat_details_api_response_model.dart';
import 'package:oinder/module/chat/model/chat_send_message_api_response_model.dart';
import 'package:oinder/module/chat/model/cometchat_credential_api_response_model.dart';
import 'package:oinder/module/chat/model/match_and_message_api_response_model.dart';

class ChatRepository {
  final ApiService _apiService;

  ChatRepository(this._apiService);

  /// Get chat token
  Future<CometChatCredentialResponse> getChatToken({
    required String token,
  }) async {
    try {
      log("========== GET CHAT TOKEN API ==========");
      log("URL: ${ApiContants.getChatToken}");
      log("Authorization: Bearer $token");

      final response = await _apiService.getRequest(
        ApiContants.getChatToken,
        headers: {"Authorization": "Bearer $token"},
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      final result = CometChatCredentialResponse.fromJson(response.data);

      log("Parsed Response: ${result.toJson()}");
      log("========== GET CHAT TOKEN SUCCESS ==========");

      return result;
    } catch (e, s) {
      log(
        "========== GET CHAT TOKEN FAILED ==========",
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  Future<ChatSendMessageResponse> sendMessage({
    required String receiverId,
    required String message,
    required String token,
  }) async {
    final response = await _apiService.postRequest(
      {"Authorization": "Bearer $token"},
      ApiContants.sendMessage,
      data: {"receiverId": receiverId, "message": message},
    );
    return ChatSendMessageResponse.fromJson(response.data);
  }

  /// Get Chat Items and List
  Future<ChatMatchesMessagesResponseModel> getChatItemsAndList({
    required String userId,
    required String token,
  }) async {
    final response = await _apiService.getRequestWithParams(
      ApiContants.chatMatchesAndMessages,
      headers: {"Authorization": "Bearer $token"},
      queryParameters: {"userId": userId},
    );
    return ChatMatchesMessagesResponseModel.fromJson(response.data);
  }

  /// Get Dev Repo
  Future<ThreadMessagesResponse> getChatDetails({
    required String threadId,
    required String token,
  }) async {
    final response = await _apiService.getRequest(
      "${ApiContants.chatDetails}/$threadId",
      headers: {"Authorization": "Bearer $token"},
    );
    return ThreadMessagesResponse.fromJson(response.data);
  }
}
