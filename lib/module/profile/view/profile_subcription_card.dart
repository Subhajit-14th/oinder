import 'package:flutter/material.dart';
import 'package:oinder/module/subscription/view/subscription_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileSubcriptionCard extends StatelessWidget {
  const ProfileSubcriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: AppColor.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: AppColor.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.push(
              context,
              AppRoutes.slideFromRight(SubscriptionView()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                ///==========================
                /// ICON
                ///==========================
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xff5D3400),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xffFFD54F),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),

                ///==========================
                /// TEXT
                ///==========================
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texts(
                        "Get Oinder Gold",
                        color: Color(0xff3D2500),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 6),

                      Texts(
                        "Plans start at ₹300/month",
                        color: Color(0xff6E4E2B),
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),

                ///==========================
                /// ARROW
                ///==========================
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: AppColor.white.withValues(alpha: .4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff4B2F15),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
