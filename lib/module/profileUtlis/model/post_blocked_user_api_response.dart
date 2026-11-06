class PostBlockedUserResponse {
  final bool success;
  final String message;
  final String action;
  final bool isBlocked;
  final String blockId;
  final String blockedUserId;
  final PostBlockedUser? blockedUser;

  const PostBlockedUserResponse({
    required this.success,
    required this.message,
    required this.action,
    required this.isBlocked,
    required this.blockId,
    required this.blockedUserId,
    required this.blockedUser,
  });

  factory PostBlockedUserResponse.fromJson(Map<String, dynamic> json) {
    return PostBlockedUserResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      action: json['action'] as String? ?? '',
      isBlocked: json['is_blocked'] as bool? ?? false,
      blockId: json['blockId'] as String? ?? '',
      blockedUserId: json['blockedUserId'] as String? ?? '',
      blockedUser: json['blockedUser'] != null
          ? PostBlockedUser.fromJson(
              json['blockedUser'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'action': action,
      'is_blocked': isBlocked,
      'blockId': blockId,
      'blockedUserId': blockedUserId,
      'blockedUser': blockedUser?.toJson(),
    };
  }
}

class PostBlockedUser {
  final String mongoId;
  final String id;
  final String name;
  final String gender;
  final int age;
  final String profilePhoto;
  final String reason;
  final DateTime? blockedAt;

  const PostBlockedUser({
    required this.mongoId,
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.profilePhoto,
    required this.reason,
    required this.blockedAt,
  });

  factory PostBlockedUser.fromJson(Map<String, dynamic> json) {
    return PostBlockedUser(
      mongoId: json['_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      profilePhoto: json['profilePhoto'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      blockedAt: json['blockedAt'] != null
          ? DateTime.tryParse(json['blockedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': mongoId,
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'profilePhoto': profilePhoto,
      'reason': reason,
      'blockedAt': blockedAt?.toIso8601String(),
    };
  }
}
