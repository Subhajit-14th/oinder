class EditProfileData {
  String? name;
  String? birthDate;

  String? gender;

  List<String> sexualOrientation = [];
  List<String> interestedIn = [];

  String? relationshipGoals;

  int distancePreference = 80;

  String? college;

  String? educationLevel;
  String? communicationStyle;
  String? loveLanguage;

  LifestyleModel lifestyle = LifestyleModel();

  List<String> interests = [];

  String? bio;

  List<String> photos = [];

  EditProfileData();

  factory EditProfileData.fromJson(Map<String, dynamic> json) {
    return EditProfileData()
      ..name = json["name"]
      ..birthDate = json["birthDate"]
      ..gender = json["gender"]
      ..sexualOrientation = List<String>.from(json["sexualOrientation"] ?? [])
      ..interestedIn = List<String>.from(json["interestedIn"] ?? [])
      ..relationshipGoals = json["relationshipGoals"]
      ..distancePreference = json["distancePreference"] ?? 80
      ..college = json["college"]
      ..educationLevel = json["educationLevel"]
      ..communicationStyle = json["communicationStyle"]
      ..loveLanguage = json["loveLanguage"]
      ..lifestyle = LifestyleModel.fromJson(json["lifestyle"] ?? {})
      ..interests = List<String>.from(json["interests"] ?? [])
      ..bio = json["bio"]
      ..photos = List<String>.from(json["photos"] ?? []);
  }
}

class LifestyleModel {
  String? drinking;
  String? smoking;
  String? workout;

  List<String> pets = [];

  LifestyleModel();

  factory LifestyleModel.fromJson(Map<String, dynamic> json) {
    return LifestyleModel()
      ..drinking = json["drinking"]
      ..smoking = json["smoking"]
      ..workout = json["workout"]
      ..pets = List<String>.from(json["pets"] ?? []);
  }
}
