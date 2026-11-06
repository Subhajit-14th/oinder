class ProfilePhotoUpdateResponse {
  final bool success;
  final String message;
  final String? profilePhoto;

  const ProfilePhotoUpdateResponse({
    required this.success,
    required this.message,
    this.profilePhoto,
  });

  factory ProfilePhotoUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoUpdateResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      profilePhoto: json['profilePhoto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'profilePhoto': profilePhoto,
    };
  }
}
