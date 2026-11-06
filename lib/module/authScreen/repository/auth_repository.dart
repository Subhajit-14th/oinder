import 'package:oinder/core/api/api_config.dart';
import 'package:oinder/core/api/api_service.dart';
import 'package:oinder/module/authScreen/model/auth_email_otp_verify_api_response_model.dart';
import 'package:oinder/module/authScreen/model/auth_email_send_otp_api_response_model.dart';
import 'package:oinder/module/authScreen/model/auth_google_login_api_response_model.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  /// Email Send Otp
  Future<EmailVerificationOtpResponseModel> authEmailSendOtp({
    required String email,
  }) async {
    final response = await _apiService.postRequest(
      {},
      ApiContants.authEmailSendOtp,
      data: {"email": email},
    );
    return EmailVerificationOtpResponseModel.fromJson(response.data);
  }

  /// Email OTP Verified
  Future<EmailVerifyResponseModel> authEmailVerifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _apiService.postRequest(
      {},
      ApiContants.authEmailVerifyEmail,
      data: {"email": email, "otp": otp},
    );
    return EmailVerifyResponseModel.fromJson(response.data);
  }

  /// Google Login
  Future<GoogleLoginResponse> googleLogin({required String idToken}) async {
    final response = await _apiService.postRequest(
      {},
      ApiContants.googleAuthLogin,
      data: {"idToken": idToken},
    );
    return GoogleLoginResponse.fromJson(response.data);
  }
}
