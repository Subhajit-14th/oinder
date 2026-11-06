class UpdateLocationResponse {
  final bool? success;
  final String? message;
  final LocationModel? location;
  final UserProfileModel? user;

  UpdateLocationResponse({
    this.success,
    this.message,
    this.location,
    this.user,
  });

  factory UpdateLocationResponse.fromJson(Map<String, dynamic> json) {
    return UpdateLocationResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? UserProfileModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'location': location?.toJson(),
      'user': user?.toJson(),
    };
  }
}

class LocationModel {
  final String? type;
  final List<double>? coordinates;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final String? address;

  LocationModel({
    this.type,
    this.coordinates,
    this.latitude,
    this.longitude,
    this.city,
    this.district,
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
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      city: json['city'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'district': district,
      'state': state,
      'country': country,
      'address': address,
    };
  }
}

class UserProfileModel {
  final DiscoveryPreferencesModel? discoveryPreferences;
  final LifestyleModel? lifestyle;
  final LocationModel? location;

  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? email;
  final String? authProvider;

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

  final String? bio;

  final List<String>? interests;

  final String? profilePhoto;
  final List<String>? photos;

  final bool? isProfileComplete;
  final String? onboardingStep;
  final Map<String, dynamic>? onboardingAnswers;

  final bool? isVerified;
  final bool? isEmailVerified;

  final String? plan;
  final String? subscriptionStatus;
  final String? billingCycle;

  final bool? isSuspended;
  final bool? isFlagged;
  final String? suspensionReason;

  final List<dynamic>? prompts;

  final DateTime? createdAt;
  final int? version;

  final int? age;
  final DateTime? birthDate;

  UserProfileModel({
    this.discoveryPreferences,
    this.lifestyle,
    this.location,
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.displayName,
    this.email,
    this.authProvider,
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
    this.bio,
    this.interests,
    this.profilePhoto,
    this.photos,
    this.isProfileComplete,
    this.onboardingStep,
    this.onboardingAnswers,
    this.isVerified,
    this.isEmailVerified,
    this.plan,
    this.subscriptionStatus,
    this.billingCycle,
    this.isSuspended,
    this.isFlagged,
    this.suspensionReason,
    this.prompts,
    this.createdAt,
    this.version,
    this.age,
    this.birthDate,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      discoveryPreferences: json['discoveryPreferences'] != null
          ? DiscoveryPreferencesModel.fromJson(json['discoveryPreferences'])
          : null,

      lifestyle: json['lifestyle'] != null
          ? LifestyleModel.fromJson(json['lifestyle'])
          : null,

      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,

      id: json['_id'] as String?,
      name: json['name'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      authProvider: json['authProvider'] as String?,

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

      distancePreference: (json['distancePreference'] as num?)?.toInt(),

      college: json['college'] as String?,
      educationLevel: json['educationLevel'] as String?,
      communicationStyle: json['communicationStyle'] as String?,
      loveLanguage: json['loveLanguage'] as String?,

      bio: json['bio'] as String?,

      interests: (json['interests'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      profilePhoto: json['profilePhoto'] as String?,

      photos: (json['photos'] as List?)?.map((e) => e.toString()).toList(),

      isProfileComplete: json['isProfileComplete'] as bool?,

      onboardingStep: json['onboardingStep'] as String?,

      onboardingAnswers: json['onboardingAnswers'] != null
          ? Map<String, dynamic>.from(json['onboardingAnswers'])
          : null,

      isVerified: json['isVerified'] as bool?,

      isEmailVerified: json['isEmailVerified'] as bool?,

      plan: json['plan'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String?,
      billingCycle: json['billingCycle'] as String?,

      isSuspended: json['isSuspended'] as bool?,

      isFlagged: json['isFlagged'] as bool?,

      suspensionReason: json['suspensionReason'] as String?,

      prompts: json['prompts'] as List<dynamic>?,

      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,

      version: (json['__v'] as num?)?.toInt(),

      age: (json['age'] as num?)?.toInt(),

      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discoveryPreferences': discoveryPreferences?.toJson(),
      'lifestyle': lifestyle?.toJson(),
      'location': location?.toJson(),
      '_id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'email': email,
      'authProvider': authProvider,
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
      'bio': bio,
      'interests': interests,
      'profilePhoto': profilePhoto,
      'photos': photos,
      'isProfileComplete': isProfileComplete,
      'onboardingStep': onboardingStep,
      'onboardingAnswers': onboardingAnswers,
      'isVerified': isVerified,
      'isEmailVerified': isEmailVerified,
      'plan': plan,
      'subscriptionStatus': subscriptionStatus,
      'billingCycle': billingCycle,
      'isSuspended': isSuspended,
      'isFlagged': isFlagged,
      'suspensionReason': suspensionReason,
      'prompts': prompts,
      'createdAt': createdAt?.toIso8601String(),
      '__v': version,
      'age': age,
      'birthDate': birthDate?.toIso8601String(),
    };
  }
}

class DiscoveryPreferencesModel {
  final String? sortBy;
  final int? distancePreference;
  final List<String>? interestedIn;
  final bool? isVerified;
  final String? lookingFor;
  final int? maxAge;
  final int? maxDistance;
  final int? minAge;
  final DateTime? updatedAt;

  DiscoveryPreferencesModel({
    this.sortBy,
    this.distancePreference,
    this.interestedIn,
    this.isVerified,
    this.lookingFor,
    this.maxAge,
    this.maxDistance,
    this.minAge,
    this.updatedAt,
  });

  factory DiscoveryPreferencesModel.fromJson(Map<String, dynamic> json) {
    return DiscoveryPreferencesModel(
      sortBy: json['sortBy'] as String?,
      distancePreference: (json['distancePreference'] as num?)?.toInt(),
      interestedIn: (json['interestedIn'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      isVerified: json['isVerified'] as bool?,
      lookingFor: json['lookingFor'] as String?,
      maxAge: (json['maxAge'] as num?)?.toInt(),
      maxDistance: (json['maxDistance'] as num?)?.toInt(),
      minAge: (json['minAge'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sortBy': sortBy,
      'distancePreference': distancePreference,
      'interestedIn': interestedIn,
      'isVerified': isVerified,
      'lookingFor': lookingFor,
      'maxAge': maxAge,
      'maxDistance': maxDistance,
      'minAge': minAge,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class LifestyleModel {
  final String? drinking;
  final String? smoking;
  final String? workout;
  final List<String>? pets;

  LifestyleModel({this.drinking, this.smoking, this.workout, this.pets});

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
