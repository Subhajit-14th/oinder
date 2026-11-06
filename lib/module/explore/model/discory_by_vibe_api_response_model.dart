class LookingForOptionsResponse {
  final bool success;
  final TrendingOption? trendingOption;
  final List<LookingForOption> options;

  const LookingForOptionsResponse({
    required this.success,
    this.trendingOption,
    required this.options,
  });

  factory LookingForOptionsResponse.fromJson(Map<String, dynamic> json) {
    return LookingForOptionsResponse(
      success: json["success"] as bool? ?? false,
      trendingOption: json["trendingOption"] != null
          ? TrendingOption.fromJson(
              json["trendingOption"] as Map<String, dynamic>,
            )
          : null,
      options:
          (json["options"] as List<dynamic>?)
              ?.map((e) => LookingForOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "trendingOption": trendingOption?.toJson(),
      "options": options.map((e) => e.toJson()).toList(),
    };
  }
}

class TrendingOption {
  final String id;
  final String label;
  final String mongoId;

  const TrendingOption({
    required this.id,
    required this.label,
    required this.mongoId,
  });

  factory TrendingOption.fromJson(Map<String, dynamic> json) {
    return TrendingOption(
      id: json["id"] as String? ?? "",
      label: json["label"] as String? ?? "",
      mongoId: json["_id"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "label": label, "_id": mongoId};
  }
}

class LookingForOption {
  final String id;
  final String label;
  final String mongoId;
  final bool isTrending;

  const LookingForOption({
    required this.id,
    required this.label,
    required this.mongoId,
    required this.isTrending,
  });

  factory LookingForOption.fromJson(Map<String, dynamic> json) {
    return LookingForOption(
      id: json["id"] as String? ?? "",
      label: json["label"] as String? ?? "",
      mongoId: json["_id"] as String? ?? "",
      isTrending: json["isTrending"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "label": label, "_id": mongoId, "isTrending": isTrending};
  }
}
