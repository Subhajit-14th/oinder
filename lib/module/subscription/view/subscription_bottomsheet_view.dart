import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class SubscriptionBottomSheet extends StatelessWidget {
  const SubscriptionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2B2B2F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://brandlogos.sgp1.digitaloceanspaces.com/png/logos/google-play-icon-400.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts(
                          "Google Play",
                          color: AppColor.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 2),

                        Texts(
                          "In-App Subscription",
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1F2024),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: .18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts(
                            "Oinder Gold (12 Months)",
                            color: AppColor.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                          SizedBox(height: 6),

                          Texts(
                            "Recurring billing per year • ₹208 / mo",
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ),

                    const Texts(
                      "₹2,500",
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1F2024),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: .18),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Texts(
                          "G",
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts(
                            "Google Play Balance & Payment",
                            color: AppColor.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          SizedBox(height: 4),

                          Texts(
                            "Managed securely via your Google Play account",
                            color: Colors.white54,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color(0xff22C55E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColor.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    color: AppColor.primaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Texts(
                      "Subscription automatically renews. Cancel anytime from Google Play Store > Subscriptions.",
                      color: AppColor.white.withValues(alpha: .65),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: const Color(0xff3B245E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // TODO:
                    // Launch Google Play Billing Flow
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_rounded, size: 20),
                      SizedBox(width: 8),

                      Texts(
                        "1-TAP SUBSCRIBE WITH PLAY STORE",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .4,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
