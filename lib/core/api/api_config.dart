class ApiContants {
  ApiContants._();

  static const String baseUrl = "https://api.oinder.in/api/";

  // =============== Login APIS =============
  static const String authEmailSendOtp = "auth/email/send-otp";
  static const String authEmailVerifyEmail = "auth/email/verify-email";
  static const String googleAuthLogin = "googleLogin";

  // =============== Likes APIS =============
  static const String getLikes = "liked_users";

  // =============== Profile APIS =============
  static const String getProfile = "users/me";
  static const String updateProfilePhoto = "updateprofileimage";

  // =============== Profile Utils APIS =============
  static const String getBlockedUsers = "blockuser";
  static const String postBlockedUsers = "blockuser";
  static const String hideMyProfile = "hidemyprofile";

  // ================== Onboarding APIS =================
  static const String getOnboardingQuestions = "auth/onboarding/questions";
  static const String postOnboardingQuestionsAnswer = "auth/register";
  static const String getLookingForYouQuestions = "question/lookingFor";

  // ================== Upload Image To Servers ====================
  static const String uploadImageToServer = "upload";

  // ================== Get Discover By Vibe List ====================
  static const String getDiscoverByVibeList = "discoverbyvivelist";

  // ================== Update Location To Servers ====================
  static const String updateLocationToServer = "update_location";

  // ================== Get Users Profile ====================
  static const String getUsersProfile = "users";
  static const String getUsersProfileUpdate = "update_profile";
  static const String getUsersMatchProfile = "users/like";
  static const String getUsersSuperLike = "superlike";
  static const String getMyPhotos = "user_wise_photo_upload";
  static const String deletePhoto = "user_wise_photo_upload/delete";
  static const String uploadMyPhotos = "user_wise_photo_upload";

  // ================== Get Users Profile ====================
  static const String deleteAccount = "delete_account";

  // ================== Get Subscription Details====================
  static const String getSubscriptionDetails = "subscriptions";

  // ================== Get Users Profile Details====================
  static const String getUsersProfileDetails = "profile_details_by_id";

  // ================== Get Preferences====================
  static const String postPreferencesAnswers = "discovery_prefrences_filter";
  static const String getPreferencesAnswers = "discovery_prefrences_filter";

  // =================== Get Chat Token =====================
  static const String getChatToken = "chat/token";
  static const String sendMessage = "chat/send-message";
  static const String chatMatchesAndMessages = "chat/matches-and-messages";
  static const String chatDetails = "chat/thread";
}
