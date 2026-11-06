class LikeResponseModel {
  final bool? success;
  final String? message;
  final bool? isLike;
  final bool? isMatch;
  final String? likedUserId;
  final LikedUserModel? user;

  const LikeResponseModel({
    this.success,
    this.message,
    this.isLike,
    this.isMatch,
    this.likedUserId,
    this.user,
  });

  factory LikeResponseModel.fromJson(Map<String, dynamic> json) {
    return LikeResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      isLike: json['is_like'] as bool?,
      isMatch: json['isMatch'] as bool?,
      likedUserId: json['likedUserId'] as String?,
      user: json['user'] != null
          ? LikedUserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'is_like': isLike,
      'isMatch': isMatch,
      'likedUserId': likedUserId,
      'user': user?.toJson(),
    };
  }
}

class LikedUserModel {
  final String? id;
  final String? cometchatUserId;
  final String? name;
  final String? profilePhoto;
  final int? age;
  final String? gender;
  final bool? isOnline;
  final String? onlineStatus;

  const LikedUserModel({
    this.id,
    this.cometchatUserId,
    this.name,
    this.profilePhoto,
    this.age,
    this.gender,
    this.isOnline,
    this.onlineStatus,
  });

  factory LikedUserModel.fromJson(Map<String, dynamic> json) {
    return LikedUserModel(
      id: json['id'] as String?,
      cometchatUserId: json['cometchat_user_id'] as String?,
      name: json['name'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      isOnline: json['isOnline'] as bool?,
      onlineStatus: json['onlineStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cometchat_user_id': cometchatUserId,
      'name': name,
      'profilePhoto': profilePhoto,
      'age': age,
      'gender': gender,
      'isOnline': isOnline,
      'onlineStatus': onlineStatus,
    };
  }
}
