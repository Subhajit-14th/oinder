class PhotoUploadResponseModel {
  final bool? success;
  final String? message;
  final String? userId;
  final String? profilePhoto;

  final List<PhotoItemModel> photoList;

  final int? count;
  final int? maxAllowed;

  final UserModel? user;

  const PhotoUploadResponseModel({
    this.success,
    this.message,
    this.userId,
    this.profilePhoto,
    this.photoList = const [],
    this.count,
    this.maxAllowed,
    this.user,
  });

  factory PhotoUploadResponseModel.fromJson(Map<String, dynamic> json) {
    return PhotoUploadResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      userId: json['userId'] as String?,
      profilePhoto: json['profilePhoto'] as String?,

      photoList:
          (json['photoList'] as List<dynamic>?)
              ?.map((e) => PhotoItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],

      count: json['count'] as int?,
      maxAllowed: json['maxAllowed'] as int?,

      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "userId": userId,
      "profilePhoto": profilePhoto,
      "photoList": photoList.map((e) => e.toJson()).toList(),
      "count": count,
      "maxAllowed": maxAllowed,
      "user": user?.toJson(),
    };
  }
}

class PhotoItemModel {
  final int? id;
  final String? photoId;
  final String? url;

  const PhotoItemModel({this.id, this.photoId, this.url});

  factory PhotoItemModel.fromJson(Map<String, dynamic> json) {
    return PhotoItemModel(
      id: json['id'] as int?,
      photoId: json['photoId'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "photoId": photoId, "url": url};
  }
}

class UserModel {
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

  final List<String> sexualOrientation;
  final bool? showOrientationOnProfile;

  final List<String> interestedIn;

  final String? relationshipGoals;
  final int? distancePreference;

  final DiscoveryPreferencesModel? discoveryPreferences;

  final String? college;
  final String? educationLevel;

  final String? communicationStyle;
  final String? loveLanguage;

  final LifestyleModel? lifestyle;

  final String? bio;
  final List<String> interests;

  final String? profilePhoto;
  final List<String> photos;

  final LocationModel? location;

  final bool? isProfileComplete;
  final String? onboardingStep;

  final Map<String, dynamic> onboardingAnswers;

  final bool? isVerified;
  final bool? isEmailVerified;

  final String? plan;
  final String? subscriptionStatus;
  final String? billingCycle;

  final bool? isSuspended;
  final bool? isFlagged;

  final String? suspensionReason;

  final List<String> likedUsers;
  final List<String> likedByUsers;

  final List<String> matches;

  final String? cometchatUserId;

  final bool? isOnline;
  final String? onlineStatus;

  final String? lastActiveAt;
  final String? lastActiveText;

  final String? googleId;
  final String? googleIdSnake;

  final int? age;

  final String? bday;
  final String? birthDate;

  final List<String> superLikedByUsers;
  final List<String> superLikedUsers;

  final String? photo;

  final List<String> photes;

  final DateTime? createdAt;

