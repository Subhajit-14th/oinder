import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/chat/provider/chat_provider.dart';
import 'package:oinder/module/home/model/home_profile_model.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class HomeItsMatchPage extends ConsumerStatefulWidget {
  final HomeProfileModel profile;
  final String cometChatUid;
  const HomeItsMatchPage({
    super.key,
    required this.profile,
    required this.cometChatUid,
  });

  @override
  ConsumerState<HomeItsMatchPage> createState() => _HomeItsMatchPageState();
}

class _HomeItsMatchPageState extends ConsumerState<HomeItsMatchPage> {
  final TextEditingController _messageController = TextEditingController();

  bool isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF170B1F),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF141A32),
              Color(0xFF25142A),
              Color(0xFF330B22),
              Color(0xFF43091D),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 70),

                /// Title
                Texts(
                  "It's a Match!",
                  fontSize: 46,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFFD7C2FF),
                  letterSpacing: .5,
                  shadows: [Shadow(color: Color(0x886B41FF), blurRadius: 18)],
                ),
                const SizedBox(height: 12),

                /// Subtitle
                Texts(
                  "You and ${widget.profile.name} have liked each other.",
                  textAlign: TextAlign.center,
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 70),

                /// Match Images
                _MatchProfileSection(profile: widget.profile),
                const Spacer(),

                /// Message Field
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: AppColor.white, fontSize: 16),
                    cursorColor: const Color(0xFFD7C2FF),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Say something nice to Meera...",
                      hintStyle: Styles.textStyle(
                        color: AppColor.white.withValues(alpha: .55),
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.send,
                          color: AppColor.primaryColor,
                          size: 28,
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 40,
                        minWidth: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                /// SEND MESSAGE
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: isSending ? null : sendMessage,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: const Color(0xFF3A2458),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isSending
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColor.white,
                            ),
                          )
                        : const Texts(
                            "SEND MESSAGE",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: AppColor.white,
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                /// KEEP SWIPING
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColor.white,
                      side: BorderSide(
                        color: AppColor.white.withValues(alpha: .22),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Texts(
                      "KEEP SWIPING",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .8,
                      color: AppColor.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      isSending = true;
    });

    try {
      final response = await ref.read(
        sendMessageProvider(
          SendMessageParams(receiverId: widget.cometChatUid, message: text),
        ).future,
      );

      if (response.success == true) {
        _messageController.clear();

        if (!mounted) return;

        AppSnackbar.showSuccess("Message sent successfully");
        Navigator.pop(context);
        ref.invalidate(chatItemsAndListProvider);
      } else {
        if (!mounted) return;
        AppSnackbar.showError(response.message ?? "Failed to send message");
      }
    } catch (e, stackTrace) {
      log("Send Message Error: $e");
      log("StackTrace: $stackTrace");

      if (!mounted) return;

      AppSnackbar.showError(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    }
  }
}

class _MatchProfileSection extends StatelessWidget {
  final HomeProfileModel profile;
  const _MatchProfileSection({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 20,
            child: Container(
              width: 78,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white, width: 4),
                image: DecorationImage(
                  image: NetworkImage(profile.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned(
            right: 20,
            child: Container(
              width: 78,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white, width: 4),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1500648767791-00dcc994a43?w=600",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned(
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite,
                color: AppColor.white,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
