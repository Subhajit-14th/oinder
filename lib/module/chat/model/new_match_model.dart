class NewMatchModel {
  final String name;
  final String image;
  final bool verified;
  final bool online;

  const NewMatchModel({
    required this.name,
    required this.image,
    this.verified = false,
    this.online = false,
  });
}
