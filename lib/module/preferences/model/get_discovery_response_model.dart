class DiscoveryPreferencesResponse {
  final bool success;
  final String? type;
  final int count;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final DiscoveryFiltersApplied? filtersApplied;
  final List<UserProfileModel> users;

  const DiscoveryPreferencesResponse({
    required this.success,
    this.type,
    required this.count,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    this.filtersApplied,
    required this.users,
  });

  factory DiscoveryPreferencesResponse.fromJson(Map<String, dynamic> json) {
    return DiscoveryPreferencesResponse(
      success: json['success'] ?? false,
      type: json['type'],
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      filtersApplied: json['filtersApplied'] != null
          ? DiscoveryFiltersApplied.fromJson(json['filtersApplied'])
          : null,
      users:
          (json['users'] as List<dynamic>?)
              ?.map((e) => UserProfileModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "type": type,
      "count": count,
      "total": total,
      "page": page,
      "limit": limit,
      "totalPages": totalPages,
      "filtersApplied": filtersApplied?.toJson(),
      "users": users.map((e) => e.toJson()).toList(),
    };
  }
}

/// FILTER MODEL
class DiscoveryFiltersApplied {
  final String? type;
  final String? lookingFor;
  final String? lookingForInput;
  final String? intent;
  final List<String> interestedIn;
  final List<String> interestedInInput;
  final String? showMe;
  final int? maxDistance;
  final int? distance;
  final int? minAge;
  final int? maxAge;
  final List<int> ageRange;
  final bool? isVerified;
  final String? userId;
  final ReferenceCoordinates? referenceCoordinates;

  const DiscoveryFiltersApplied({
    this.type,
    this.lookingFor,
    this.lookingForInput,
    this.intent,
    required this.interestedIn,
    required this.interestedInInput,
    this.showMe,
    this.maxDistance,
    this.distance,
    this.minAge,
    this.maxAge,
    required this.ageRange,
    this.isVerified,
    this.userId,
    this.referenceCoordinates,
  });

  factory DiscoveryFiltersApplied.fromJson(Map<String, dynamic> json) {
    return DiscoveryFiltersApplied(
      type: json['type'],
      lookingFor: json['lookingFor'],
      lookingForInput: json['lookingForInput'],
      intent: json['intent'],
      interestedIn:
          (json['interestedIn'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      interestedInInput:
          (json['interestedInInput'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      showMe: json['showMe'],
      maxDistance: json['maxDistance'],
      distance: json['distance'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
      ageRange:
          (json['ageRange'] as List?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      isVerified: json['isVerified'],
      userId: json['userId'],
      referenceCoordinates: json['referenceCoordinates'] != null
          ? ReferenceCoordinates.fromJson(json['referenceCoordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "lookingFor": lookingFor,
      "lookingForInput": lookingForInput,
      "intent": intent,
      "interestedIn": interestedIn,
      "interestedInInput": interestedInInput,
      "showMe": showMe,
      "maxDistance": maxDistance,
      "distance": distance,
      "minAge": minAge,
      "maxAge": maxAge,
      "ageRange": ageRange,
      "isVerified": isVerified,
      "userId": userId,
      "referenceCoordinates": referenceCoordinates?.toJson(),
    };
  }
}

/// USER MODEL

class UserProfileModel {
  final String id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final List<dynamic>? sexualOrientation;
  final List<dynamic>? interestedIn;
  final String? relationshipGoals;
  final int? distancePreference;
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
  final bool? isVerified;
  final bool? isEmailVerified;
  final String? plan;
  final DateTime? createdAt;
  final int? age;
  final DateTime? birthDate;
  final DiscoveryUserPreferences? discoveryPreferences;
  final double? distanceKm;
  final double? distance;

  UserProfileModel({
    required this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.sexualOrientation,
    this.interestedIn,
    this.relationshipGoals,
    this.distancePreference,
    this.college,
    this.educationLevel,
    this.communicationStyle,
    this.loveLanguage,
    this.lifestyle,
    this.bio,
    required this.interests,
    this.profilePhoto,
    required this.photos,
    this.location,
    this.isProfileComplete,
    this.onboardingStep,
    this.isVerified,
    this.isEmailVerified,
    this.plan,
    this.createdAt,
    this.age,
    this.birthDate,
    this.discoveryPreferences,
    this.distanceKm,
    this.distance,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] ?? "",
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      sexualOrientation: (json['sexualOrientation'] as List?) ?? [],
      interestedIn: (json['interestedIn'] as List?) ?? [],
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
      interests:
          (json['interests'] as List?)?.map((e) => e.toString()).toList() ?? [],
      profilePhoto: json['profilePhoto'],
      photos:
          (json['photos'] as List?)?.map((e) => e.toString()).toList() ?? [],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      isProfileComplete: json['isProfileComplete'],
      onboardingStep: json['onboardingStep'],
      isVerified: json['isVerified'],
      isEmailVerified: json['isEmailVerified'],
      plan: json['plan'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      age: json['age'],
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
      discoveryPreferences: json['discoveryPreferences'] != null
          ? DiscoveryUserPreferences.fromJson(json['discoveryPreferences'])
          : null,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "gender": gender,
      "interests": interests,
      "profilePhoto": profilePhoto,
      "photos": photos,
      "age": age,
      "isVerified": isVerified,
    };
  }
}

class LifestyleModel {
  final String? drinking;
  final String? smoking;
  final String? workout;
  final List<String> pets;

  LifestyleModel({
    this.drinking,
    this.smoking,
    this.workout,
    required this.pets,
  });

  factory LifestyleModel.fromJson(Map<String, dynamic> json) {
    return LifestyleModel(
      drinking: json['drinking'],
      smoking: json['smoking'],
      workout: json['workout'],
      pets: (json['pets'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class LocationModel {
  final String? city;
  final String? state;
  final String? country;
  final double? latitude;
  final double? longitude;

  LocationModel({
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['city'],
      state: json['state'],
      country: json['country'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}

class DiscoveryUserPreferences {
  final int? maxDistance;
  final int? minAge;
  final int? maxAge;
  final bool? isVerified;
  final String? lookingFor;

  DiscoveryUserPreferences({
    this.maxDistance,
    this.minAge,
    this.maxAge,
    this.isVerified,
    this.lookingFor,
  });

  factory DiscoveryUserPreferences.fromJson(Map<String, dynamic> json) {
    return DiscoveryUserPreferences(
      maxDistance: json['maxDistance'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
      isVerified: json['isVerified'],
      lookingFor: json['lookingFor'],
    );
  }
}

class ReferenceCoordinates {
  final double? latitude;
  final double? longitude;

  ReferenceCoordinates({this.latitude, this.longitude});

  factory ReferenceCoordinates.fromJson(Map<String, dynamic> json) {
    return ReferenceCoordinates(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"latitude": latitude, "longitude": longitude};
  }
}
