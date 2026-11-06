import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/auth_storage.dart';
import 'package:oinder/core/services/cometchat/cometchat_service.dart';
import 'package:oinder/core/services/get_device_id.dart';
import 'package:oinder/module/authScreen/provider/auth_screen_provider.dart';
import 'package:oinder/module/bottomNavigation/view/bottom_navigation_bar_view.dart';
import 'package:oinder/module/chat/provider/chat_provider.dart';
import 'package:oinder/module/onboarding/view/onboarding_question_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';
import 'package:pinput/pinput.dart';

class EmailOtpView extends ConsumerStatefulWidget {
  final String email;
  final bool isFromLogin;

  const EmailOtpView({
    super.key,
    required this.email,
    required this.isFromLogin,
  });

  @override
  ConsumerState<EmailOtpView> createState() => _EmailOtpViewState();
}

class _EmailOtpViewState extends ConsumerState<EmailOtpView> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      otpFocusNode.requestFocus();
      _startTimer();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    ref.read(resendSecondsProvider.notifier).state = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final seconds = ref.read(resendSecondsProvider);
      if (seconds <= 0) {
        timer.cancel();
      } else {
        ref.read(resendSecondsProvider.notifier).state = seconds - 1;
      }
    });
  }

  Future<void> _verifyOtp() async {
    final otp = ref.read(emailOtpProvider);
    await ref
        .read(authEmailVerifyOtpProvider.notifier)
        .verifyOtp(email: widget.email, otp: otp);
    if (!mounted) {
      return;
    }
    final state = ref.read(authEmailVerifyOtpProvider);
    state.when(
      data: (response) async {
        if (response == null) {
          return;
        }
        if (response.success == true) {
          final token = response.token;
          if (token != null && token.isNotEmpty) {
            final deviceId = await ref.read(deviceIdProvider.future);
            await AuthStorage.saveToken(deviceId: deviceId, token: token);
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
              await CometChatService.loginWithToken(authToken: authToken);
              final deviceId = await ref.read(deviceIdProvider.future);
              await AuthStorage.saveCometChatUid(deviceId: deviceId, uid: uid);
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

          if (widget.isFromLogin) {
            Navigator.pushAndRemoveUntil(
              context,
              AppRoutes.slideFromRight(BottomNavigationBarView()),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              AppRoutes.slideFromRight(OnboardingQuestionView()),
              (route) => false,
            );
          }
        } else {
          AppSnackbar.showError(response.message ?? "OTP verification failed");
        }
      },
      loading: () {
        log("Provider is still LOADING...");
      },
      error: (error, stackTrace) {
        log("Provider ERROR", error: error, stackTrace: stackTrace);

        String message = "Something went wrong";

        if (error is DioException) {
          message =
              error.error?.toString() ??
              error.response?.data?["error"] ??
              error.response?.data?["message"] ??
              message;
        } else {
          message = error.toString();
        }

        AppSnackbar.showError(message);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otp = ref.watch(emailOtpProvider);
    final verifyState = ref.watch(authEmailVerifyOtpProvider);
    final isLoading = verifyState.isLoading;
    final seconds = ref.watch(resendSecondsProvider);
    final bool isOtpValid = otp.length == 6;
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: isLoading ? null : () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.arrow_back,
                          size: 34,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),

                    const Texts(
                      "Enter your code",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primaryColor,
                    ),
                    const SizedBox(height: 18),

                    RichText(
                      text: TextSpan(
                        style: Styles.textStyle(
                          color: AppColor.white,
                          fontSize: 18,
                          height: 1.35,
                        ),
                        children: [
                          const TextSpan(text: "Sent to "),

                          TextSpan(
                            text: widget.email,
                            style: Styles.textStyle(
                              color: AppColor.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ". This code will expire in 10 minutes.",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),

                    Pinput(
                      controller: otpController,
                      focusNode: otpFocusNode,
                      length: 6,
                      keyboardType: TextInputType.number,
                      enabled: !isLoading,
                      autofocus: true,
                      onChanged: (value) {
                        ref.read(emailOtpProvider.notifier).state = value;
                      },
                      onCompleted: (value) {
                        ref.read(emailOtpProvider.notifier).state = value;
                      },
                      defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        textStyle: Styles.textStyle(
                          color: AppColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColor.grey, width: 2),
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        textStyle: Styles.textStyle(
                          color: AppColor.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColor.primaryColor,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    seconds == 0
                        ? GestureDetector(
                            onTap: () {
                              otpController.clear();
                              ref.read(emailOtpProvider.notifier).state = "";
                              _startTimer();
                            },
                            child: const Texts(
                              "Resend via email",
                              color: AppColor.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Texts(
                            "Resend via email in ${seconds}s",
                            color: AppColor.grey,
                            fontSize: 18,
                          ),
                  ],
                ),
              ),
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 10, 28, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: (!isOtpValid || isLoading) ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColor.primaryColor,
                      disabledBackgroundColor: AppColor.grey.withValues(
                        alpha: .35,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColor.white,
                            ),
                          )
                        : const Texts(
                            "Next",
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