  const UserModel({
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
    this.sexualOrientation = const [],
    this.showOrientationOnProfile,
    this.interestedIn = const [],
    this.relationshipGoals,
    this.distancePreference,
    this.discoveryPreferences,
    this.college,
    this.educationLevel,
    this.communicationStyle,
    this.loveLanguage,
    this.lifestyle,
    this.bio,
    this.interests = const [],
    this.profilePhoto,
    this.photos = const [],
    this.location,
    this.isProfileComplete,
    this.onboardingStep,
    this.onboardingAnswers = const {},
    this.isVerified,
    this.isEmailVerified,
    this.plan,
    this.subscriptionStatus,
    this.billingCycle,
    this.isSuspended,
    this.isFlagged,
    this.suspensionReason,
    this.likedUsers = const [],
    this.likedByUsers = const [],
    this.matches = const [],
    this.cometchatUserId,
    this.isOnline,
    this.onlineStatus,
    this.lastActiveAt,
    this.lastActiveText,
    this.googleId,
    this.googleIdSnake,
    this.age,
    this.bday,
    this.birthDate,
    this.superLikedByUsers = const [],
    this.superLikedUsers = const [],
    this.photo,
    this.photes = const [],
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      displayName: json['displayName'] as String?,
      fullname: json['fullname'] as String?,

      email: json['email'] as String?,
      authProvider: json['authProvider'] as String?,

      gender: json['gender'] as String?,
      showGenderOnProfile: json['showGenderOnProfile'] as bool?,

      sexualOrientation: List<String>.from(json['sexualOrientation'] ?? []),

      showOrientationOnProfile: json['showOrientationOnProfile'] as bool?,

      interestedIn: List<String>.from(json['interestedIn'] ?? []),

      relationshipGoals: json['relationshipGoals'] as String?,

      distancePreference: json['distancePreference'] as int?,

      discoveryPreferences: json['discoveryPreferences'] != null
          ? DiscoveryPreferencesModel.fromJson(json['discoveryPreferences'])
          : null,

      college: json['college'] as String?,
      educationLevel: json['educationLevel'] as String?,

      communicationStyle: json['communicationStyle'] as String?,

      loveLanguage: json['loveLanguage'] as String?,

      lifestyle: json['lifestyle'] != null
          ? LifestyleModel.fromJson(json['lifestyle'])
          : null,

      bio: json['bio'] as String?,

      interests: List<String>.from(json['interests'] ?? []),

      profilePhoto: json['profilePhoto'] as String?,

      photos: List<String>.from(json['photos'] ?? []),

      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,

      isProfileComplete: json['isProfileComplete'] as bool?,

      onboardingStep: json['onboardingStep'] as String?,

      onboardingAnswers: Map<String, dynamic>.from(
        json['onboardingAnswers'] ?? {},
      ),

      isVerified: json['isVerified'] as bool?,

      isEmailVerified: json['isEmailVerified'] as bool?,

      plan: json['plan'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String?,

      billingCycle: json['billingCycle'] as String?,

      isSuspended: json['isSuspended'] as bool?,

      isFlagged: json['isFlagged'] as bool?,

      suspensionReason: json['suspensionReason'] as String?,

      likedUsers: List<String>.from(json['likedUsers'] ?? []),

      likedByUsers: List<String>.from(json['likedByUsers'] ?? []),

      matches: List<String>.from(json['matches'] ?? []),

      cometchatUserId: json['cometchat_user_id'] as String?,

      isOnline: json['isOnline'] as bool?,

      onlineStatus: json['onlineStatus'] as String?,

      lastActiveAt: json['lastActiveAt'] as String?,

      lastActiveText: json['lastActiveText'] as String?,

      googleId: json['googleId'] as String?,

      googleIdSnake: json['google_id'] as String?,

      age: json['age'] as int?,

      bday: json['bday'] as String?,

      birthDate: json['birthDate'] as String?,

      superLikedByUsers: List<String>.from(json['superLikedByUsers'] ?? []),

      superLikedUsers: List<String>.from(json['superLikedUsers'] ?? []),

      photo: json['photo'] as String?,

      photes: List<String>.from(json['photes'] ?? []),

      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "gender": gender,
      "photos": photos,
      "profilePhoto": profilePhoto,
      "interestedIn": interestedIn,
      "location": location?.toJson(),
    };
  }
}

class DiscoveryPreferencesModel {
  final String? lookingFor;
  final List<String> interestedIn;
  final int? maxDistance;
  final int? distancePreference;
  final int? minAge;
  final int? maxAge;
  final bool? isVerified;
  final String? sortBy;
  final DateTime? updatedAt;

  const DiscoveryPreferencesModel({
    this.lookingFor,
    this.interestedIn = const [],
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
      lookingFor: json['lookingFor'] as String?,

      interestedIn: List<String>.from(json['interestedIn'] ?? []),

      maxDistance: json['maxDistance'] as int?,

      distancePreference: json['distancePreference'] as int?,

      minAge: json['minAge'] as int?,

      maxAge: json['maxAge'] as int?,

      isVerified: json['isVerified'] as bool?,

      sortBy: json['sortBy'] as String?,

      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}

class LifestyleModel {
  final String? drinking;
  final String? smoking;
  final String? workout;
  final List<String> pets;

  const LifestyleModel({
    this.drinking,
    this.smoking,
    this.workout,
    this.pets = const [],
  });

  factory LifestyleModel.fromJson(Map<String, dynamic> json) {
    return LifestyleModel(
      drinking: json['drinking'] as String?,

      smoking: json['smoking'] as String?,

      workout: json['workout'] as String?,

      pets: List<String>.from(json['pets'] ?? []),
    );
  }
}

class LocationModel {
  final String? type;
  final List<double> coordinates;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final String? address;

  const LocationModel({
    this.type,
    this.coordinates = const [],
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

      coordinates:
          (json['coordinates'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],

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
