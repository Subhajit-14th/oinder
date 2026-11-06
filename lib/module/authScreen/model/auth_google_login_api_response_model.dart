class GoogleLoginResponse {
  final bool status;
  final String message;
  final UserData? data;
  final String token;

  const GoogleLoginResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });

  factory GoogleLoginResponse.fromJson(Map<String, dynamic> json) {
    return GoogleLoginResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null ? UserData.fromJson(json["data"]) : null,
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson(),
      "token": token,
    };
  }
}

class UserData {
  final DiscoveryPreferences? discoveryPreferences;
  final Lifestyle? lifestyle;
  final UserLocation? location;

  final String fullname;
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String displayName;
  final String email;
  final String authProvider;
  final String gender;
  final bool showGenderOnProfile;
  final List<String> sexualOrientation;
  final bool showOrientationOnProfile;
  final List<String> interestedIn;
  final String relationshipGoals;
  final int distancePreference;
  final String college;
  final String educationLevel;
  final String communicationStyle;
  final String loveLanguage;
  final String bio;
  final List<String> interests;
  final String profilePhoto;
  final List<String> photos;
  final bool isProfileComplete;
  final String onboardingStep;
  final Map<String, dynamic> onboardingAnswers;
  final bool isVerified;
  final bool isEmailVerified;
  final String plan;
  final String subscriptionStatus;
  final String billingCycle;
  final bool isSuspended;
  final bool isFlagged;
  final String suspensionReason;
  final List<String> likedUsers;
  final List<String> likedByUsers;
  final List<String> matches;
  final String cometchatUserId;
  final bool isOnline;
  final List<dynamic> prompts;
  final DateTime? lastActiveAt;
  final DateTime? createdAt;
  final int version;
  final String googleId;
  final String googleIdDuplicate;

