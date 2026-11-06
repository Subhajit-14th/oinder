class ProfileDetailsResponse {
  final bool? status;
  final String? message;
  final ProfileDetailsModel? data;

  const ProfileDetailsResponse({this.status, this.message, this.data});

  factory ProfileDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsResponse(
      status: json["status"] as bool?,
      message: json["message"] as String?,
      data: json["data"] != null
          ? ProfileDetailsModel.fromJson(json["data"] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data?.toJson()};
  }
}

class ProfileDetailsModel {
  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? fullname;

  final String? email;
  final String? phoneNumber;
  final String? phone;

  final String? googleId;
  final String? googleIdAlt;

  final String? authProvider;
  final String? bday;

  final String? gender;

  final bool? showGenderOnProfile;

  final List<String>? sexualOrientation;

  final bool? showOrientationOnProfile;

  final List<String>? interestedIn;

  final String? relationshipGoals;

  final int? distancePreference;

  final DiscoveryPreferencesModel? discoveryPreferences;

  final String? college;
  final String? educationLevel;
  final String? communicationStyle;
  final String? loveLanguage;

  final ProfileLifestyleModel? lifestyle;

  final String? bio;

  final List<String>? interests;

  final String? profilePhoto;

  final List<String>? photos;

  final ProfileLocationModel? location;

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

  final List<String>? likedUsers;
  final List<String>? likedByUsers;

  final List<String>? superLikedUsers;
  final List<String>? superLikedByUsers;

  final List<String>? matches;

  final String? cometchatUserId;

  final bool? isOnline;

  final List<dynamic>? prompts;

  final DateTime? lastActiveAt;

  final DateTime? createdAt;

  final int? version;

  final List<String>? blockedUsers;

  final List<String>? blockedByUsers;

  final bool? isHide;

  final int? age;

  final DateTime? birthDate;

  final double? distanceKm;

  final int? matchPercentage;

  final String? matchPercentageFormatted;

  final List<String>? commonInterests;

  final int? commonInterestsCount;

  final MatchDetailsModel? matchDetails;

  final String? onlineStatus;

  final String? lastActiveText;

