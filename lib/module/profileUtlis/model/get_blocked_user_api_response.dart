class BlockedUserResponse {
  final bool success;
  final String message;
  final int total;
  final List<BlockedUser> blockedUsers;
  final List<BlockedUser> users;

  const BlockedUserResponse({
    required this.success,
    required this.message,
    required this.total,
    required this.blockedUsers,
    required this.users,
  });

  factory BlockedUserResponse.fromJson(Map<String, dynamic> json) {
    return BlockedUserResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      total: json['total'] as int? ?? 0,
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => BlockedUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <BlockedUser>[],
      users:
          (json['users'] as List<dynamic>?)
              ?.map((e) => BlockedUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <BlockedUser>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'total': total,
      'blockedUsers': blockedUsers.map((e) => e.toJson()).toList(),
      'users': users.map((e) => e.toJson()).toList(),
    };
  }
}

class BlockedUser {
  final String id;
  final String mongoId;
  final String cometchatUserId;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int age;
  final String bday;
  final DateTime? birthDate;
  final String bio;
  final String relationshipGoals;
  final String profilePhoto;
  final List<String> photos;
  final String city;
  final String state;
  final String country;
  final bool isVerified;
  final bool isBlocked;
  final DateTime? blockedAt;
  final String reason;

  const BlockedUser({
    required this.id,
    required this.mongoId,
    required this.cometchatUserId,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.bday,
    required this.birthDate,
    required this.bio,
    required this.relationshipGoals,
    required this.profilePhoto,
    required this.photos,
    required this.city,
    required this.state,
    required this.country,
    required this.isVerified,
    required this.isBlocked,
    required this.blockedAt,
    required this.reason,
  });

  factory BlockedUser.fromJson(Map<String, dynamic> json) {
    return BlockedUser(
      id: json['id'] as String? ?? '',
      mongoId: json['_id'] as String? ?? '',
      cometchatUserId: json['cometchat_user_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      bday: json['bday'] as String? ?? '',
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'] as String)
          : null,
      bio: json['bio'] as String? ?? '',
      relationshipGoals: json['relationshipGoals'] as String? ?? '',
      profilePhoto: json['profilePhoto'] as String? ?? '',
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          <String>[],
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      isBlocked: json['is_blocked'] as bool? ?? false,
      blockedAt: json['blockedAt'] != null
          ? DateTime.tryParse(json['blockedAt'] as String)
          : null,
      reason: json['reason'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': mongoId,
      'id': id,
      'cometchat_user_id': cometchatUserId,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'age': age,
      'bday': bday,
      'birthDate': birthDate?.toIso8601String(),
      'bio': bio,
      'relationshipGoals': relationshipGoals,
      'profilePhoto': profilePhoto,
      'photos': photos,
      'city': city,
      'state': state,
      'country': country,
      'isVerified': isVerified,
      'is_blocked': isBlocked,
      'blockedAt': blockedAt?.toIso8601String(),
      'reason': reason,
    };
  }
}
