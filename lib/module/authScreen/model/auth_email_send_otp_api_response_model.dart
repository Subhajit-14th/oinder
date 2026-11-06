class EmailVerificationOtpResponseModel {
  final bool? success;
  final String? message;
  final String? email;
  final String? otp;
  final int? expiresInSeconds;
  final String? validity;

  const EmailVerificationOtpResponseModel({
    this.success,
    this.message,
    this.email,
    this.otp,
    this.expiresInSeconds,
    this.validity,
  });

  factory EmailVerificationOtpResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return EmailVerificationOtpResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      email: json['email'] as String?,
      otp: json['otp'] as String?,
      expiresInSeconds: json['expiresInSeconds'] as int?,
      validity: json['validity'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'email': email,
      'otp': otp,
      'expiresInSeconds': expiresInSeconds,
      'validity': validity,
    };
  }

  EmailVerificationOtpResponseModel copyWith({
    bool? success,
    String? message,
    String? email,
    String? otp,
    int? expiresInSeconds,
    String? validity,
  }) {
    return EmailVerificationOtpResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      expiresInSeconds: expiresInSeconds ?? this.expiresInSeconds,
      validity: validity ?? this.validity,
    );
  }

  @override
  String toString() {
    return 'EmailVerificationOtpResponseModel('
        'success: $success, '
        'message: $message, '
        'email: $email, '
        'otp: $otp, '
        'expiresInSeconds: $expiresInSeconds, '
        'validity: $validity'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailVerificationOtpResponseModel &&
        other.success == success &&
        other.message == message &&
        other.email == email &&
        other.otp == otp &&
        other.expiresInSeconds == expiresInSeconds &&
        other.validity == validity;
  }

  @override
  int get hashCode {
    return Object.hash(
      success,
      message,
      email,
      otp,
      expiresInSeconds,
      validity,
    );
  }
}
