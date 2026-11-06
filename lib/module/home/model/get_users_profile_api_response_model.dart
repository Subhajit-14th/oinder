class UsersResponseModel {
  final bool? success;
  final String? category;
  final String? vibe;
  final String? type;
  final int? count;
  final int? total;
  final List<UserProfileModel>? users;

  UsersResponseModel({
    this.success,
    this.category,
    this.vibe,
    this.type,
    this.count,
    this.total,
    this.users,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      success: json["success"],
      category: json["category"],
      vibe: json["vibe"],
      type: json["type"],
      count: json["count"],
      total: json["total"],
      users: (json["users"] as List?)
          ?.map((e) => UserProfileModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "category": category,
      "vibe": vibe,
      "type": type,
      "count": count,
      "total": total,
      "users": users?.map((e) => e.toJson()).toList(),
    };
  }
}

class UserProfileModel {
  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? displayName;

  final String? email;
  final String? phoneNumber;

  final String? authProvider;

  final String? gender;
  final bool? showGenderOnProfile;

  final List<String>? sexualOrientation;
  final bool? showOrientationOnProfile;

  final List<dynamic>? interestedIn;

  final String? relationshipGoals;
  final int? distancePreference;

  final String? college;
  final String? educationLevel;

  final String? communicationStyle;
  final String? loveLanguage;

  final LifestyleModel? lifestyle;

  final String? bio;

  final List<String>? interests;

  final String? profilePhoto;
  final List<String>? photos;

  final LocationModel? location;

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

  final List<String>? prompts;

  final String? createdAt;

  final int? version;

  final int? age;
  final String? birthDate;

  final DiscoveryPreferencesModel? discoveryPreferences;

  final List<String>? likedUsers;
  final List<String>? likedByUsers;
  final List<String>? matches;

  final String? photo;
  final List<String>? photes;

  final String? type;

  final String? cometchatUserId;

  final bool? isOnline;
  final String? onlineStatus;
  final String? lastActiveText;
  final String? lastActiveAt;

  final bool? isHide;
  final bool? isVisible;

  final bool? isLike;
  final bool? isMatch;
  final bool? canChat;

  final String? bday;

  UserProfileModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.displayName,
    this.email,
    this.phoneNumber,
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
    this.prompts,
    this.createdAt,
    this.version,
    this.age,
    this.birthDate,
    this.discoveryPreferences,
    this.likedUsers,
    this.likedByUsers,
    this.matches,
    this.photo,
    this.photes,
    this.type,
    this.cometchatUserId,
    this.isOnline,
    this.onlineStatus,
    this.lastActiveText,
    this.lastActiveAt,
    this.isHide,
    this.isVisible,
    this.isLike,
    this.isMatch,
    this.canChat,
    this.bday,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'],

      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      displayName: json['displayName'],

      email: json['email'],
      phoneNumber: json['phoneNumber'],

      authProvider: json['authProvider'],

      gender: json['gender'],
      showGenderOnProfile: json['showGenderOnProfile'],

      sexualOrientation: (json['sexualOrientation'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      showOrientationOnProfile: json['showOrientationOnProfile'],

      interestedIn: (json['interestedIn'] as List?)?.toList(),

      relationshipGoals: json['relationshipGoals'],

      distancePreference: json['distancePreference'],

      college: json['college'],
      educationLevel: json['educationLevel'],

      communicationStyle: json['communicationStyle'],

      loveLanguage: json['loveLanguage'],

      lifestyle: json['lifestyle'] != null
          ? LifestyleModel.fromJson(json['lifestyle'])
          : null,

      bio: json['bio'],

      interests: (json['interests'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      profilePhoto: json['profilePhoto'],

      photos: (json['photos'] as List?)?.map((e) => e.toString()).toList(),

      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,

      isProfileComplete: json['isProfileComplete'],

      onboardingStep: json['onboardingStep'],

      onboardingAnswers: json['onboardingAnswers'],

      isVerified: json['isVerified'],

      isEmailVerified: json['isEmailVerified'],

      plan: json['plan'],

      subscriptionStatus: json['subscriptionStatus'],

      billingCycle: json['billingCycle'],

      isSuspended: json['isSuspended'],

      isFlagged: json['isFlagged'],

      suspensionReason: json['suspensionReason'],

      prompts: (json['prompts'] as List?)?.map((e) => e.toString()).toList(),

      createdAt: json['createdAt'],

      version: json['__v'],

      age: json['age'],

      birthDate: json['birthDate'],

      discoveryPreferences: json['discoveryPreferences'] != null
          ? DiscoveryPreferencesModel.fromJson(json['discoveryPreferences'])
          : null,

      likedUsers: (json['likedUsers'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      likedByUsers: (json['likedByUsers'] as List?)
          ?.map((e) => e.toString())
          .toList(),

      matches: (json['matches'] as List?)?.map((e) => e.toString()).toList(),

      photo: json["photo"],

      photes: (json["photes"] as List?)?.map((e) => e.toString()).toList(),

      type: json["type"],

      cometchatUserId: json["cometchat_user_id"],

      isOnline: json["isOnline"],

      onlineStatus: json["onlineStatus"],

      lastActiveText: json["lastActiveText"],

      lastActiveAt: json["lastActiveAt"],

      isHide: json["is_hide"],

      isVisible: json["is_visible"],

      isLike: json["is_like"],

      isMatch: json["isMatch"],

      canChat: json["canChat"],

      bday: json["bday"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,

      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "displayName": displayName,

      "email": email,
      "phoneNumber": phoneNumber,

      "authProvider": authProvider,

      "gender": gender,

      "sexualOrientation": sexualOrientation,

      "interestedIn": interestedIn,

      "relationshipGoals": relationshipGoals,

      "distancePreference": distancePreference,

      "lifestyle": lifestyle?.toJson(),

      "location": location?.toJson(),

      "photos": photos,

      "profilePhoto": profilePhoto,

      "discoveryPreferences": discoveryPreferences?.toJson(),

      "photo": photo,
      "photes": photes,

      "type": type,

      "cometchat_user_id": cometchatUserId,

      "isOnline": isOnline,

      "onlineStatus": onlineStatus,

      "lastActiveText": lastActiveText,

      "lastActiveAt": lastActiveAt,

      "is_hide": isHide,

      "is_visible": isVisible,

      "is_like": isLike,

      "isMatch": isMatch,

      "canChat": canChat,

      "bday": bday,
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
      drinking: json['drinking'],
      smoking: json['smoking'],
      workout: json['workout'],

      pets: (json['pets'] as List?)?.map((e) => e.toString()).toList(),
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
      type: json['type'],

      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),

      latitude: (json['latitude'] as num?)?.toDouble(),

      longitude: (json['longitude'] as num?)?.toDouble(),

      city: json['city'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
      address: json['address'],
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

class DiscoveryPreferencesModel {
  final int? distancePreference;

  final dynamic interestedIn;

  final bool? isVerified;

  final String? lookingFor;

  final int? maxAge;
  final int? minAge;

  final int? maxDistance;

  final String? sortBy;

  final String? updatedAt;

  DiscoveryPreferencesModel({
    this.distancePreference,
    this.interestedIn,
    this.isVerified,
    this.lookingFor,
    this.maxAge,
    this.minAge,
    this.maxDistance,
    this.sortBy,
    this.updatedAt,
  });

  factory DiscoveryPreferencesModel.fromJson(Map<String, dynamic> json) {
    return DiscoveryPreferencesModel(
      distancePreference: json['distancePreference'],

      interestedIn: json['interestedIn'],

      isVerified: json['isVerified'],

      lookingFor: json['lookingFor'],

      maxAge: json['maxAge'],

      minAge: json['minAge'],

      maxDistance: json['maxDistance'],

      sortBy: json['sortBy'],

      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "distancePreference": distancePreference,

      "interestedIn": interestedIn,

      "isVerified": isVerified,

      "lookingFor": lookingFor,

      "maxAge": maxAge,

      "minAge": minAge,

      "maxDistance": maxDistance,

      "sortBy": sortBy,

      "updatedAt": updatedAt,
    };
  }
}
