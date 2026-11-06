import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/chat/provider/chat_provider.dart';
import 'package:oinder/module/chat/view/chat_list.dart';
import 'package:oinder/module/chat/view/new_match_list.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatAsync = ref.watch(chatItemsAndListProvider);

    return Scaffold(
      backgroundColor: const Color(0xff1E1E22),
      body: SafeArea(
        child: chatAsync.when(
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          error: (error, stack) {
            return Center(
              child: Texts(error.toString(), color: AppColor.white),
            );
          },
          data: (data) {
            final matches = data.newMatches ?? [];

            log("My new matches is: ${data.newMatches}");

            final chats = data.messages ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Row(
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: AppColor.primaryLight.withValues(alpha: .25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.chat_bubble_rounded,
                          color: AppColor.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),

                      const Texts(
                        "Matches & Messages",
                        color: AppColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                /// NEW MATCHES
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Texts(
                    "New Matches (${matches.length})",
                    color: AppColor.primaryLight,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),

                SizedBox(height: 110, child: NewMatchList(matches: matches)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Divider(
                    color: Colors.white.withValues(alpha: .12),
                    thickness: 1,
                  ),
                ),
                const SizedBox(height: 16),

                /// MESSAGE TITLE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Texts(
                    "Messages",
                    color: AppColor.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                /// CHAT LIST
                Expanded(child: ChatList(chats: chats)),
              ],
            );
          },
        ),
      ),
    );
  }
}
