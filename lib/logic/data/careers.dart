import 'package:alpha/assets.dart';

enum Job {
  unemployed(
    title: "Unemployed",
    career: CareerSector.unemployed,
    salary: 0.0,
    levelRequirement: 0,
    tier: 0,
    asset: AlphaAssets.careerBankingAnalyst,
  ),

  // Food Delivery
  foodDelivery(
    title: "Delivery Rider",
    career: CareerSector.foodDelivery,
    salary: 3500.0,
    levelRequirement: 1,
    asset: AlphaAssets.careerFoodDelivery,
    tier: 0,
  ),

  // Marketing
  marketingAssistant(
    title: "Assistant",
    career: CareerSector.marketing,
    salary: 4500.0,
    levelRequirement: 2,
    asset: AlphaAssets.careerMarketingAssistant,
    tier: 0,
  ),

  marketingManager(
    title: "Manager",
    career: CareerSector.marketing,
    salary: 7200.0,
    levelRequirement: 2,
    asset: AlphaAssets.careerMarketingManager,
    tier: 1,
  ),

  // Culinary Chef
  culinaryChefAssistant(
    title: "Assistant Chef",
    career: CareerSector.culinaryChef,
    salary: 4100.0,
    levelRequirement: 2,
    asset: AlphaAssets.careerCulinaryChefAssistant,
    tier: 0,
  ),

  culinaryChefExecutive(
    title: "Executive Chef",
    career: CareerSector.culinaryChef,
    salary: 7400.0,
    levelRequirement: 4,
    asset: AlphaAssets.careerCulinaryExecutiveChef,
    tier: 1,
  ),

  // Banking
  bankingAssociate(
    title: "Associate",
    career: CareerSector.banking,
    salary: 5700.0,
    levelRequirement: 3,
    asset: AlphaAssets.careerBankingAssociate,
    tier: 0,
  ),

  bankingAnalyst(
    title: "Analyst",
    career: CareerSector.banking,
    salary: 6800.0,
    levelRequirement: 4,
    asset: AlphaAssets.careerBankingAnalyst,
    tier: 1,
  ),

  bankingManager(
      title: "Managing Director",
      career: CareerSector.banking,
      salary: 8400.0,
      levelRequirement: 6,
      asset: AlphaAssets.careerBankingManager,
      tier: 2),

  // Progammer
  programmerJunior(
      title: "Junior Programmer",
      career: CareerSector.programmer,
      salary: 5800.0,
      levelRequirement: 3,
      asset: AlphaAssets.careerProgrammerJunior,
      tier: 0),

  programmerSenior(
      title: "Senior Programmer",
      career: CareerSector.programmer,
      salary: 7600.0,
      levelRequirement: 5,
      asset: AlphaAssets.careerProgrammerSenior,
      tier: 1),

  programmerManager(
      title: "Project Manager",
      career: CareerSector.programmer,
      salary: 9900.0,
      levelRequirement: 7,
      asset: AlphaAssets.careerProgrammerManager,
      tier: 2),

  // Engineer
  engineerJunior(
      title: "Junior Engineer",
      career: CareerSector.engineer,
      salary: 6100.0,
      levelRequirement: 4,
      asset: AlphaAssets.careerEngineerJunior,
      tier: 0),

  engineerSenior(
      title: "Senior Engineer",
      career: CareerSector.engineer,
      salary: 7900.0,
      levelRequirement: 5,
      asset: AlphaAssets.careerEngineerSenior,
      tier: 1),

  engineerExecutive(
      title: "Executive",
      career: CareerSector.engineer,
      salary: 12000.0,
      levelRequirement: 7,
      asset: AlphaAssets.careerEngineerExecutive,
      tier: 2),

  // Medicine
  medicineHouseman(
      title: "Houseman",
      career: CareerSector.medicine,
      salary: 7800.0,
      levelRequirement: 6,
      asset: AlphaAssets.careerMedicineHouseman,
      tier: 0),

  medicineResident(
      title: "Resident",
      career: CareerSector.medicine,
      salary: 15000.0,
      levelRequirement: 8,
      asset: AlphaAssets.careerMedicineResident,
      tier: 1),

  medicineDoctor(
      title: "Doctor",
      career: CareerSector.medicine,
      salary: 19000,
      levelRequirement: 10,
      asset: AlphaAssets.careerMedicineDoctor,
      tier: 2),

  medicineSpecialist(
      title: "Specialist",
      career: CareerSector.medicine,
      salary: 25000,
      levelRequirement: 12,
      asset: AlphaAssets.careerMedicineSpecialist,
      tier: 3),

  medicineSurgeon(
      title: "Surgeon",
      career: CareerSector.medicine,
      salary: 20000.0,
      levelRequirement: 15,
      asset: AlphaAssets.careerMedicineSurgeon,
      tier: 4);

  const Job({
    required this.title,
    required this.career,
    required this.salary,
    required this.levelRequirement,
    required this.tier,
    required this.asset,
  });

  final String title;
  final double salary;
  final CareerSector career;
  final int levelRequirement;
  final int tier;
  final AlphaAssets asset;
}

enum CareerSector {
  unemployed(
    title: "Unemployed",
    description: "You are currently unemployed. Find a job to start earning.",
  ),

  foodDelivery(
    title: "Food Delivery",
    description:
        "Deliver food to customers in a timely and efficient manner. Ensure customer satisfaction and handle payments.",
  ),

  marketing(
    title: "Marketing",
    description:
        "Develop and implement marketing strategies to promote products and services. Analyze market trends and customer behavior.",
  ),

  culinaryChef(
    title: "Culinary Chef",
    description:
        "Prepare and cook a variety of dishes. Maintain high standards of food quality and hygiene in the kitchen.",
  ),

  banking(
    title: "Banking",
    description:
        "Provide financial services to customers, including account management, loans, and investment advice. Ensure compliance with banking regulations.",
  ),

  programmer(
    title: "Progammer",
    description:
        "Design, develop, and maintain software applications. Write clean and efficient code, and troubleshoot and debug issues.",
  ),

  engineer(
    title: "Engineer",
    description:
        "Design, develop, and test engineering solutions. Work on projects related to construction, manufacturing, or technology.",
  ),

  medicine(
    title: "Medicine",
    description:
        "Provide medical care to patients. Diagnose and treat illnesses, and perform medical procedures and surgeries.",
  );

  const CareerSector({required this.title, required this.description});

  final String title;
  final String description;
}
