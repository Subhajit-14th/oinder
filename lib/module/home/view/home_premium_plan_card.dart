import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class PremiumPlanCard extends StatelessWidget {
  const PremiumPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xffFF7B8A), Color(0xffFF5A6B), Color(0xffF24462)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withValues(alpha: .35),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///========================
          /// TITLE
          ///========================
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts(
                      "Oinder Premium",
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 3),
                    Texts(
                      "Get more matches & unlimited swipes",
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          ///========================
          /// FEATURES
          ///========================
          Row(
            children: const [
              Expanded(
                child: _FeatureItem(
                  icon: Icons.favorite,
                  title: "Unlimited",
                  subTitle: "Likes",
                ),
              ),
              Expanded(
                child: _FeatureItem(
                  icon: Icons.flash_on,
                  title: "5 Boosts",
                  subTitle: "Monthly",
                ),
              ),
              Expanded(
                child: _FeatureItem(
                  icon: Icons.star,
                  title: "Super",
                  subTitle: "Likes",
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          ///========================
          /// PRICE
          ///========================
          Row(
            children: [
              const Texts(
                "₹499",
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),

              const SizedBox(width: 6),

              Texts("/month", color: Colors.white.withValues(alpha: .75)),

              const Spacer(),

              ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColor.primaryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: const Texts(
                  "Upgrade",
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .16),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),

        const SizedBox(height: 10),

        Texts(
          title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),

        const SizedBox(height: 2),

        Texts(subTitle, color: Colors.white70, fontSize: 11),
      ],
    );
  }
}
