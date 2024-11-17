class ImagePaths {
  static const String root = "assets/images";
}

enum AlphaAssets {
  bgLandingCities(path: "${ImagePaths.root}/bg_landing_cities.png"),
  playerDefault(path: "${ImagePaths.root}/player_default.png"),

  // Dashboard Icons
  dashboardBusiness(path: "${ImagePaths.root}/dashboard_business.png"),
  dashboardInvestment(path: "${ImagePaths.root}/dashboard_investments.png"),
  dashboardAssets(path: "${ImagePaths.root}/dashboard_assets.png"),

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

  // Jobs Hero Images
  jobProgrammer(path: "${ImagePaths.root}/job_programmer.png"),

  jobAssistantChef(path: "${ImagePaths.root}/job_assistant_chef.png"),
  jobExecutiveChef(path: "${ImagePaths.root}/job_executive_chef.png"),

  jobHouseman(path: "${ImagePaths.root}/job_houseman.png"),
  jobResident(path: "${ImagePaths.root}/job_resident.png"),
  jobDoctor(path: "${ImagePaths.root}/job_doctor.png"),
  ;

  const AlphaAssets({required this.path});

  final String path;
}
