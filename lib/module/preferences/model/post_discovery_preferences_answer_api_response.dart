class DiscoveryResponse {
  final bool success;
  final int count;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final DiscoveryFilters? filtersApplied;
  final List<DiscoveryUser> users;

  const DiscoveryResponse({
    required this.success,
    required this.count,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    this.filtersApplied,
    required this.users,
  });

  factory DiscoveryResponse.fromJson(Map<String, dynamic> json) {
    return DiscoveryResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 0,
      totalPages: json['totalPages'] ?? 0,

      filtersApplied: json['filtersApplied'] != null
          ? DiscoveryFilters.fromJson(json['filtersApplied'])
          : null,

      users: (json['users'] as List<dynamic>? ?? [])
          .map((e) => DiscoveryUser.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
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

class DiscoveryFilters {
  final String? type;

  final String? lookingFor;
  final String? lookingForInput;

  final String? intent;

  final List<String> interestedIn;
  final dynamic interestedInInput;

  final String? showMe;

  final int? maxDistance;
  final int? distance;

  final int? minAge;
  final int? maxAge;

  final List<int> ageRange;

  final bool? isVerified;

  final String? userId;

  final ReferenceCoordinates? referenceCoordinates;

  const DiscoveryFilters({
    this.type,
    this.lookingFor,
    this.lookingForInput,
    this.intent,
    required this.interestedIn,
    this.interestedInInput,
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

  factory DiscoveryFilters.fromJson(Map<String, dynamic> json) {
    return DiscoveryFilters(
      type: json['type'],

      lookingFor: json['lookingFor'],

      lookingForInput: json['lookingForInput'],

      intent: json['intent'],

      interestedIn: (json['interestedIn'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      // Sometimes String ID, sometimes List
      interestedInInput: json['interestedInInput'],

      showMe: json['showMe'],

      maxDistance: json['maxDistance'],

      distance: json['distance'],

      minAge: json['minAge'],

      maxAge: json['maxAge'],

      ageRange: (json['ageRange'] as List<dynamic>? ?? [])
          .map((e) => int.tryParse(e.toString()) ?? 0)
          .toList(),

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

class DiscoveryUser {
  final String id;

  final String? name;

  final String? firstName;

  final String? lastName;

  final String? displayName;

  final String? email;

  final String? phoneNumber;

  final String? authProvider;

  final DateTime? birthDate;

  final int? age;

  final String? gender;

  final bool? showGenderOnProfile;

  final List<String> sexualOrientation;

  final bool? showOrientationOnProfile;

  final List<String> interestedIn;

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

  final DiscoveryLocation? location;

  final bool? isProfileComplete;

  final String? onboardingStep;

  final Map<String, dynamic>? onboardingAnswers;

  final bool? isVerified;

  final bool? isEmailVerified;

  final String? plan;

  final String? subscriptionStatus;

  final String? billingCycle;

  final DateTime? subscriptionRenewalDate;

  final bool? isSuspended;

  final bool? isFlagged;

  final String? suspensionReason;

  final List<dynamic> prompts;

  final DiscoveryPreferences? discoveryPreferences;

  final double? distanceKm;

  final double? distance;

  // NEW FIELDS

  final List<dynamic> likedUsers;

  final List<dynamic> likedByUsers;

  final List<dynamic> matches;

  final DateTime? createdAt;

  final String? cometchatUserId;

  final bool? isOnline;

  final String? onlineStatus;

  final DateTime? lastActiveAt;

  final String? lastActiveText;

  final String? type;

  const DiscoveryUser({
    required this.id,

    this.name,

    this.firstName,

    this.lastName,

    this.displayName,

    this.email,

    this.phoneNumber,

    this.authProvider,

    this.birthDate,

    this.age,

    this.gender,

    this.showGenderOnProfile,

    required this.sexualOrientation,

    this.showOrientationOnProfile,

    required this.interestedIn,

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

    this.onboardingAnswers,

    this.isVerified,

    this.isEmailVerified,

    this.plan,

    this.subscriptionStatus,

    this.billingCycle,

    this.subscriptionRenewalDate,

    this.isSuspended,

    this.isFlagged,

    this.suspensionReason,

    required this.prompts,

    this.discoveryPreferences,

    this.distanceKm,

    this.distance,

    required this.likedUsers,

    required this.likedByUsers,

    required this.matches,

    this.createdAt,

    this.cometchatUserId,

    this.isOnline,

    this.onlineStatus,

    this.lastActiveAt,

    this.lastActiveText,

    this.type,
  });

  factory DiscoveryUser.fromJson(Map<String, dynamic> json) {
    return DiscoveryUser(
      id: json['_id'] ?? "",

      name: json['name'],

      firstName: json['firstName'],

      lastName: json['lastName'],

      displayName: json['displayName'],

      email: json['email'],

      phoneNumber: json['phoneNumber'],

      authProvider: json['authProvider'],

      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,

      age: json['age'],

      gender: json['gender'],

      showGenderOnProfile: json['showGenderOnProfile'],

      sexualOrientation: List<String>.from(json['sexualOrientation'] ?? []),

      showOrientationOnProfile: json['showOrientationOnProfile'],

      interestedIn: List<String>.from(json['interestedIn'] ?? []),

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

      interests: List<String>.from(json['interests'] ?? []),

      profilePhoto: json['profilePhoto'],

      photos: List<String>.from(json['photos'] ?? []),

      location: json['location'] != null
          ? DiscoveryLocation.fromJson(json['location'])
          : null,

      isProfileComplete: json['isProfileComplete'],

      onboardingStep: json['onboardingStep'],

      onboardingAnswers: json['onboardingAnswers'],

      isVerified: json['isVerified'],

      isEmailVerified: json['isEmailVerified'],

      plan: json['plan'],

      subscriptionStatus: json['subscriptionStatus'],

      billingCycle: json['billingCycle'],

      subscriptionRenewalDate: json['subscriptionRenewalDate'] != null
          ? DateTime.tryParse(json['subscriptionRenewalDate'])
          : null,

      isSuspended: json['isSuspended'],

      isFlagged: json['isFlagged'],

      suspensionReason: json['suspensionReason'],

      prompts: json['prompts'] ?? [],

      discoveryPreferences: json['discoveryPreferences'] != null
          ? DiscoveryPreferences.fromJson(json['discoveryPreferences'])
          : null,

      distanceKm: (json['distanceKm'] as num?)?.toDouble(),

      distance: (json['distance'] as num?)?.toDouble(),

      likedUsers: json['likedUsers'] ?? [],

      likedByUsers: json['likedByUsers'] ?? [],

      matches: json['matches'] ?? [],

      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,

      cometchatUserId: json['cometchat_user_id'],

      isOnline: json['isOnline'],

      onlineStatus: json['onlineStatus'],

      lastActiveAt: json['lastActiveAt'] != null
          ? DateTime.tryParse(json['lastActiveAt'])
          : null,

      lastActiveText: json['lastActiveText'],

      type: json['type'],
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

      "birthDate": birthDate?.toIso8601String(),

      "age": age,

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

      "lifestyle": lifestyle?.toJson(),

      "bio": bio,

      "interests": interests,

      "profilePhoto": profilePhoto,

      "photos": photos,

      "location": location?.toJson(),

      "isProfileComplete": isProfileComplete,

      "onboardingStep": onboardingStep,

      "onboardingAnswers": onboardingAnswers,

      "isVerified": isVerified,

      "isEmailVerified": isEmailVerified,

      "plan": plan,

      "subscriptionStatus": subscriptionStatus,

      "billingCycle": billingCycle,

      "subscriptionRenewalDate": subscriptionRenewalDate?.toIso8601String(),

      "isSuspended": isSuspended,

      "isFlagged": isFlagged,

      "suspensionReason": suspensionReason,

      "prompts": prompts,

      "discoveryPreferences": discoveryPreferences?.toJson(),

      "distanceKm": distanceKm,

      "distance": distance,

      // NEW FIELDS
      "likedUsers": likedUsers,

      "likedByUsers": likedByUsers,

      "matches": matches,

      "createdAt": createdAt?.toIso8601String(),

      // Backend uses snake_case
      "cometchat_user_id": cometchatUserId,

      "isOnline": isOnline,

      "onlineStatus": onlineStatus,

      "lastActiveAt": lastActiveAt?.toIso8601String(),

      "lastActiveText": lastActiveText,

      "type": type,
    };
  }
}

class ReferenceCoordinates {
  final double? latitude;
  final double? longitude;

  const ReferenceCoordinates({this.latitude, this.longitude});

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

/// LIFESTYLE MODEL

class LifestyleModel {
  final String? drinking;

  final String? smoking;

  final String? workout;

  final List<String> pets;

  const LifestyleModel({
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

      pets: (json['pets'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
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

/// LOCATION MODEL

class DiscoveryLocation {
  final String? type;

  final List<double> coordinates;

  final double? latitude;

  final double? longitude;

  final String? district;

  final String? city;

  final String? state;

  final String? country;

  final String? address;

  const DiscoveryLocation({
    this.type,

    required this.coordinates,

    this.latitude,

    this.longitude,

    this.district,

    this.city,

    this.state,

    this.country,

    this.address,
  });

  factory DiscoveryLocation.fromJson(Map<String, dynamic> json) {
    return DiscoveryLocation(
      type: json['type'],

      coordinates: (json['coordinates'] as List<dynamic>? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),

      latitude: (json['latitude'] as num?)?.toDouble(),

      longitude: (json['longitude'] as num?)?.toDouble(),

      district: json['district'],

      city: json['city'],

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

      "district": district,

      "city": city,

      "state": state,

      "country": country,

      "address": address,
    };
  }
}

/// DISCOVERY PREFERENCES MODEL

class DiscoveryPreferences {
  final String? lookingFor;

  final String? lookingForInput;

  final String? intent;

  final String? relationshipGoals;

  final List<String> interestedIn;

  final List<String> interestedInInput;

  final String? showMe;

  final List<String> genderPreference;

  final int? distancePreference;

  final int? maxDistance;

  final String? distanceText;

  final int? minAge;

  final int? maxAge;

  final List<int> ageRange;

  final String? ageRangeText;

  final bool? isVerified;

  final String? sortBy;

  final DateTime? updatedAt;

  const DiscoveryPreferences({
    this.lookingFor,

    this.lookingForInput,

    this.intent,

    this.relationshipGoals,

    required this.interestedIn,

    required this.interestedInInput,

    this.showMe,

    required this.genderPreference,

    this.distancePreference,

    this.maxDistance,

    this.distanceText,

    this.minAge,

    this.maxAge,

    required this.ageRange,

    this.ageRangeText,

    this.isVerified,

    this.sortBy,

    this.updatedAt,
  });

  factory DiscoveryPreferences.fromJson(Map<String, dynamic> json) {
    return DiscoveryPreferences(
      lookingFor: json['lookingFor'],

      lookingForInput: json['lookingForInput'],

      intent: json['intent'],

      relationshipGoals: json['relationshipGoals'],

      interestedIn: (json['interestedIn'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      interestedInInput: (json['interestedInInput'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      showMe: json['showMe'],

      genderPreference: (json['genderPreference'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),

      distancePreference: json['distancePreference'],

      maxDistance: json['maxDistance'],

      distanceText: json['distanceText'],

      minAge: json['minAge'],

      maxAge: json['maxAge'],

      ageRange: (json['ageRange'] as List<dynamic>? ?? [])
          .map((e) => int.tryParse(e.toString()) ?? 0)
          .toList(),

      ageRangeText: json['ageRangeText'],

      isVerified: json['isVerified'],

      sortBy: json['sortBy'],

      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lookingFor": lookingFor,

      "lookingForInput": lookingForInput,

      "intent": intent,

      "relationshipGoals": relationshipGoals,

      "interestedIn": interestedIn,

      "interestedInInput": interestedInInput,

      "showMe": showMe,

      "genderPreference": genderPreference,

      "distancePreference": distancePreference,

      "maxDistance": maxDistance,

      "distanceText": distanceText,

      "minAge": minAge,

      "maxAge": maxAge,

      "ageRange": ageRange,

      "ageRangeText": ageRangeText,

      "isVerified": isVerified,

      "sortBy": sortBy,

      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}
