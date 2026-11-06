import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oinder/module/chat/model/match_and_message_api_response_model.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ChatTile extends StatelessWidget {
  final ChatMessageItemModel chat;
  final VoidCallback? onTap;

  const ChatTile({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final partner = chat.partner;

    final name = partner?.name ?? "Unknown";
    final image = partner?.profilePhoto ?? "";
    final lastMessage = chat.lastMessage?.text ?? "";
    final time = chat.lastMessage?.timeAgo ?? "";
    final isOnline = partner?.isOnline ?? false;
    final isVerified = partner?.isVerified ?? false;
    final hasUnread = chat.hasUnread ?? false;
    final unreadCount = chat.unreadCount ?? 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          children: [
            /// PROFILE IMAGE
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFFB74D),
                        Color(0xffFF4081),
                        Color(0xff7C4DFF),
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColor.grey,
                    backgroundImage: image.isNotEmpty
                        ? CachedNetworkImageProvider(image)
                        : null,
                    child: image.isEmpty
                        ? const Icon(Icons.person, color: AppColor.white)
                        : null,
                  ),
                ),

                if (isOnline)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xff2ECC71),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xff1E1E22),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 14),

            /// MESSAGE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Texts(
                          name,
                          color: AppColor.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      if (isVerified) ...[
                        const SizedBox(width: 5),

                        const Icon(
                          Icons.verified,
                          color: Color(0xffB794F6),
                          size: 16,
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 6),

                  Texts(
                    lastMessage,
                    color: AppColor.white.withValues(alpha: .65),
                    fontSize: 13,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// TIME + UNREAD
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Texts(
                  time,
                  color: hasUnread
                      ? const Color(0xffC6A8FF)
                      : AppColor.white.withValues(alpha: .45),
                  fontSize: 11,
                ),

                const SizedBox(height: 10),

                if (hasUnread)
                  Container(
                    height: 18,
                    width: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xffB794F6),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: unreadCount > 1
                        ? Texts(
                            "$unreadCount",
                            color: AppColor.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
