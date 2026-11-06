class HideProfileResponse {
  final bool success;
  final String message;
  final String userId;
  final bool isHide;
  final bool isVisible;

  const HideProfileResponse({
    required this.success,
    required this.message,
    required this.userId,
    required this.isHide,
    required this.isVisible,
  });

  factory HideProfileResponse.fromJson(Map<String, dynamic> json) {
    return HideProfileResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      isHide: json['is_hide'] as bool? ?? false,
      isVisible: json['is_visible'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'userId': userId,
      'is_hide': isHide,
      'is_visible': isVisible,
    };
  }
}
