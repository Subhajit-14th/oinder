class UserProfileModel {
  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? displayName;
  final String? fullname;
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
  final DateTime? lastActiveAt;

  final int? version;
  final int? age;

  final DateTime? birthDate;

  final String? birthday;
  final String? dob;
  final String? dateOfBirth;
  final String? dateOfBirthSnake;
  final String? bday;
  final String? bDay;

  final LifestyleModel? lifestyle;

  final LocationModel? location;

  final DiscoveryPreferencesModel? discoveryPreferences;

  final List<String>? likedUsers;
  final List<String>? likedByUsers;

  final List<dynamic>? matches;

  final String? cometchatUserId;

  final bool? isOnline;

  final bool? hideProfile;
  final bool? isHide;
  final bool? is_hide;
  final bool? is_visible;

  final String? googleId;
  final String? google_id;

  UserProfileModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.displayName,
    this.fullname,

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
    this.lastActiveAt,

    this.version,
    this.age,

    this.birthDate,

    this.birthday,
    this.dob,
    this.dateOfBirth,
    this.dateOfBirthSnake,
    this.bday,
    this.bDay,

    this.lifestyle,

    this.location,

    this.discoveryPreferences,

    this.likedUsers,
    this.likedByUsers,

    this.matches,

    this.cometchatUserId,

    this.isOnline,

    this.googleId,
    this.google_id,

    this.hideProfile,
    this.isHide,
    this.is_hide,
    this.is_visible,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json["_id"],

      name: json["name"],

      firstName: json["firstName"],

      lastName: json["lastName"],

      displayName: json["displayName"],

      fullname: json["fullname"],

      email: json["email"],

      authProvider: json["authProvider"],

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

      college: json["college"],

      educationLevel: json["educationLevel"],

      communicationStyle: json["communicationStyle"],

      loveLanguage: json["loveLanguage"],

      bio: json["bio"],

      interests: (json["interests"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      profilePhoto: json["profilePhoto"],

      photos: (json["photos"] as List?)?.map((e) => e.toString()).toList(),

      isProfileComplete: json["isProfileComplete"],

      onboardingStep: json["onboardingStep"],

      onboardingAnswers: json["onboardingAnswers"] != null
          ? Map<String, dynamic>.from(json["onboardingAnswers"])
          : {},

      isVerified: json["isVerified"],

      isEmailVerified: json["isEmailVerified"],

      plan: json["plan"],

      subscriptionStatus: json["subscriptionStatus"],

      billingCycle: json["billingCycle"],

      isSuspended: json["isSuspended"],

      isFlagged: json["isFlagged"],

      suspensionReason: json["suspensionReason"],

      prompts: json["prompts"],

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,

      lastActiveAt: json["lastActiveAt"] != null
          ? DateTime.tryParse(json["lastActiveAt"])
          : null,

      version: json["__v"],

      age: json["age"],

      birthDate: (() {
        final value =
            json["birthDate"] ??
            json["birthday"] ??
            json["dateOfBirth"] ??
            json["date_of_birth"] ??
            json["dob"] ??
            json["b_day"] ??
            json["bday"];

        if (value == null) return null;

        return DateTime.tryParse(value.toString());
      })(),

      birthday: json["birthday"]?.toString(),
      dob: json["dob"]?.toString(),
      dateOfBirth: json["dateOfBirth"]?.toString(),
      dateOfBirthSnake: json["date_of_birth"]?.toString(),
      bday: json["bday"]?.toString(),
      bDay: json["b_day"]?.toString(),

      lifestyle: json["lifestyle"] != null
          ? LifestyleModel.fromJson(json["lifestyle"])
          : null,

      location: json["location"] != null
          ? LocationModel.fromJson(json["location"])
          : null,

      discoveryPreferences: json["discoveryPreferences"] != null
          ? DiscoveryPreferencesModel.fromJson(json["discoveryPreferences"])
          : null,

      likedUsers: (json["likedUsers"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      likedByUsers: (json["likedByUsers"] as List?)
          ?.map((e) => e.toString())
          .toList(),

      matches: json["matches"],

      cometchatUserId: json["cometchat_user_id"],

      isOnline: json["isOnline"],

      googleId: json["googleId"],

      google_id: json["google_id"],

      hideProfile: json["hideProfile"],

      isHide: json["isHide"],

      is_hide: json["is_hide"],

      is_visible: json["is_visible"],
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

      "lastActiveAt": lastActiveAt?.toIso8601String(),

      "__v": version,

      "age": age,

      "birthDate": birthDate?.toIso8601String(),

      "birthday": birthday,
      "dob": dob,
      "dateOfBirth": dateOfBirth,
      "date_of_birth": dateOfBirthSnake,
      "bday": bday,
      "b_day": bDay,

      "lifestyle": lifestyle?.toJson(),

      "location": location?.toJson(),

      "discoveryPreferences": discoveryPreferences?.toJson(),

      "likedUsers": likedUsers,

      "likedByUsers": likedByUsers,

      "matches": matches,

      "cometchat_user_id": cometchatUserId,

      "isOnline": isOnline,

      "googleId": googleId,

      "google_id": google_id,

      "hideProfile": hideProfile,

      "isHide": isHide,

      "is_hide": is_hide,

      "is_visible": is_visible,
    };
  }
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

  DiscoveryPreferencesModel({
    this.lookingFor,
    this.interestedIn,
    this.maxDistance,
    this.distancePreference,
    this.minAge,
    this.maxAge,
    this.isVerified,
    this.sortBy,
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
  final String? type;
  final List<double>? coordinates;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? state;
  final String? country;
  final String? address;

  LocationModel({
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
