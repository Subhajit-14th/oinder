import 'package:flutter/material.dart';
import 'package:oinder/module/authScreen/view/email_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
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
                  "Create Your Account ❤️",
                  color: AppColor.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              const Center(
                child: Texts(
                  "Join Oinder today and start meeting\npeople who match your vibe.",
                  textAlign: TextAlign.center,
                  color: Colors.white60,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 45),

              /// Google
              _buildLoginButton(
                icon: Icons.g_mobiledata_rounded,
                title: "Sign up with Google",
                onTap: () {
                  // TODO Google Login
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
                title: "Sign up with Email",
                onTap: () {
                  Navigator.push(
                    context,
                    AppRoutes.slideFromRight(EmailView(isLogin: false)),
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
                    "Already have an account? ",
                    color: Colors.white60,
                    fontSize: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      // অথবা
                      // Navigator.pushReplacement(
                      //   context,
                      //   AppRoutes.slideFromRight(const LoginView()),
                      // );
                    },
                    child: const Texts(
                      "Login",
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
