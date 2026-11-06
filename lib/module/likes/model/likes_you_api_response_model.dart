class LikesYouResponse {
  final bool success;
  final bool isSubscribe;
  final int count;
  final List<LikeUser> users;

  const LikesYouResponse({
    required this.success,
    required this.isSubscribe,
    required this.count,
    required this.users,
  });

  factory LikesYouResponse.fromJson(Map<String, dynamic> json) {
    return LikesYouResponse(
      success: json['success'] as bool? ?? false,
      isSubscribe: json['is_subscribe'] as bool? ?? false,
      count: json['count'] as int? ?? 0,
      users:
          (json['users'] as List<dynamic>?)
              ?.map((e) => LikeUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'isSubscribe': isSubscribe,
      'count': count,
      'users': users.map((e) => e.toJson()).toList(),
    };
  }
}

class LikeUser {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int? age;
  final DateTime? birthDate;
  final String relationshipGoals;
  final String bio;
  final String profilePhoto;
  final List<String> photos;
  final UserLocation? location;
  final String city;
  final String state;
  final String country;
  final String college;
  final List<String> interests;
  final UserLifestyle? lifestyle;
  final String plan;
  final bool isSubscribe;
  final bool isVerified;
  final bool isMatch;
  final DateTime? likedAt;

  const LikeUser({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    this.age,
    this.birthDate,
    required this.relationshipGoals,
    required this.bio,
    required this.profilePhoto,
    required this.photos,
    this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.college,
    required this.interests,
    this.lifestyle,
    required this.plan,
    required this.isSubscribe,
    required this.isVerified,
    required this.isMatch,
    this.likedAt,
  });

  factory LikeUser.fromJson(Map<String, dynamic> json) {
    return LikeUser(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      gender: json['gender'] as String? ?? '',

      age: json['age'] as int?,

      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,

      relationshipGoals: json['relationshipGoals'] as String? ?? '',

      bio: json['bio'] as String? ?? '',

      profilePhoto: json['profilePhoto'] as String? ?? '',

      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],

      location: json['location'] != null
          ? UserLocation.fromJson(json['location'] as Map<String, dynamic>)
          : null,

      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',

      college: json['college'] as String? ?? '',

      interests:
          (json['interests'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],

      lifestyle: json['lifestyle'] != null
          ? UserLifestyle.fromJson(json['lifestyle'] as Map<String, dynamic>)
          : null,

      plan: json['plan'] as String? ?? '',

      isSubscribe: json['is_subscribe'] as bool? ?? false,

      isVerified: json['isVerified'] as bool? ?? false,

      isMatch: json['isMatch'] as bool? ?? false,

      likedAt: json['likedAt'] != null
          ? DateTime.tryParse(json['likedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'age': age,
      'birthDate': birthDate?.toIso8601String(),
      'relationshipGoals': relationshipGoals,
      'bio': bio,
      'profilePhoto': profilePhoto,
      'photos': photos,
      'location': location?.toJson(),
      'city': city,
      'state': state,
      'country': country,
      'college': college,
      'interests': interests,
      'lifestyle': lifestyle?.toJson(),
      'plan': plan,
      'is_subscribe': isSubscribe,
      'isVerified': isVerified,
      'isMatch': isMatch,
      'likedAt': likedAt?.toIso8601String(),
    };
  }
}

class UserLocation {
  final String type;
  final List<double> coordinates;
  final String city;
  final String state;
  final String country;
  final String address;

  const UserLocation({
    required this.type,
    required this.coordinates,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      type: json['type'] as String? ?? '',

      coordinates:
          (json['coordinates'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],

      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
      'city': city,
      'state': state,
      'country': country,
      'address': address,
    };
  }
}

class UserLifestyle {
  final String drinking;
  final String smoking;
  final String workout;
  final List<String> pets;

  const UserLifestyle({
    required this.drinking,
    required this.smoking,
    required this.workout,
    required this.pets,
  });

  factory UserLifestyle.fromJson(Map<String, dynamic> json) {
    return UserLifestyle(
      drinking: json['drinking'] as String? ?? '',
      smoking: json['smoking'] as String? ?? '',
      workout: json['workout'] as String? ?? '',

      pets:
          (json['pets'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drinking': drinking,
      'smoking': smoking,
      'workout': workout,
      'pets': pets,
    };
  }
}
