class HomeProfileModel {
  final String id;
  final String name;
  final int age;
  final String profession;
  final String distance;
  final String bio;
  final String image;
  final int match;
  final bool isVerified;
  final bool isLike;

  const HomeProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.profession,
    required this.distance,
    required this.bio,
    required this.image,
    required this.match,
    this.isVerified = false,
    this.isLike = false,
  });

  HomeProfileModel copyWith({
    String? id,
    String? name,
    int? age,
    String? profession,
    String? distance,
    String? bio,
    String? image,
    int? match,
    bool? isVerified,
    bool? isLike,
  }) {
    return HomeProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      profession: profession ?? this.profession,
      distance: distance ?? this.distance,
      bio: bio ?? this.bio,
      image: image ?? this.image,
      match: match ?? this.match,
      isVerified: isVerified ?? this.isVerified,
      isLike: isLike ?? this.isLike,
    );
  }
}
