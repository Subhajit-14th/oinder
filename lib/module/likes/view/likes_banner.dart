import 'package:flutter/material.dart';
import 'package:oinder/module/subscription/view/subscription_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class LikesBanner extends StatelessWidget {
  const LikesBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, AppRoutes.slideFromRight(SubscriptionView()));
      },
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffF5E9FF), Color(0xffD8C2FF), Color(0xffA78BFA)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffA78BFA).withValues(alpha: .22),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// Decorative Circle
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white.withValues(alpha: .10),
                ),
              ),
            ),

            Positioned(
              left: -45,
              bottom: -45,
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white.withValues(alpha: .06),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Texts(
                        "UPGRADE TO OINDER GOLD",
                        color: Color(0xff3B2400),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3,
                      ),
                    ),

                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xff4A2B00),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Color(0xffFFD54F),
                        size: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                const Texts(
                  "See who likes you and match with them instantly\nwithout waiting to swipe.",
                  color: Color(0xff4F3A2D),
                  fontSize: 12,
                  height: 1.45,
                ),
                const Spacer(),

                SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        AppRoutes.slideFromRight(SubscriptionView()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4A2B00),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Texts(
                      "Unlock From ₹300/mo",
                      color: AppColor.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
