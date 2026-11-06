import 'package:flutter/material.dart';
import 'package:oinder/module/chat/model/match_and_message_api_response_model.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class NewMatchItem extends StatelessWidget {
  final NewMatchModel match;
  final VoidCallback? onTap;

  const NewMatchItem({super.key, required this.match, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 82,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ///==============================
                /// GRADIENT RING
                ///==============================
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFFD54F),
                        Color(0xffFF4081),
                        Color(0xff7C4DFF),
                      ],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xff1E1E22),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(match.profilePhoto ?? ''),
                    ),
                  ),
                ),

                ///==============================
                /// ONLINE DOT
                ///==============================
                if (match.isOnline == true)
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xff30D158),
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

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Texts(
                    match.name ?? '',
                    color: AppColor.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                if (match.isVerified == true) ...[
                  const SizedBox(width: 3),

                  const Icon(
                    Icons.verified_rounded,
                    color: Color(0xffB794F6),
                    size: 15,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
