import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/razorpay/razorpay_service.dart';
import 'package:oinder/module/subscription/provider/subscription_provider.dart';
import 'package:oinder/module/subscription/view/subscription_bottomsheet_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class SubscriptionView extends ConsumerStatefulWidget {
  const SubscriptionView({super.key});

  @override
  ConsumerState<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends ConsumerState<SubscriptionView> {
  int selectedPlan = 2;

  final RazorpayService razorpayService = RazorpayService();

  @override
  void initState() {
    super.initState();

    razorpayService.init(
      onSuccess: (response) {
        debugPrint("Payment Success");
        debugPrint("Payment ID: ${response.paymentId}");

        // ekhane API call korte paro
        // verify payment
      },
      onError: (response) {
        debugPrint("Payment Failed");
        debugPrint(response.message);
      },
      onExternalWallet: (response) {
        debugPrint("External Wallet");
        debugPrint(response.walletName);
      },
    );
  }

  @override
  void dispose() {
    razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionAsync = ref.watch(subscriptionProvider);
    return Scaffold(
      backgroundColor: const Color(0xff1E1E20),
      body: subscriptionAsync.when(
        data: (data) {
          final currentPlan = data.currentSubscription;
          final plans = data.tiers;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  ///===================================
                  /// APP BAR
                  ///===================================
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/app_logo/app_logo_transparent.png",
                            height: 24,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Texts(
                        "Oinder",
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .05),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  ///===================================
                  /// GOLD ICON
                  ///===================================
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColor.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primaryColor.withValues(alpha: .35),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.workspace_premium_rounded,
                        color: Color(0xff4B2E00),
                        size: 56,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  ///===================================
                  /// TITLE
                  ///===================================
                  Texts(
                    currentPlan?.plan ?? "Upgrade Plan",
                    color: AppColor.white,
                    fontSize: 26,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 12),

                  Texts(
                    "Unlock all premium features &\nfind matches 3× faster",
                    color: AppColor.white.withValues(alpha: .60),
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    height: 1.5,
                  ),
                  const SizedBox(height: 24),

                  ///===================================
                  /// PLAN TITLE
                  ///===================================
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Texts(
                      "Select a Subscription Plan",
                      color: AppColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ///===================================
                  /// SUBSCRIPTION PLANS
                  ///===================================
                  SizedBox(
                    height: 190,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: plans.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (_, index) {
                        final plan = plans[index];
                        return SizedBox(
                          width: 150,
                          child: _planCard(
                            index: index,
                            title: plan.name ?? "",
                            price: plan.price ?? "",
                            monthlyPrice: plan.billingPeriod ?? "",
                            badge: plan.popular ? "POPULAR" : null,
                            badgeColor: plan.badgeColor != null
                                ? Color(
                                    int.parse(
                                      plan.badgeColor!.replaceFirst(
                                        "#",
                                        "0xff",
                                      ),
                                    ),
                                  )
                                : null,
                            badgeTextColor: plan.textColor != null
                                ? Color(
                                    int.parse(
                                      plan.textColor!.replaceFirst("#", "0xff"),
                                    ),
                                  )
                                : AppColor.white,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  ///======================================
                  /// INCLUDED WITH OINDER GOLD
                  ///======================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xff2F2F33),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Texts(
                          "Included with Oinder Gold",
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 28),

                        Column(
                          children: plans[selectedPlan].features.map((feature) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: _featureItem(
                                icon: Icons.check_circle,
                                iconColor: Colors.green,
                                bgColor: Colors.green.withValues(alpha: .15),
                                title: feature,
                                subtitle: "",
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),

                  ///======================================
                  /// SUBSCRIBE BUTTON
                  ///======================================
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final selected = plans[selectedPlan];

                        final price = selected.price
                            ?.replaceAll("\$", "")
                            .replaceAll(",", "")
                            .trim();

                        razorpayService.openCheckout(
                          orderId: "123456",
                          amount: double.parse(price ?? "0").toInt(),
                          name: "Oinder",
                          description: "${selected.name} Subscription",
                          email: "test@gmail.com",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: AppColor.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Texts(
                        plans.isNotEmpty
                            ? "SUBSCRIBE WITH GOOGLE PLAY • ${plans[selectedPlan].price}"
                            : "SUBSCRIBE WITH GOOGLE PLAY",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                        letterSpacing: .3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Texts(
                    "Subscription managed solely via Google Play Store.",
                    color: AppColor.white.withValues(alpha: .45),
                    textAlign: TextAlign.center,
                    fontSize: 10,
                  ),
                  const SizedBox(height: 10),

                  Texts(
                    "Automatically renews, cancel anytime in Google Play Store.",
                    color: AppColor.white.withValues(alpha: .35),
                    textAlign: TextAlign.center,
                    fontSize: 10,
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) =>
            Center(child: Texts(e.toString(), color: AppColor.white)),
      ),
    );
  }

  void showSubscriptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SubscriptionBottomSheet(),
    );
  }

  Widget _planCard({
    required int index,
    required String title,
    required String price,
    required String monthlyPrice,
    String? badge,
    Color? badgeColor,
    Color? badgeTextColor,
  }) {
    final selected = selectedPlan == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: const Color(0xff2E2E33),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: selected
                ? AppColor.primaryColor
                : AppColor.white.withValues(alpha: .05),
            width: selected ? 3 : 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (badge != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Texts(
                      badge,
                      color: badgeTextColor ?? AppColor.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                top: badge != null ? 55 : 35,
                bottom: 25,
              ),
              child: Column(
                children: [
                  Texts(
                    title,
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),

                  Texts(
                    price,
                    color: selected ? AppColor.primaryColor : AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 18),

                  Texts(monthlyPrice, color: Colors.white54, fontSize: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts(
                title,
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 6),

              Texts(
                subtitle,
                color: AppColor.white.withValues(alpha: .45),
                fontSize: 12,
                height: 1.45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
