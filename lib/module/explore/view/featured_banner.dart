import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/bottomNavigation/provider/bottom_navigation_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class FeaturedBanner extends ConsumerWidget {
  const FeaturedBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff5E2A90), Color(0xffD76A87), Color(0xffFFA96C)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffD76A87).withValues(alpha: .30),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// Decorative Circle
          Positioned(
            right: -55,
            top: -45,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.withValues(alpha: .08),
              ),
            ),
          ),

          Positioned(
            bottom: -70,
            left: -50,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.withValues(alpha: .05),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.black.withValues(alpha: .18),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Texts("🥂", fontSize: 12),
                        SizedBox(width: 6),
                        Texts(
                          "TRENDING INTENT",
                          color: AppColor.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .8,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: .15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.celebration_rounded,
                      color: AppColor.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              const Texts(
                "Short-Term Fun",
                color: AppColor.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),

              Texts(
                "Looking for spontaneous dates,\nrooftop cocktails, concerts &\nzero strings attached.",
                color: AppColor.white.withValues(alpha: .88),
                fontSize: 12,
                height: 1.4,
              ),
              const Spacer(),

              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(bottomNavigationProvider.notifier).state = 0;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColor.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Texts(
                    "Explore Vibes",
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
