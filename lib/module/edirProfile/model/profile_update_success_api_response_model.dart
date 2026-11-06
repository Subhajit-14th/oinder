class UpdateProfileResponseModel {
  final bool? success;
  final String? message;
  final UserProfileModel? user;

  UpdateProfileResponseModel({this.success, this.message, this.user});

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      success: json["success"] as bool?,
      message: json["message"] as String?,
      user: json["user"] != null
          ? UserProfileModel.fromJson(json["user"] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "user": user?.toJson()};
  }
}

class UserProfileModel {
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
      lifestyle: json["lifestyle"] != null
          ? LifestyleModel.fromJson(json["lifestyle"])
          : null,

      location: json["location"] != null
          ? LocationModel.fromJson(json["location"])
          : null,

      id: json["_id"] as String?,

      name: json["name"] as String?,

      firstName: json["firstName"] as String?,

      lastName: json["lastName"] as String?,

      displayName: json["displayName"] as String?,

      email: json["email"] as String?,

      authProvider: json["authProvider"] as String?,

      gender: json["gender"] as String?,

      showGenderOnProfile: json["showGenderOnProfile"] as bool?,

      sexualOrientation: (json["sexualOrientation"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      showOrientationOnProfile: json["showOrientationOnProfile"] as bool?,

      interestedIn: (json["interestedIn"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      relationshipGoals: json["relationshipGoals"] as String?,

      distancePreference: json["distancePreference"] as int?,

      college: json["college"] as String?,

      educationLevel: json["educationLevel"] as String?,

      communicationStyle: json["communicationStyle"] as String?,

      loveLanguage: json["loveLanguage"] as String?,

      bio: json["bio"] as String?,

      interests: (json["interests"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      profilePhoto: json["profilePhoto"] as String?,

      photos: (json["photos"] as List?)?.map((e) => e.toString()).toList(),

      isProfileComplete: json["isProfileComplete"] as bool?,

      onboardingStep: json["onboardingStep"] as String?,

      onboardingAnswers: json["onboardingAnswers"] != null
          ? Map<String, dynamic>.from(json["onboardingAnswers"])
          : null,

      isVerified: json["isVerified"] as bool?,

      isEmailVerified: json["isEmailVerified"] as bool?,

      plan: json["plan"] as String?,

      subscriptionStatus: json["subscriptionStatus"] as String?,

      billingCycle: json["billingCycle"] as String?,

      isSuspended: json["isSuspended"] as bool?,

      isFlagged: json["isFlagged"] as bool?,

      suspensionReason: json["suspensionReason"] as String?,

      prompts: json["prompts"] as List?,

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,

      version: json["__v"] as int?,

      age: json["age"] as int?,

      birthDate: json["birthDate"] != null
          ? DateTime.tryParse(json["birthDate"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lifestyle": lifestyle?.toJson(),

      "location": location?.toJson(),

      "_id": id,

      "name": name,

      "firstName": firstName,

      "lastName": lastName,

      "displayName": displayName,

      "email": email,

      "authProvider": authProvider,

      "gender": gender,

      "showGenderOnProfile": showGenderOnProfile,

      "sexualOrientation": sexualOrientation,

      "showOrientationOnProfile": showOrientationOnProfile,

      "interestedIn": interestedIn,

      "relationshipGoals": relationshipGoals,

      "distancePreference": distancePreference,

      "college": college,

      "educationLevel": educationLevel,

      "communicationStyle": communicationStyle,

      "loveLanguage": loveLanguage,

      "bio": bio,

      "interests": interests,

      "profilePhoto": profilePhoto,

      "photos": photos,

      "isProfileComplete": isProfileComplete,

      "onboardingStep": onboardingStep,

      "onboardingAnswers": onboardingAnswers,

      "isVerified": isVerified,

      "isEmailVerified": isEmailVerified,

      "plan": plan,

      "subscriptionStatus": subscriptionStatus,

      "billingCycle": billingCycle,

      "isSuspended": isSuspended,

      "isFlagged": isFlagged,

      "suspensionReason": suspensionReason,

      "prompts": prompts,

      "createdAt": createdAt?.toIso8601String(),

      "__v": version,

      "age": age,

      "birthDate": birthDate?.toIso8601String(),
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
      drinking: json["drinking"] as String?,

      smoking: json["smoking"] as String?,

      workout: json["workout"] as String?,

      pets: (json["pets"] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "drinking": drinking,
      "smoking": smoking,
      "workout": workout,
      "pets": pets,
    };
  }
}

class LocationModel {
  final String? district;
  final String? type;

  final List<double>? coordinates;

  final double? latitude;
  final double? longitude;

  final String? city;
  final String? state;
  final String? country;
  final String? address;

  LocationModel({
    this.district,
    this.type,
    this.coordinates,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.country,
    this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      district: json["district"] as String?,

      type: json["type"] as String?,

      coordinates: (json["coordinates"] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),

      latitude: (json["latitude"] as num?)?.toDouble(),

      longitude: (json["longitude"] as num?)?.toDouble(),

      city: json["city"] as String?,

      state: json["state"] as String?,

      country: json["country"] as String?,

      address: json["address"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "district": district,

      "type": type,

      "coordinates": coordinates,

      "latitude": latitude,

      "longitude": longitude,

      "city": city,

      "state": state,

      "country": country,

      "address": address,
    };
  }
}
