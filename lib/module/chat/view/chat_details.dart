import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cometchat_sdk/cometchat_sdk.dart';
import 'package:cometchat_sdk/main/cometchat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/cometchat/chat_message_listener.dart';
import 'package:oinder/module/chat/provider/chat_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ChatDetails extends ConsumerStatefulWidget {
  final String threadId;
  final String cometChatUid;

  const ChatDetails({
    super.key,
    required this.threadId,
    required this.cometChatUid,
  });

  @override
  ConsumerState<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends ConsumerState<ChatDetails> {
  final TextEditingController messageController = TextEditingController();

  final List<String> _quickSuggestions = [
    "What's your go-to weekend coffee spot? ☕",
    "Beach getaway 🌊",
  ];

  @override
  void initState() {
    super.initState();
    initCometChatListener();
  }

  void initCometChatListener() {
    log("CometChat listener started for ${widget.cometChatUid}");
    CometChat.addMessageListener(
      "chat_${widget.cometChatUid}",
      ChatMessageListener(
        onMessageReceived: (message) {
          log("Incoming CometChat message: ${message.text}");
          if (!mounted) return;
          ref.invalidate(chatDetailsProvider(widget.threadId));
        },
      ),
    );
  }

  @override
  void dispose() {
    CometChat.removeMessageListener("chat_${widget.cometChatUid}");
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatDetails = ref.watch(chatDetailsProvider(widget.threadId));
    final user = chatDetails.maybeWhen(
      data: (data) => data.user2,
      orElse: () => null,
    );
    return Scaffold(
      backgroundColor: const Color(0xff1F2023),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(86),
        child: SafeArea(
          child: Container(
            height: 86,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),

                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade300,
                  child: ClipOval(
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: CachedNetworkImage(
                        imageUrl: user?.photo ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 28,
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 28,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Texts(
                              user?.name ?? "",
                              color: AppColor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 6),

                          Expanded(
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: AppColor.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: AppColor.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      const Texts(
                        "Active now",
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.info_outline, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: chatDetails.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Texts(error.toString(), color: AppColor.white),
                ),
                data: (data) {
                  final messages = data.messages ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final chat = messages[index];
                      final isMe = chat.senderId == data.user1?.id;
                      return _chatBubble(
                        message: chat.text ?? "",
                        time: chat.timeAgo ?? "",
                        isMe: chat.isMe ?? false,
                      );
                    },
                  );
                },
              ),
            ),

            _bottomInput(),
          ],
        ),
      ),
    );
  }

  Widget _chatBubble({
    required String message,
    required String time,
    required bool isMe,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .78,
            ),
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: isMe ? AppColor.primaryColor : const Color(0xff2B2C30),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(24),
                topRight: const Radius.circular(24),
                bottomLeft: Radius.circular(isMe ? 24 : 8),
                bottomRight: Radius.circular(isMe ? 8 : 24),
              ),
            ),
            child: Texts(
              message,
              color: AppColor.white,
              fontSize: 12,
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              left: isMe ? 0 : 10,
              right: isMe ? 10 : 0,
              bottom: 18,
            ),
            child: Texts(
              time,
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomInput() {
    return Container(
      color: const Color(0xff1F2023),
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _quickSuggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    messageController.text = _quickSuggestions[index];
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff2C2D31),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Texts(
                      _quickSuggestions[index],
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff25262A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: AppColor.white),
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  sendMessage();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded, color: AppColor.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    try {
      // 1. Backend API message save
      final response = await ref.read(
        sendMessageProvider(
          SendMessageParams(receiverId: widget.cometChatUid, message: text),
        ).future,
      );

      if (response.success == true) {
        // 2. CometChat real-time send
        final textMessage = TextMessage(
          receiverUid: widget.cometChatUid,
          text: text,
          type: CometChatMessageType.text,
          receiverType: "user",
        );

        CometChat.sendMessage(
          textMessage,
          onSuccess: (message) {
            log("CometChat message sent: ${message.text}");
          },
          onError: (error) {
            log("CometChat send error: ${error.message}");
          },
        );

        messageController.clear();

        if (!mounted) return;

        AppSnackbar.showSuccess("Message sent successfully");

        // refresh chat list
        ref.invalidate(chatItemsAndListProvider);

        // refresh current thread
        ref.invalidate(chatDetailsProvider(widget.threadId));
      } else {
        if (!mounted) return;

        AppSnackbar.showError(response.message ?? "Failed to send message");
      }
    } catch (e, stackTrace) {
      log("Send Message Error: $e");
      log("StackTrace: $stackTrace");

      if (!mounted) return;

      AppSnackbar.showError(e.toString());
    }
  }
}
