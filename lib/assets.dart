class ImagePaths {
  static const String root = "assets/images";
}

enum AlphaAssets {
  bgLandingCities(path: "${ImagePaths.root}/bg_landing_cities.png"),
  playerDefault(path: "${ImagePaths.root}/player_default.png"),

  // Dashboard Icons
  dashboardBusiness(path: "${ImagePaths.root}/dashboard_business.png"),

  // Business Sectors
  businessFoodAndBeverages(path: "${ImagePaths.root}/business_fnb.png"),
  businessPharmaceutical(path: "${ImagePaths.root}/business_pharma.png"),
  businessEcommerce(path: "${ImagePaths.root}/business_ecommerce.png"),
  businessSocialMediaInfluencer(
      path: "${ImagePaths.root}/business_social_media.png"),
  businessTechnology(path: "${ImagePaths.root}/business_technology.png"),

  // Career Icons
  careerFoodDelivery(path: "${ImagePaths.root}/career_food_delivery.png"),
  careerMarketing(path: "${ImagePaths.root}/career_marketing.png"),
  careerCulinaryChef(path: "${ImagePaths.root}/career_culinary_chef.png"),
  careerBanking(path: "${ImagePaths.root}/career_banking.png"),
  careerProgrammer(path: "${ImagePaths.root}/career_programmer.png"),
  careerEngineer(path: "${ImagePaths.root}/career_engineer.png"),
  careerMedicine(path: "${ImagePaths.root}/career_medicine.png"),

  // Opportunity Icons
  opportunityQuestionMark(path: "${ImagePaths.root}/question_mark_icon.png"),
  opportunityMoneyBag(path: "${ImagePaths.root}/opportunity_money_bag.png"),
  opportunityCdcVoucher(path: "${ImagePaths.root}/opportunity_cdc_voucher.png"),
  opportunityQuiz(path: "${ImagePaths.root}/opportunity_quiz.png"),
  opportunityFined(path: "${ImagePaths.root}/opportunity_fined.png"),

  // Jobs Hero Images
  jobProgrammer(path: "${ImagePaths.root}/job_programmer.png");

  const AlphaAssets({required this.path});

  final String path;
}