  const UserData({
    required this.discoveryPreferences,
    required this.lifestyle,
    required this.location,
    required this.fullname,
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.email,
    required this.authProvider,
    required this.gender,
    required this.showGenderOnProfile,
    required this.sexualOrientation,
    required this.showOrientationOnProfile,
    required this.interestedIn,
    required this.relationshipGoals,
    required this.distancePreference,
    required this.college,
    required this.educationLevel,
    required this.communicationStyle,
    required this.loveLanguage,
    required this.bio,
    required this.interests,
    required this.profilePhoto,
    required this.photos,
    required this.isProfileComplete,
    required this.onboardingStep,
    required this.onboardingAnswers,
    required this.isVerified,
    required this.isEmailVerified,
    required this.plan,
    required this.subscriptionStatus,
    required this.billingCycle,
    required this.isSuspended,
    required this.isFlagged,
    required this.suspensionReason,
    required this.likedUsers,
    required this.likedByUsers,
    required this.matches,
    required this.cometchatUserId,
    required this.isOnline,
    required this.prompts,
    required this.lastActiveAt,
    required this.createdAt,
    required this.version,
    required this.googleId,
    required this.googleIdDuplicate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      discoveryPreferences: json["discoveryPreferences"] != null
          ? DiscoveryPreferences.fromJson(json["discoveryPreferences"])
          : null,
      lifestyle: json["lifestyle"] != null
          ? Lifestyle.fromJson(json["lifestyle"])
          : null,
      location: json["location"] != null
          ? UserLocation.fromJson(json["location"])
          : null,
      fullname: json["fullname"] ?? "",
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      displayName: json["displayName"] ?? "",
      email: json["email"] ?? "",
      authProvider: json["authProvider"] ?? "",
      gender: json["gender"] ?? "",
      showGenderOnProfile: json["showGenderOnProfile"] ?? false,
      sexualOrientation: List<String>.from(
        json["sexualOrientation"] ?? const [],
      ),
      showOrientationOnProfile: json["showOrientationOnProfile"] ?? false,
      interestedIn: List<String>.from(json["interestedIn"] ?? const []),
      relationshipGoals: json["relationshipGoals"] ?? "",
      distancePreference: json["distancePreference"] ?? 0,
      college: json["college"] ?? "",
      educationLevel: json["educationLevel"] ?? "",
      communicationStyle: json["communicationStyle"] ?? "",
      loveLanguage: json["loveLanguage"] ?? "",
      bio: json["bio"] ?? "",
      interests: List<String>.from(json["interests"] ?? const []),
      profilePhoto: json["profilePhoto"] ?? "",
      photos: List<String>.from(json["photos"] ?? const []),
      isProfileComplete: json["isProfileComplete"] ?? false,
      onboardingStep: json["onboardingStep"] ?? "",
      onboardingAnswers: Map<String, dynamic>.from(
        json["onboardingAnswers"] ?? {},
      ),
      isVerified: json["isVerified"] ?? false,
      isEmailVerified: json["isEmailVerified"] ?? false,
      plan: json["plan"] ?? "",
      subscriptionStatus: json["subscriptionStatus"] ?? "",
      billingCycle: json["billingCycle"] ?? "",
      isSuspended: json["isSuspended"] ?? false,
      isFlagged: json["isFlagged"] ?? false,
      suspensionReason: json["suspensionReason"] ?? "",
      likedUsers: List<String>.from(json["likedUsers"] ?? const []),
      likedByUsers: List<String>.from(json["likedByUsers"] ?? const []),
      matches: List<String>.from(json["matches"] ?? const []),
      cometchatUserId: json["cometchat_user_id"] ?? "",
      isOnline: json["isOnline"] ?? false,
      prompts: List<dynamic>.from(json["prompts"] ?? const []),
      lastActiveAt: json["lastActiveAt"] != null
          ? DateTime.tryParse(json["lastActiveAt"])
          : null,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      version: json["__v"] ?? 0,
      googleId: json["google_id"] ?? "",
      googleIdDuplicate: json["googleId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "discoveryPreferences": discoveryPreferences?.toJson(),
    "lifestyle": lifestyle?.toJson(),
    "location": location?.toJson(),
    "fullname": fullname,
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
    "likedUsers": likedUsers,
    "likedByUsers": likedByUsers,
    "matches": matches,
    "cometchat_user_id": cometchatUserId,
    "isOnline": isOnline,
    "prompts": prompts,
    "lastActiveAt": lastActiveAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "__v": version,
    "google_id": googleId,
    "googleId": googleIdDuplicate,
  };
}

class DiscoveryPreferences {
  final String lookingFor;
  final List<String> interestedIn;
  final int maxDistance;
  final int distancePreference;
  final int minAge;
  final int maxAge;
  final bool isVerified;
  final String sortBy;
  final DateTime? updatedAt;

  const DiscoveryPreferences({
    required this.lookingFor,
    required this.interestedIn,
    required this.maxDistance,
    required this.distancePreference,
    required this.minAge,
    required this.maxAge,
    required this.isVerified,
    required this.sortBy,
    required this.updatedAt,
  });

  factory DiscoveryPreferences.fromJson(Map<String, dynamic> json) {
    return DiscoveryPreferences(
      lookingFor: json["lookingFor"] ?? "",
      interestedIn: List<String>.from(json["interestedIn"] ?? const []),
      maxDistance: json["maxDistance"] ?? 0,
      distancePreference: json["distancePreference"] ?? 0,
      minAge: json["minAge"] ?? 18,
      maxAge: json["maxAge"] ?? 70,
      isVerified: json["isVerified"] ?? false,
      sortBy: json["sortBy"] ?? "",
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
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

class Lifestyle {
  final String drinking;
  final String smoking;
  final String workout;
  final List<String> pets;

  const Lifestyle({
    required this.drinking,
    required this.smoking,
    required this.workout,
    required this.pets,
  });

  factory Lifestyle.fromJson(Map<String, dynamic> json) {
    return Lifestyle(
      drinking: json["drinking"] ?? "",
      smoking: json["smoking"] ?? "",
      workout: json["workout"] ?? "",
      pets: List<String>.from(json["pets"] ?? const []),
    );
  }

  Map<String, dynamic> toJson() => {
    "drinking": drinking,
    "smoking": smoking,
    "workout": workout,
    "pets": pets,
  };
}

class UserLocation {
  final String type;
  final List<double> coordinates;
  final double latitude;
  final double longitude;
  final String city;
  final String district;
  final String state;
  final String country;
  final String address;

  const UserLocation({
    required this.type,
    required this.coordinates,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.address,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      type: json["type"] ?? "",
      coordinates: (json["coordinates"] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
      latitude: (json["latitude"] ?? 0).toDouble(),
      longitude: (json["longitude"] ?? 0).toDouble(),
      city: json["city"] ?? "",
      district: json["district"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
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
