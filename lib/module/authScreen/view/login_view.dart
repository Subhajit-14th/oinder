import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/cometchat/cometchat_service.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/core/services/google_auth_service.dart';
import 'package:oinder/module/authScreen/provider/auth_screen_provider.dart';
import 'package:oinder/module/authScreen/view/email_view.dart';
import 'package:oinder/module/authScreen/view/registration_view.dart';
import 'package:oinder/module/bottomNavigation/view/bottom_navigation_bar_view.dart';
import 'package:oinder/module/chat/provider/chat_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff16171C),
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryColor.withValues(alpha: .12),
                  ),
                  child: Image.asset(
                    "assets/app_logo/app_logo_transparent.png",
                  ),
                ),
              ),
              const SizedBox(height: 35),

              const Center(
                child: Texts(
                  "Welcome Back 👋",
                  color: AppColor.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              const Center(
                child: Texts(
                  "Sign in with your phone number\nand continue finding your perfect match.",
                  textAlign: TextAlign.center,
                  color: Colors.white60,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 45),

              /// Google
              _buildLoginButton(
                icon: Icons.g_mobiledata_rounded,
                title: "Continue with Google",
                onTap: () async {
                  final googleUser = await ref
                      .read(googleAuthProvider)
                      .signInWithGoogle();

                  if (googleUser == null) {
                    AppSnackbar.showError("Google login cancelled");
                    return;
                  }

                  log("=========== My data is: ${googleUser.toJson()}");
                  AppSnackbar.showSuccess("Google login successful");

                  final response = await ref
                      .read(googleLoginProvider.notifier)
                      .login(idToken: googleUser.accessToken);

                  log("--------- My login response is: $response");

                  if (response != null && response.status) {
                    AppSnackbar.showSuccess(response.message);

                    final token = response.token;
                    if (token.isNotEmpty) {
                      final deviceId = await ref.read(deviceIdProvider.future);
                      await AuthStorage.saveToken(
                        deviceId: deviceId,
                        token: token,
                      );
                    } else {}
                    try {
                      final chatCredential = await ref.read(
                        chatCredentialProvider.future,
                      );
                      final appId = chatCredential.cometChat?.appId;
                      final region = chatCredential.cometChat?.region;
                      final authToken = chatCredential.user?.authToken;
                      final uid = chatCredential.user?.uid;
                      if (appId != null &&
                          region != null &&
                          authToken != null &&
                          uid != null) {
                        await CometChatService.loginWithToken(
                          authToken: authToken,
                        );
                        final deviceId = await ref.read(
                          deviceIdProvider.future,
                        );
                        await AuthStorage.saveCometChatUid(
                          deviceId: deviceId,
                          uid: uid,
                        );
                        await AuthStorage.saveCometChatAuthToken(
                          deviceId: deviceId,
                          authToken: authToken,
                        );
                        await AuthStorage.setCometChatUserCreated(
                          deviceId: deviceId,
                          value: true,
                        );
                      } else {
                        log("CometChat credentials are incomplete");
                        log("appId = $appId");
                        log("region = $region");
                        log("uid = $uid");
                        log("authToken = $authToken");
                      }
                    } catch (e, s) {
                      log("CometChat Login FAILED", error: e, stackTrace: s);
                    }

                    if (!mounted) {
                      log("Widget unmounted before navigation");
                      return;
                    }

                    log("Navigation Started");
                    Navigator.pushReplacement(
                      context,
                      AppRoutes.slideFromRight(BottomNavigationBarView()),
                    );
                  } else {
                    AppSnackbar.showError(response?.message ?? "Login failed");
                  }
                },
              ),
              const SizedBox(height: 14),

              /// Phone Number
              // _buildLoginButton(
              //   icon: Icons.phone,
              //   title: "Continue with phone number",
              //   onTap: () {
              //     // TODO Phone Login
              //   },
              // ),
              // const SizedBox(height: 14),

              /// Email
              _buildLoginButton(
                icon: Icons.email,
                title: "Continue with email",
                onTap: () {
                  Navigator.push(
                    context,
                    AppRoutes.slideFromRight(EmailView(isLogin: true)),
                  );
                },
              ),
              const SizedBox(height: 35),

              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                      height: 1.6,
                    ),
                    children: [
                      TextSpan(text: "By continuing, you agree to our\n"),
                      TextSpan(
                        text: "Terms & Conditions",
                        style: Styles.textStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: Styles.textStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Texts(
                    "Don't have an account? ",
                    color: Colors.white60,
                    fontSize: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Registration Screen
                      Navigator.push(
                        context,
                        AppRoutes.slideFromRight(RegistrationView()),
                      );
                    },
                    child: const Texts(
                      "Sign Up",
                      color: AppColor.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: Material(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Icon(icon, color: AppColor.primaryColor, size: 24),
                Expanded(
                  child: Center(
                    child: Texts(
                      title,
                      color: AppColor.primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
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
