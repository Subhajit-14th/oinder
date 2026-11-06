import 'dart:developer';
import 'package:cometchat_sdk/cometchat_sdk.dart';

class ChatMessageListener with MessageListener {
  final Function(TextMessage message) onMessageReceived;

  ChatMessageListener({required this.onMessageReceived});

  @override
  void onTextMessageReceived(TextMessage message) {
    log("Incoming message: ${message.text}");

    onMessageReceived(message);
  }
}
