class UserSuperLikeResponse {
  final bool? success;
  final String? message;
  final bool? isSuperLike;
  final bool? isLike;
  final bool? isMatch;
  final String? superLikedUserId;
  final String? likedUserId;
  final UserSuperLikeUser? user;

  const UserSuperLikeResponse({
    this.success,
    this.message,
    this.isSuperLike,
    this.isLike,
    this.isMatch,
    this.superLikedUserId,
    this.likedUserId,
    this.user,
  });

  factory UserSuperLikeResponse.fromJson(Map<String, dynamic> json) {
    return UserSuperLikeResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      isSuperLike: json['is_super_like'] as bool?,
      isLike: json['is_like'] as bool?,
      isMatch: json['isMatch'] as bool?,
      superLikedUserId: json['superLikedUserId'] as String?,
      likedUserId: json['likedUserId'] as String?,
      user: json['user'] != null
          ? UserSuperLikeUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'is_super_like': isSuperLike,
      'is_like': isLike,
      'isMatch': isMatch,
      'superLikedUserId': superLikedUserId,
      'likedUserId': likedUserId,
      'user': user?.toJson(),
    };
  }
}

class UserSuperLikeUser {
  final String? id;
  final String? cometChatUserId;
  final String? name;
  final String? profilePhoto;
  final int? age;
  final String? bday;
  final String? gender;
  final bool? isOnline;
  final String? onlineStatus;

  const UserSuperLikeUser({
    this.id,
    this.cometChatUserId,
    this.name,
    this.profilePhoto,
    this.age,
    this.bday,
    this.gender,
    this.isOnline,
    this.onlineStatus,
  });

  factory UserSuperLikeUser.fromJson(Map<String, dynamic> json) {
    return UserSuperLikeUser(
      id: json['id'] as String?,
      cometChatUserId: json['cometchat_user_id'] as String?,
      name: json['name'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      age: json['age'] as int?,
      bday: json['bday'] as String?,
      gender: json['gender'] as String?,
      isOnline: json['isOnline'] as bool?,
      onlineStatus: json['onlineStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cometchat_user_id': cometChatUserId,
      'name': name,
      'profilePhoto': profilePhoto,
      'age': age,
      'bday': bday,
      'gender': gender,
      'isOnline': isOnline,
      'onlineStatus': onlineStatus,
    };
  }
}
