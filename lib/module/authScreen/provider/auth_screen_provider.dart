import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:oinder/core/api/api_provider.dart';
import 'package:oinder/module/authScreen/model/auth_email_otp_verify_api_response_model.dart';
import 'package:oinder/module/authScreen/model/auth_email_send_otp_api_response_model.dart';
import 'package:oinder/module/authScreen/model/auth_google_login_api_response_model.dart';
import 'package:oinder/module/authScreen/repository/auth_repository.dart';

final emailProvider = StateProvider<String>((ref) => '');

final emailOtpProvider = StateProvider<String>((ref) => "");

final otpLoadingProvider = StateProvider<bool>((ref) => false);

final resendSecondsProvider = StateProvider<int>((ref) => 30);

/// ===============================
/// Auth Repository Provider
/// ===============================

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AuthRepository(apiService);
});

/// ===============================
/// Send Email OTP Provider
/// ===============================

final authEmailSendOtpProvider =
    AsyncNotifierProvider<
      AuthEmailSendOtpNotifier,
      EmailVerificationOtpResponseModel?
    >(AuthEmailSendOtpNotifier.new);

class AuthEmailSendOtpNotifier
    extends AsyncNotifier<EmailVerificationOtpResponseModel?> {
  late final AuthRepository _repository;

  @override
  Future<EmailVerificationOtpResponseModel?> build() async {
    _repository = ref.read(authRepositoryProvider);
    return null;
  }

  Future<void> sendOtp({required String email}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _repository.authEmailSendOtp(email: email);
    });
  }

  void clearOtpResponse() {
    state = const AsyncData(null);
  }
}

/// ===============================
/// Verify Email OTP Provider
/// ===============================

final authEmailVerifyOtpProvider =
    AsyncNotifierProvider<
      AuthEmailVerifyOtpNotifier,
      EmailVerifyResponseModel?
    >(AuthEmailVerifyOtpNotifier.new);

class AuthEmailVerifyOtpNotifier
    extends AsyncNotifier<EmailVerifyResponseModel?> {
  late final AuthRepository _repository;

  @override
  Future<EmailVerifyResponseModel?> build() async {
    _repository = ref.read(authRepositoryProvider);
    return null;
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _repository.authEmailVerifyOtp(email: email, otp: otp);
    });
  }

  void clearVerifyResponse() {
    state = const AsyncData(null);
  }
}

final googleLoginProvider =
    AsyncNotifierProvider<GoogleLoginNotifier, GoogleLoginResponse?>(
      GoogleLoginNotifier.new,
    );

class GoogleLoginNotifier extends AsyncNotifier<GoogleLoginResponse?> {
  late final AuthRepository _repository;

  @override
  Future<GoogleLoginResponse?> build() async {
    _repository = ref.read(authRepositoryProvider);
    return null;
  }

  Future<GoogleLoginResponse?> login({required String idToken}) async {
    state = const AsyncLoading();

    try {
      final response = await _repository.googleLogin(idToken: idToken);

      state = AsyncData(response);
      return response;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
