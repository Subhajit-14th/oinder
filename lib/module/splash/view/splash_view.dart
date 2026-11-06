import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/auth_provider.dart';
import 'package:oinder/module/authScreen/view/login_view.dart';
import 'package:oinder/module/bottomNavigation/view/bottom_navigation_bar_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    final isLoggedIn = await ref.read(authProvider.future);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            isLoggedIn ? const BottomNavigationBarView() : const LoginView(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColor.splashGradient),
        child: Stack(
          children: [
            /// Background Decoration
            Positioned(
              top: -120,
              right: -90,
              child: Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: .08),
                ),
              ),
            ),

            Positioned(
              bottom: -140,
              left: -120,
              child: Container(
                height: 320,
                width: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: .05),
                ),
              ),
            ),

            Positioned(
              top: 120,
              left: -50,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: .04),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  const Spacer(),

                  ///==========================
                  /// LOGO
                  ///==========================
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 900),
                    tween: Tween(begin: .7, end: 1),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Hero(
                      tag: "app_logo",
                      child: Image.asset(
                        "assets/app_logo/app_logo_transparent.png",
                        height: 135,
                        width: 135,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  ///==========================
                  /// APP NAME
                  ///==========================
                  const Texts(
                    "Oinder",
                    color: AppColor.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),

                  Texts(
                    "Find Your Perfect Match",
                    color: AppColor.white.withValues(alpha: .80),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),

                  Texts(
                    "Meet • Chat • Connect",
                    color: AppColor.white.withValues(alpha: .60),
                    fontSize: 13,
                    letterSpacing: 2,
                  ),
                  const Spacer(),

                  Texts(
                    "Connecting Hearts...",
                    color: AppColor.white.withValues(alpha: .75),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 18),

                  ///==========================
                  /// LOADING DOTS
                  ///==========================
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          double value =
                              (_controller.value - (index * .18)) % 1.0;
                          double scale = .75;
                          double opacity = .25;
                          double translateY = 0;
                          if (value < .5) {
                            final t = Curves.easeOut.transform(value * 2);
                            scale = .75 + (.45 * t);
                            opacity = .25 + (.75 * t);
                            translateY = -5 * t;
                          } else {
                            final t = Curves.easeIn.transform((value - .5) * 2);
                            scale = 1.20 - (.45 * t);
                            opacity = 1 - (.75 * t);
                            translateY = -5 + (5 * t);
                          }
                          return Transform.translate(
                            offset: Offset(0, translateY),
                            child: Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withValues(alpha: .95),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