  const ProfileDetailsModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.displayName,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.phone,
    this.googleId,
    this.googleIdAlt,
    this.authProvider,
    this.bday,
    this.gender,
    this.showGenderOnProfile,
    this.sexualOrientation,
    this.showOrientationOnProfile,
    this.interestedIn,
    this.relationshipGoals,
    this.distancePreference,
    this.discoveryPreferences,
    this.college,
    this.educationLevel,
    this.communicationStyle,
    this.loveLanguage,
    this.lifestyle,
    this.bio,
    this.interests,
    this.profilePhoto,
    this.photos,
    this.location,
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
    this.likedUsers,
    this.likedByUsers,
    this.superLikedUsers,
    this.superLikedByUsers,
    this.matches,
    this.cometchatUserId,
    this.isOnline,
    this.prompts,
    this.lastActiveAt,
    this.createdAt,
    this.version,
    this.blockedUsers,
    this.blockedByUsers,
    this.isHide,
    this.age,
    this.birthDate,
    this.distanceKm,
    this.matchPercentage,
    this.matchPercentageFormatted,
    this.commonInterests,
    this.commonInterestsCount,
    this.matchDetails,
    this.onlineStatus,
    this.lastActiveText,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      id: json["_id"],
      name: json["name"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      displayName: json["displayName"],
      fullname: json["fullname"],

      email: json["email"],
      phoneNumber: json["phoneNumber"],
      phone: json["phone"],

      googleId: json["googleId"],
      googleIdAlt: json["google_id"],

      authProvider: json["authProvider"],

      bday: json["bday"],

      gender: json["gender"],

      showGenderOnProfile: json["showGenderOnProfile"],

      sexualOrientation: (json["sexualOrientation"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      showOrientationOnProfile: json["showOrientationOnProfile"],

      interestedIn: (json["interestedIn"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      relationshipGoals: json["relationshipGoals"],

      distancePreference: json["distancePreference"],

      discoveryPreferences: json["discoveryPreferences"] != null
          ? DiscoveryPreferencesModel.fromJson(json["discoveryPreferences"])
          : null,

      college: json["college"],

      educationLevel: json["educationLevel"],

      communicationStyle: json["communicationStyle"],

      loveLanguage: json["loveLanguage"],

      lifestyle: json["lifestyle"] != null
          ? ProfileLifestyleModel.fromJson(json["lifestyle"])
          : null,

      bio: json["bio"],

      interests: (json["interests"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      profilePhoto: json["profilePhoto"],

      photos: (json["photos"] as List?)?.map((e) => e.toString()).toList(),

      location: json["location"] != null
          ? ProfileLocationModel.fromJson(json["location"])
          : null,

      isProfileComplete: json["isProfileComplete"],

      onboardingStep: json["onboardingStep"],

      onboardingAnswers: json["onboardingAnswers"],

      isVerified: json["isVerified"],

      isEmailVerified: json["isEmailVerified"],

      plan: json["plan"],

      subscriptionStatus: json["subscriptionStatus"],

      billingCycle: json["billingCycle"],

      isSuspended: json["isSuspended"],

      isFlagged: json["isFlagged"],

      suspensionReason: json["suspensionReason"],

      likedUsers: _list(json["likedUsers"]),

      likedByUsers: _list(json["likedByUsers"]),

      superLikedUsers: _list(json["superLikedUsers"]),

      superLikedByUsers: _list(json["superLikedByUsers"]),

      matches: _list(json["matches"]),

      cometchatUserId: json["cometchat_user_id"],

      isOnline: json["isOnline"],

      prompts: json["prompts"],

      lastActiveAt: _date(json["lastActiveAt"]),

      createdAt: _date(json["createdAt"]),

      version: json["__v"],

      blockedUsers: _list(json["blockedUsers"]),

      blockedByUsers: _list(json["blockedByUsers"]),

      isHide: json["is_hide"],

      age: json["age"],

      birthDate: _date(json["birthDate"]),

      distanceKm: (json["distanceKm"] as num?)?.toDouble(),

      matchPercentage: json["matchPercentage"],

      matchPercentageFormatted: json["matchPercentageFormatted"],

      commonInterests: _list(json["commonInterests"]),

      commonInterestsCount: json["commonInterestsCount"],

      matchDetails: json["matchDetails"] != null
          ? MatchDetailsModel.fromJson(json["matchDetails"])
          : null,

      onlineStatus: json["onlineStatus"],

      lastActiveText: json["lastActiveText"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "displayName": displayName,
      "fullname": fullname,
      "email": email,
      "profilePhoto": profilePhoto,
      "photos": photos,
      "location": location?.toJson(),
      "lifestyle": lifestyle?.toJson(),
      "matchDetails": matchDetails?.toJson(),
    };
  }
}

List<String>? _list(dynamic value) {
  return (value as List?)?.map((e) => e.toString()).toList();
}

DateTime? _date(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}

class DiscoveryPreferencesModel {
  final String? lookingFor;
  final List<String>? interestedIn;
  final int? maxDistance;
  final int? distancePreference;
  final int? minAge;
  final int? maxAge;
  final bool? isVerified;
  final String? sortBy;
  final DateTime? updatedAt;

  const DiscoveryPreferencesModel({
    this.lookingFor,
    this.interestedIn,
    this.maxDistance,
    this.distancePreference,
    this.minAge,
    this.maxAge,
    this.isVerified,
    this.sortBy,
    this.updatedAt,
  });

  factory DiscoveryPreferencesModel.fromJson(Map<String, dynamic> json) {
    return DiscoveryPreferencesModel(
      lookingFor: json["lookingFor"],

      interestedIn: (json["interestedIn"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      maxDistance: json["maxDistance"],

      distancePreference: json["distancePreference"],

      minAge: json["minAge"],

      maxAge: json["maxAge"],

      isVerified: json["isVerified"],

      sortBy: json["sortBy"],

      updatedAt: _date(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lookingFor": lookingFor,
      "interestedIn": interestedIn,
      "maxDistance": maxDistance,
      "distancePreference": distancePreference,
      "minAge": minAge,
      "maxAge": maxAge,
      "isVerified": isVerified,
      "sortBy": sortBy,
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}

class ProfileLifestyleModel {
  final String? drinking;
  final String? smoking;
  final String? workout;
  final List<String>? pets;

  const ProfileLifestyleModel({
    this.drinking,
    this.smoking,
    this.workout,
    this.pets,
  });

  factory ProfileLifestyleModel.fromJson(Map<String, dynamic> json) {
    return ProfileLifestyleModel(
      drinking: json["drinking"],

      smoking: json["smoking"],

      workout: json["workout"],

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

class ProfileLocationModel {
  final String? type;

  final List<double>? coordinates;

  final double? latitude;

  final double? longitude;

  final String? city;

  final String? district;

  final String? state;

  final String? country;

  final String? address;

  const ProfileLocationModel({
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

  factory ProfileLocationModel.fromJson(Map<String, dynamic> json) {
    return ProfileLocationModel(
      type: json["type"],

      coordinates: (json["coordinates"] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),

      latitude: (json["latitude"] as num?)?.toDouble(),

      longitude: (json["longitude"] as num?)?.toDouble(),

      city: json["city"],

      district: json["district"],

      state: json["state"],

      country: json["country"],

      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,

      "coordinates": coordinates,

      "latitude": latitude,

      "longitude": longitude,

      "city": city,

      "district": district,

      "state": state,

      "country": country,

      "address": address,
    };
  }
}

class MatchDetailsModel {
  final int? matchPercentage;

  final String? matchPercentageFormatted;

  final List<String>? commonInterests;

  final int? commonInterestsCount;

  final MatchBreakdownModel? breakdown;

  const MatchDetailsModel({
    this.matchPercentage,

    this.matchPercentageFormatted,

    this.commonInterests,

    this.commonInterestsCount,

    this.breakdown,
  });

  factory MatchDetailsModel.fromJson(Map<String, dynamic> json) {
    return MatchDetailsModel(
      matchPercentage: json["matchPercentage"],

      matchPercentageFormatted: json["matchPercentageFormatted"],

      commonInterests: (json["commonInterests"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      commonInterestsCount: json["commonInterestsCount"],

      breakdown: json["breakdown"] != null
          ? MatchBreakdownModel.fromJson(json["breakdown"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "matchPercentage": matchPercentage,

      "matchPercentageFormatted": matchPercentageFormatted,

      "commonInterests": commonInterests,

      "commonInterestsCount": commonInterestsCount,

      "breakdown": breakdown?.toJson(),
    };
  }
}

class MatchBreakdownModel {
  final int? interestsScore;

  final int? proximityScore;

  final int? lifestyleScore;

  final int? intentScore;

  const MatchBreakdownModel({
    this.interestsScore,

    this.proximityScore,

    this.lifestyleScore,

    this.intentScore,
  });

  factory MatchBreakdownModel.fromJson(Map<String, dynamic> json) {
    return MatchBreakdownModel(
      interestsScore: json["interestsScore"],

      proximityScore: json["proximityScore"],

      lifestyleScore: json["lifestyleScore"],

      intentScore: json["intentScore"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "interestsScore": interestsScore,

      "proximityScore": proximityScore,

      "lifestyleScore": lifestyleScore,

      "intentScore": intentScore,
    };
  }
}
