class SubscriptionResponseModel {
  final bool success;
  final SubscriptionUserModel? user;
  final CurrentSubscriptionModel? currentSubscription;
  final List<SubscriptionTierModel> tiers;
  final List<RecentTransactionModel> recentTransactions;

  const SubscriptionResponseModel({
    required this.success,
    this.user,
    this.currentSubscription,
    required this.tiers,
    required this.recentTransactions,
  });

  factory SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponseModel(
      success: json["success"] ?? false,
      user: json["user"] != null
          ? SubscriptionUserModel.fromJson(json["user"])
          : null,
      currentSubscription: json["currentSubscription"] != null
          ? CurrentSubscriptionModel.fromJson(json["currentSubscription"])
          : null,
      tiers:
          (json["tiers"] as List<dynamic>?)
              ?.map((e) => SubscriptionTierModel.fromJson(e))
              .toList() ??
          [],
      recentTransactions:
          (json["recentTransactions"] as List<dynamic>?)
              ?.map((e) => RecentTransactionModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "user": user?.toJson(),
      "currentSubscription": currentSubscription?.toJson(),
      "tiers": tiers.map((e) => e.toJson()).toList(),
      "recentTransactions": recentTransactions.map((e) => e.toJson()).toList(),
    };
  }
}

class SubscriptionUserModel {
  final String id;
  final String? name;
  final String? email;
  final String? photo;
  final int? age;
  final String? gender;
  final bool isVerified;

  const SubscriptionUserModel({
    required this.id,
    this.name,
    this.email,
    this.photo,
    this.age,
    this.gender,
    required this.isVerified,
  });

  factory SubscriptionUserModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionUserModel(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString(),
      email: json["email"]?.toString(),
      photo: json["photo"]?.toString(),
      age: json["age"] is int
          ? json["age"]
          : int.tryParse(json["age"]?.toString() ?? ""),
      gender: json["gender"]?.toString(),
      isVerified: json["isVerified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photo": photo,
      "age": age,
      "gender": gender,
      "isVerified": isVerified,
    };
  }
}

class CurrentSubscriptionModel {
  final String? plan;
  final bool isPaid;
  final String? status;
  final String? billingCycle;
  final String? amount;
  final String? startDate;
  final String? renewalDate;
  final String? renewalDateFormatted;
  final String? paymentMethod;
  final SubscriptionBenefitsModel? benefits;

  const CurrentSubscriptionModel({
    this.plan,
    required this.isPaid,
    this.status,
    this.billingCycle,
    this.amount,
    this.startDate,
    this.renewalDate,
    this.renewalDateFormatted,
    this.paymentMethod,
    this.benefits,
  });

  factory CurrentSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return CurrentSubscriptionModel(
      plan: json["plan"]?.toString(),
      isPaid: json["isPaid"] ?? false,
      status: json["status"]?.toString(),
      billingCycle: json["billingCycle"]?.toString(),
      amount: json["amount"]?.toString(),
      startDate: json["startDate"]?.toString(),
      renewalDate: json["renewalDate"]?.toString(),
      renewalDateFormatted: json["renewalDateFormatted"]?.toString(),
      paymentMethod: json["paymentMethod"]?.toString(),
      benefits: json["benefits"] != null
          ? SubscriptionBenefitsModel.fromJson(json["benefits"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "plan": plan,
      "isPaid": isPaid,
      "status": status,
      "billingCycle": billingCycle,
      "amount": amount,
      "startDate": startDate,
      "renewalDate": renewalDate,
      "renewalDateFormatted": renewalDateFormatted,
      "paymentMethod": paymentMethod,
      "benefits": benefits?.toJson(),
    };
  }
}

class SubscriptionBenefitsModel {
  final bool unlimitedLikes;
  final bool seeWhoLikesYou;
  final bool rewindLastSwipe;
  final bool passportMode;
  final bool hideAds;
  final bool priorityLikes;
  final bool vipBadge;
  final int superLikesDaily;
  final int boostsMonthly;

  const SubscriptionBenefitsModel({
    required this.unlimitedLikes,
    required this.seeWhoLikesYou,
    required this.rewindLastSwipe,
    required this.passportMode,
    required this.hideAds,
    required this.priorityLikes,
    required this.vipBadge,
    required this.superLikesDaily,
    required this.boostsMonthly,
  });

  factory SubscriptionBenefitsModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionBenefitsModel(
      unlimitedLikes: json["unlimitedLikes"] ?? false,
      seeWhoLikesYou: json["seeWhoLikesYou"] ?? false,
      rewindLastSwipe: json["rewindLastSwipe"] ?? false,
      passportMode: json["passportMode"] ?? false,
      hideAds: json["hideAds"] ?? false,
      priorityLikes: json["priorityLikes"] ?? false,
      vipBadge: json["vipBadge"] ?? false,
      superLikesDaily:
          int.tryParse(json["superLikesDaily"]?.toString() ?? "") ?? 0,
      boostsMonthly: int.tryParse(json["boostsMonthly"]?.toString() ?? "") ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "unlimitedLikes": unlimitedLikes,
      "seeWhoLikesYou": seeWhoLikesYou,
      "rewindLastSwipe": rewindLastSwipe,
      "passportMode": passportMode,
      "hideAds": hideAds,
      "priorityLikes": priorityLikes,
      "vipBadge": vipBadge,
      "superLikesDaily": superLikesDaily,
      "boostsMonthly": boostsMonthly,
    };
  }
}

class SubscriptionTierModel {
  final String id;
  final String? name;
  final String? price;
  final double numericPrice;
  final String? billingPeriod;
  final bool popular;
  final String? color;
  final String? badgeColor;
  final String? textColor;
  final List<String> features;
  final bool isCurrentPlan;

  const SubscriptionTierModel({
    required this.id,
    this.name,
    this.price,
    required this.numericPrice,
    this.billingPeriod,
    required this.popular,
    this.color,
    this.badgeColor,
    this.textColor,
    required this.features,
    required this.isCurrentPlan,
  });

  factory SubscriptionTierModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionTierModel(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString(),
      price: json["price"]?.toString(),
      numericPrice:
          (json["numericPrice"] as num?)?.toDouble() ??
          double.tryParse(json["numericPrice"]?.toString() ?? "") ??
          0.0,
      billingPeriod: json["billingPeriod"]?.toString(),
      popular: json["popular"] ?? false,
      color: json["color"]?.toString(),
      badgeColor: json["badgeColor"]?.toString(),
      textColor: json["textColor"]?.toString(),
      features:
          (json["features"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isCurrentPlan: json["isCurrentPlan"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "numericPrice": numericPrice,
      "billingPeriod": billingPeriod,
      "popular": popular,
      "color": color,
      "badgeColor": badgeColor,
      "textColor": textColor,
      "features": features,
      "isCurrentPlan": isCurrentPlan,
    };
  }
}

class RecentTransactionModel {
  const RecentTransactionModel();

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    return const RecentTransactionModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
