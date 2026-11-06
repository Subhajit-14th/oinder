class DeleteAccountResponse {
  final bool success;
  final String message;
  final String deletedUserId;
  final DeletedUser? deletedUser;
  final CleanupSummary? cleanupSummary;

  const DeleteAccountResponse({
    required this.success,
    required this.message,
    required this.deletedUserId,
    this.deletedUser,
    this.cleanupSummary,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      deletedUserId: json['deletedUserId'] as String? ?? '',
      deletedUser: json['deletedUser'] != null
          ? DeletedUser.fromJson(json['deletedUser'] as Map<String, dynamic>)
          : null,
      cleanupSummary: json['cleanupSummary'] != null
          ? CleanupSummary.fromJson(
              json['cleanupSummary'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'deletedUserId': deletedUserId,
      'deletedUser': deletedUser?.toJson(),
      'cleanupSummary': cleanupSummary?.toJson(),
    };
  }
}

class DeletedUser {
  final String id;
  final String name;
  final String email;

  const DeletedUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory DeletedUser.fromJson(Map<String, dynamic> json) {
    return DeletedUser(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'email': email};
  }
}

class CleanupSummary {
  final int photosRemoved;
  final int likesRemoved;
  final int superLikesRemoved;
  final int threadsRemoved;
  final String reason;

  const CleanupSummary({
    required this.photosRemoved,
    required this.likesRemoved,
    required this.superLikesRemoved,
    required this.threadsRemoved,
    required this.reason,
  });

  factory CleanupSummary.fromJson(Map<String, dynamic> json) {
    return CleanupSummary(
      photosRemoved: json['photosRemoved'] as int? ?? 0,
      likesRemoved: json['likesRemoved'] as int? ?? 0,
      superLikesRemoved: json['superLikesRemoved'] as int? ?? 0,
      threadsRemoved: json['threadsRemoved'] as int? ?? 0,
      reason: json['reason'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photosRemoved': photosRemoved,
      'likesRemoved': likesRemoved,
      'superLikesRemoved': superLikesRemoved,
      'threadsRemoved': threadsRemoved,
      'reason': reason,
    };
  }
}
