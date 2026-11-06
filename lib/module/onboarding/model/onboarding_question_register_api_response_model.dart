class CompleteProfileResponseModel {
  final bool success;
  final String message;
  final String email;
  final bool isVerified;
  final bool isEmailVerified;
  final bool isProfileComplete;
  final String token;
  final UserModel user;

  const CompleteProfileResponseModel({
    required this.success,
    required this.message,
    required this.email,
    required this.isVerified,
    required this.isEmailVerified,
    required this.isProfileComplete,
    required this.token,
    required this.user,
  });

  factory CompleteProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return CompleteProfileResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      email: json["email"] ?? "",
      isVerified: json["isVerified"] ?? false,
      isEmailVerified: json["isEmailVerified"] ?? false,
      isProfileComplete: json["isProfileComplete"] ?? false,
      token: json["token"] ?? "",
      user: UserModel.fromJson(json["user"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "email": email,
      "isVerified": isVerified,
      "isEmailVerified": isEmailVerified,
      "isProfileComplete": isProfileComplete,
      "token": token,
      "user": user.toJson(),
    };
  }
}

class UserModel {
  final String id;
  final String mongoId;
  final String name;
  final String firstName;
  final String lastName;
  final String displayName;
  final String email;
  final DateTime? birthDate;
  final int age;
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
  final LifestyleModel lifestyle;
  final List<dynamic> prompts;
  final String bio;
  final List<String> interests;
  final String profilePhoto;
  final String photo;
  final List<String> photos;
  final LocationModel location;
  final String city;
  final String state;
  final String country;
  final String address;
  final bool isProfileComplete;
  final String onboardingStep;
  final Map<String, dynamic> onboardingAnswers;
  final String authProvider;
  final bool isVerified;
  final bool isEmailVerified;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.mongoId,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.email,
    required this.birthDate,
    required this.age,
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
    required this.lifestyle,
    required this.prompts,
    required this.bio,
    required this.interests,
    required this.profilePhoto,
    required this.photo,
    required this.photos,
    required this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
    required this.isProfileComplete,
    required this.onboardingStep,
    required this.onboardingAnswers,
    required this.authProvider,
    required this.isVerified,
    required this.isEmailVerified,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      mongoId: json["_id"] ?? "",
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      displayName: json["displayName"] ?? "",
      email: json["email"] ?? "",
      birthDate: json["birthDate"] != null
          ? DateTime.tryParse(json["birthDate"])
          : null,
      age: json["age"] ?? 0,
      gender: json["gender"] ?? "",
      showGenderOnProfile: json["showGenderOnProfile"] ?? false,
      sexualOrientation: (json["sexualOrientation"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      showOrientationOnProfile: json["showOrientationOnProfile"] ?? false,
      interestedIn: (json["interestedIn"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      relationshipGoals: json["relationshipGoals"] ?? "",
      distancePreference: json["distancePreference"] ?? 0,
      college: json["college"] ?? "",
      educationLevel: json["educationLevel"] ?? "",
      communicationStyle: json["communicationStyle"] ?? "",
      loveLanguage: json["loveLanguage"] ?? "",
      lifestyle: LifestyleModel.fromJson(json["lifestyle"] ?? {}),
      prompts: List<dynamic>.from(json["prompts"] ?? []),
      bio: json["bio"] ?? "",
      interests: (json["interests"] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      profilePhoto: json["profilePhoto"] ?? "",
      photo: json["photo"] ?? "",
      photos: (json["photos"] as List? ?? []).map((e) => e.toString()).toList(),
      location: LocationModel.fromJson(json["location"] ?? {}),
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      address: json["address"] ?? "",
      isProfileComplete: json["isProfileComplete"] ?? false,
      onboardingStep: json["onboardingStep"] ?? "",
      onboardingAnswers: Map<String, dynamic>.from(
        json["onboardingAnswers"] ?? {},
      ),
      authProvider: json["authProvider"] ?? "",
      isVerified: json["isVerified"] ?? false,
      isEmailVerified: json["isEmailVerified"] ?? false,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": mongoId,
      "id": id,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "displayName": displayName,
      "email": email,
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
      "lifestyle": lifestyle.toJson(),
      "prompts": prompts,
      "bio": bio,
      "interests": interests,
      "profilePhoto": profilePhoto,
      "photo": photo,
      "photos": photos,
      "location": location.toJson(),
      "city": city,
      "state": state,
      "country": country,
      "address": address,
      "isProfileComplete": isProfileComplete,
      "onboardingStep": onboardingStep,
      "onboardingAnswers": onboardingAnswers,
      "authProvider": authProvider,
      "isVerified": isVerified,
      "isEmailVerified": isEmailVerified,
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}

class LifestyleModel {
  final String drinking;
  final String smoking;
  final String workout;
  final List<String> pets;

  const LifestyleModel({
    required this.drinking,
    required this.smoking,
    required this.workout,
    required this.pets,
  });

  factory LifestyleModel.fromJson(Map<String, dynamic> json) {
    return LifestyleModel(
      drinking: json["drinking"] ?? "",
      smoking: json["smoking"] ?? "",
      workout: json["workout"] ?? "",
      pets: (json["pets"] as List? ?? []).map((e) => e.toString()).toList(),
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
  final String type;
  final List<double> coordinates;
  final double latitude;
  final double longitude;
  final String city;
  final String state;
  final String country;
  final String address;

  const LocationModel({
    required this.type,
    required this.coordinates,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json["type"] ?? "",
      coordinates: (json["coordinates"] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
      latitude: (json["latitude"] ?? 0).toDouble(),
      longitude: (json["longitude"] ?? 0).toDouble(),
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      address: json["address"] ?? "",
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
