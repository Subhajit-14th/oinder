import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/authScreen/provider/auth_screen_provider.dart';
import 'package:oinder/module/authScreen/view/email_otp_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class EmailView extends ConsumerStatefulWidget {
  const EmailView({super.key, required this.isLogin});

  final bool isLogin;

  @override
  ConsumerState<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends ConsumerState<EmailView> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final email = ref.watch(emailProvider);
    final isEmailEntered = email.trim().isNotEmpty;
    final isEmailValid = isValidEmail(email.trim());
    final otpState = ref.watch(authEmailSendOtpProvider);
    final isLoading = otpState.isLoading;
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColor.primaryColor,
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    const Texts(
                      "What's your email?",
                      color: AppColor.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 45),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppColor.primaryColor,
                      onChanged: (value) {
                        ref.read(emailProvider.notifier).state = value;
                      },
                      style: Styles.textStyle(
                        color: AppColor.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(bottom: 10),
                        hintText: "Enter your email",
                        hintStyle: Styles.textStyle(
                          color: AppColor.grey.withValues(alpha: .4),
                          fontSize: 20,
                        ),
                        errorText: email.isEmpty
                            ? null
                            : (isEmailValid
                                  ? null
                                  : "Please enter a valid email"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff9E9E9E),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Texts(
                      "We'll send you a code to verify your email. You may\nneed to check your spam email folder.",
                      color: AppColor.grey,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ],
                ),
              ),
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 10, 26, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: (isEmailValid && !isLoading)
                        ? () async {
                            final email = emailController.text.trim();
                            await ref
                                .read(authEmailSendOtpProvider.notifier)
                                .sendOtp(email: email);
                            if (!mounted) return;
                            final state = ref.read(authEmailSendOtpProvider);
                            state.when(
                              data: (response) {
                                if (response != null &&
                                    response.success == true) {
                                  AppSnackbar.showInfo(
                                    "Your otp is: ${response.otp}",
                                  );
                                  Navigator.push(
                                    context,
                                    AppRoutes.slideFromRight(
                                      EmailOtpView(
                                        email: email,
                                        isFromLogin: widget.isLogin,
                                      ),
                                    ),
                                  );
                                }
                              },
                              loading: () {},
                              error: (error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())),
                                );
                              },
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEmailEntered
                          ? AppColor.primaryColor
                          : AppColor.grey.withValues(alpha: .35),
                      disabledBackgroundColor: AppColor.grey.withValues(
                        alpha: .35,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColor.white,
                            ),
                          )
                        : const Texts(
                            "Next",
                            color: AppColor.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
