class EmailVerifyResponseModel {
  final bool? success;
  final String? message;
  final String? email;
  final bool? isVerified;
  final String? token;
  final UserModel? user;

  const EmailVerifyResponseModel({
    this.success,
    this.message,
    this.email,
    this.isVerified,
    this.token,
    this.user,
  });

  factory EmailVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return EmailVerifyResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      email: json['email'] as String?,
      isVerified: json['isVerified'] as bool?,
      token: json['token'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'email': email,
      'isVerified': isVerified,
      'token': token,
      'user': user?.toJson(),
    };
  }
}

class UserModel {
  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? email;
  final String? gender;
  final bool? showGenderOnProfile;
  final List<String>? sexualOrientation;
  final bool? showOrientationOnProfile;
  final List<String>? interestedIn;
  final String? relationshipGoals;
  final int? distancePreference;
  final String? college;
  final String? educationLevel;
  final String? communicationStyle;
  final String? loveLanguage;
  final LifestyleModel? lifestyle;
  final List<dynamic>? prompts;
  final String? bio;
  final List<String>? interests;
  final String? profilePhoto;
  final List<String>? photos;
  final LocationModel? location;
  final bool? isProfileComplete;
  final String? onboardingStep;
  final Map<String, dynamic>? onboardingAnswers;
  final String? authProvider;
  final bool? isVerified;
  final String? createdAt;

  const UserModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.displayName,
    this.email,
    this.gender,
    this.showGenderOnProfile,
    this.sexualOrientation,
    this.showOrientationOnProfile,
    this.interestedIn,
    this.relationshipGoals,
    this.distancePreference,
    this.college,
    this.educationLevel,
    this.communicationStyle,
    this.loveLanguage,
    this.lifestyle,
    this.prompts,
    this.bio,
    this.interests,
    this.profilePhoto,
    this.photos,
    this.location,
    this.isProfileComplete,
    this.onboardingStep,
    this.onboardingAnswers,
    this.authProvider,
    this.isVerified,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      showGenderOnProfile: json['showGenderOnProfile'] as bool?,
      sexualOrientation: (json['sexualOrientation'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      showOrientationOnProfile: json['showOrientationOnProfile'] as bool?,
      interestedIn: (json['interestedIn'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      relationshipGoals: json['relationshipGoals'] as String?,
      distancePreference: json['distancePreference'] as int?,
      college: json['college'] as String?,
      educationLevel: json['educationLevel'] as String?,
      communicationStyle: json['communicationStyle'] as String?,
      loveLanguage: json['loveLanguage'] as String?,
      lifestyle: json['lifestyle'] != null
          ? LifestyleModel.fromJson(json['lifestyle'] as Map<String, dynamic>)
          : null,
      prompts: json['prompts'] as List?,
      bio: json['bio'] as String?,
      interests: (json['interests'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      profilePhoto: json['profilePhoto'] as String?,
      photos: (json['photos'] as List?)?.map((e) => e.toString()).toList(),
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      isProfileComplete: json['isProfileComplete'] as bool?,
      onboardingStep: json['onboardingStep'] as String?,
      onboardingAnswers: json['onboardingAnswers'] as Map<String, dynamic>?,
      authProvider: json['authProvider'] as String?,
      isVerified: json['isVerified'] as bool?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'email': email,
      'gender': gender,
      'showGenderOnProfile': showGenderOnProfile,
      'sexualOrientation': sexualOrientation,
      'showOrientationOnProfile': showOrientationOnProfile,
      'interestedIn': interestedIn,
      'relationshipGoals': relationshipGoals,
      'distancePreference': distancePreference,
      'college': college,
      'educationLevel': educationLevel,
      'communicationStyle': communicationStyle,
      'loveLanguage': loveLanguage,
      'lifestyle': lifestyle?.toJson(),
      'prompts': prompts,
      'bio': bio,
      'interests': interests,
      'profilePhoto': profilePhoto,
      'photos': photos,
      'location': location?.toJson(),
      'isProfileComplete': isProfileComplete,
      'onboardingStep': onboardingStep,
      'onboardingAnswers': onboardingAnswers,
      'authProvider': authProvider,
      'isVerified': isVerified,
      'createdAt': createdAt,
    };
  }
}

class LifestyleModel {
  final String? drinking;
  final String? smoking;
  final String? workout;
  final List<String>? pets;

  const LifestyleModel({this.drinking, this.smoking, this.workout, this.pets});

  factory LifestyleModel.fromJson(Map<String, dynamic> json) {
    return LifestyleModel(
      drinking: json['drinking'] as String?,
      smoking: json['smoking'] as String?,
      workout: json['workout'] as String?,
      pets: (json['pets'] as List?)?.map((e) => e.toString()).toList(),
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

class LocationModel {
  final String? type;
  final List<double>? coordinates;
  final String? city;
  final String? state;
  final String? country;
  final String? address;

  const LocationModel({
    this.type,
    this.coordinates,
    this.city,
    this.state,
    this.country,
    this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      address: json['address'] as String?,
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
