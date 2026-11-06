import 'package:flutter/material.dart';
import 'package:oinder/module/chat/model/match_and_message_api_response_model.dart';
import 'package:oinder/module/chat/view/chat_details.dart';
import 'package:oinder/module/chat/view/chat_tile.dart';
import 'package:oinder/utils/utils.dart';

class ChatList extends StatelessWidget {
  final List<ChatMessageItemModel> chats;

  const ChatList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: chats.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        indent: 92,
        endIndent: 18,
        color: Colors.white.withValues(alpha: .06),
      ),
      itemBuilder: (context, index) {
        final chat = chats[index];

        return Hero(
          tag: "chat_${chat.threadId}",
          child: Material(
            color: Colors.transparent,
            child: ChatTile(
              chat: chat,
              onTap: () {
                Navigator.push(
                  context,
                  AppRoutes.slideFromRight(
                    ChatDetails(
                      threadId: "${chat.threadId}",
                      cometChatUid: "${chat.partner?.cometchatUserId}",
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
