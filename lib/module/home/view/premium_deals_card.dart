import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class PremiumDealsCard extends StatefulWidget {
  const PremiumDealsCard({super.key});

  @override
  State<PremiumDealsCard> createState() => _PremiumDealsCardState();
}

class _PremiumDealsCardState extends State<PremiumDealsCard> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff2B2B31),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.white.withValues(alpha: .08)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Texts(
                "PREMIUM DEALS",
                color: AppColor.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Texts(
                  "Limited Offer",
                  color: AppColor.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            spacing: 10,
            children: [
              Expanded(
                child: _PlanCard(
                  title: "Monthly",
                  price: "₹300",
                  selected: selectedIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
              ),

              Expanded(
                child: _PlanCard(
                  title: "6 Months",
                  price: "₹1500",
                  selected: selectedIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
              ),

              Expanded(
                child: _PlanCard(
                  title: "Yearly",
                  price: "₹2500",
                  selected: selectedIndex == 2,
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final bool selected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: 74,
            decoration: BoxDecoration(
              color: const Color(0xff1F2024),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? AppColor.primaryColor
                    : AppColor.white.withValues(alpha: .08),
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Texts(title, color: Colors.white60, fontSize: 11),
                const SizedBox(height: 6),
                Texts(
                  price,
                  color: AppColor.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),

          if (selected)
            Positioned(
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Texts(
                  "BEST",
                  color: AppColor.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
