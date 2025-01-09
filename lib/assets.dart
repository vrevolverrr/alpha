class ImagePaths {
  static const String root = "assets/images";
}

enum AlphaAssets {
  // Logos
  logoCashflow(path: "${ImagePaths.root}/logo/cashflow.png"),
  logoNcf(path: "${ImagePaths.root}/logo/ncf.png"),

  // Avatars
  avatarBrownHair(path: "${ImagePaths.root}/avatars/avatar1.png"),
  avatarBlackGuy(path: "${ImagePaths.root}/avatars/avatar2.png"),
  avatarPinkHair(path: "${ImagePaths.root}/avatars/avatar3.png"),
  avatarGreenBuns(path: "${ImagePaths.root}/avatars/avatar4.png"),
  avatarOrangePonytail(path: "${ImagePaths.root}/avatars/avatar5.png"),

  // Budgeting
  budgetingJar0(path: "${ImagePaths.root}/budgeting/0.png"),
  budgetingJar25(path: "${ImagePaths.root}/budgeting/25.png"),
  budgetingJar50(path: "${ImagePaths.root}/budgeting/50.png"),
  budgetingJar100(path: "${ImagePaths.root}/budgeting/100.png"),

  // Dashboard Icons
  dashboardBusiness(path: "${ImagePaths.root}/dashboard/business.png"),
  dashboardInvestment(path: "${ImagePaths.root}/dashboard/investments.png"),
  dashboardAssets(path: "${ImagePaths.root}/dashboard/assets.png"),

  // Business Sectors
  businessFoodAndBeverages(path: "${ImagePaths.root}/business_fnb.png"),
  businessPharmaceutical(path: "${ImagePaths.root}/business_pharma.png"),
  businessEcommerce(path: "${ImagePaths.root}/business_ecommerce.png"),
  businessSocialMediaInfluencer(
      path: "${ImagePaths.root}/business_social_media.png"),
  businessTechnology(path: "${ImagePaths.root}/business_technology.png"),

  // Career
  careerFoodDelivery(path: "${ImagePaths.root}/career/food_delivery.png"),

  careerCulinaryChefAssistant(
      path: "${ImagePaths.root}/career/culinary_chef_assistant.png"),
  careerCulinaryExecutiveChef(
      path: "${ImagePaths.root}/career/culinary_executive_chef.png"),

  careerMarketingAssistant(
      path: "${ImagePaths.root}/career/marketing_assistant.png"),
  careerMarketingManager(
      path: "${ImagePaths.root}/career/marketing_manager.png"),

  careerBankingAnalyst(path: "${ImagePaths.root}/career/banking_analyst.png"),
  careerBankingAssociate(
      path: "${ImagePaths.root}/career/banking_associate.png"),
  careerBankingManager(path: "${ImagePaths.root}/career/banking_manager.png"),

  careerMedicineResident(
      path: "${ImagePaths.root}/career/mediciine_resident.png"),
  careerMedicineDoctor(path: "${ImagePaths.root}/career/medicine_doctor.png"),
  careerMedicineHouseman(
      path: "${ImagePaths.root}/career/medicine_houseman.png"),
  careerMedicineSpecialist(
      path: "${ImagePaths.root}/career/medicine_specialist.png"),
  careerMedicineSurgeon(path: "${ImagePaths.root}/career/medicine_surgeon.png"),

  // Opportunity Icons
  opportunityQuestionMark(path: "${ImagePaths.root}/question_mark_icon.png"),
  opportunityMoneyBag(path: "${ImagePaths.root}/opportunity_money_bag.png"),
  opportunityCdcVoucher(path: "${ImagePaths.root}/opportunity_cdc_voucher.png"),
  opportunityQuiz(path: "${ImagePaths.root}/opportunity_quiz.png"),
  opportunityFined(path: "${ImagePaths.root}/opportunity_fined.png"),

  // Jobs Hero Images
  jobProgrammer(path: "${ImagePaths.root}/job_programmer.png"),

  jobAssistantChef(path: "${ImagePaths.root}/job_assistant_chef.png"),
  jobExecutiveChef(path: "${ImagePaths.root}/job_executive_chef.png"),

  jobHouseman(path: "${ImagePaths.root}/job_houseman.png"),
  jobResident(path: "${ImagePaths.root}/job_resident.png"),
  jobDoctor(path: "${ImagePaths.root}/job_doctor.png"),

  // Real Estate
  realEstateHdb(path: "${ImagePaths.root}/real_estate/hdb.png"),
  realEstateCondo(path: "${ImagePaths.root}/real_estate/condo.png"),
  realEstateBungalow(path: "${ImagePaths.root}/real_estate/bungalow.png"),

  // Car
  carPetrol(path: "${ImagePaths.root}/car/petrol.png"),
  carElectric(path: "${ImagePaths.root}/car/electric.png"),
  carHybrid(path: "${ImagePaths.root}/car/hybrid.png"),

  // Personal Life
  personalLifeSingle(path: "${ImagePaths.root}/personal_life/single.png"),
  personalLifeDating(path: "${ImagePaths.root}/personal_life/dating.png"),
  personalLifeMarried(path: "${ImagePaths.root}/personal_life/married.png"),
  personalLifeFamily(path: "${ImagePaths.root}/personal_life/married.png"),
  ;

  const AlphaAssets({required this.path});

  final String path;
}
