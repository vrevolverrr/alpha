import 'package:alpha/assets.dart';

enum Job {
  unemployed(
    title: "Unemployed",
    career: CareerSector.unemployed,
    salary: 0.0,
    skillRequirement: 0,
    timeConsumed: 0,
    tier: 0,
  ),

  // Food Delivery
  foodDelivery(
    title: "Delivery Rider",
    career: CareerSector.foodDelivery,
    salary: 2000.0,
    skillRequirement: 0,
    timeConsumed: 100,
    asset: AlphaAssets.careerFoodDelivery,
    tier: 0,
  ),

  // Marketing
  marketingAssistant(
    title: "Marketing Assistant",
    career: CareerSector.marketing,
    salary: 3000.0,
    skillRequirement: 1000,
    timeConsumed: 120,
    asset: AlphaAssets.careerMarketingAssistant,
    tier: 0,
  ),

  marketingManager(
    title: "Marketing Manager",
    career: CareerSector.marketing,
    salary: 5000.0,
    skillRequirement: 2000,
    timeConsumed: 150,
    asset: AlphaAssets.careerMarketingManager,
    tier: 1,
  ),

  // Culinary Chef
  culinaryChefAssistant(
    title: "Assistant Chef",
    career: CareerSector.culinaryChef,
    salary: 3500.0,
    skillRequirement: 1000,
    timeConsumed: 120,
    asset: AlphaAssets.careerCulinaryChefAssistant,
    tier: 0,
  ),

  culinaryChefExecutive(
    title: "Executive Chef",
    career: CareerSector.culinaryChef,
    salary: 5000.0,
    skillRequirement: 2000,
    timeConsumed: 150,
    asset: AlphaAssets.careerCulinaryExecutiveChef,
    tier: 1,
  ),

  // Banking
  bankingAssociate(
    title: "Associate",
    career: CareerSector.banking,
    salary: 4000.0,
    skillRequirement: 1000,
    timeConsumed: 120,
    asset: AlphaAssets.careerBankingAssociate,
    tier: 0,
  ),

  bankingAnalyst(
    title: "Analyst",
    career: CareerSector.banking,
    salary: 6000.0,
    skillRequirement: 2000,
    timeConsumed: 150,
    asset: AlphaAssets.careerBankingAnalyst,
    tier: 1,
  ),

  bankingManager(
      title: "Managing Director",
      career: CareerSector.banking,
      salary: 8000.0,
      skillRequirement: 3000,
      timeConsumed: 180,
      asset: AlphaAssets.careerBankingManager,
      tier: 2),

  // Progammer
  programmerJunior(
      title: "Junior Programmer",
      career: CareerSector.programmer,
      salary: 3000.0,
      skillRequirement: 1000,
      timeConsumed: 120,
      tier: 0),

  programmerSenior(
      title: "Senior Programmer",
      career: CareerSector.programmer,
      salary: 4500.0,
      skillRequirement: 1000,
      timeConsumed: 140,
      tier: 1),

  programmerManager(
      title: "Project Manager",
      career: CareerSector.programmer,
      salary: 6000.0,
      skillRequirement: 2000,
      timeConsumed: 150,
      tier: 2),

  // Engineer
  engineerJunior(
      title: "Junior Engineer",
      career: CareerSector.engineer,
      salary: 3500.0,
      skillRequirement: 1000,
      timeConsumed: 120,
      tier: 0),

  engineerSenior(
      title: "Senior Engineer",
      career: CareerSector.engineer,
      salary: 5000.0,
      skillRequirement: 1000,
      timeConsumed: 140,
      tier: 1),

  engineerExecutive(
      title: "Executive Engineer",
      career: CareerSector.engineer,
      salary: 7000.0,
      skillRequirement: 2000,
      timeConsumed: 150,
      tier: 2),

  // Medicine
  medicineHouseman(
      title: "Houseman",
      career: CareerSector.medicine,
      salary: 3000.0,
      skillRequirement: 2000,
      timeConsumed: 120,
      asset: AlphaAssets.jobHouseman,
      tier: 0),

  medicineResident(
      title: "Resident",
      career: CareerSector.medicine,
      salary: 5000.0,
      skillRequirement: 2000,
      asset: AlphaAssets.jobResident,
      timeConsumed: 140,
      tier: 1),

  medicineDoctor(
      title: "Doctor",
      career: CareerSector.medicine,
      salary: 8000.0,
      skillRequirement: 3000,
      timeConsumed: 160,
      asset: AlphaAssets.jobDoctor,
      tier: 2),

  medicineSpecialist(
      title: "Specialist",
      career: CareerSector.medicine,
      salary: 12000.0,
      skillRequirement: 3000,
      timeConsumed: 180,
      tier: 3),

  medicineSurgeon(
      title: "Surgeon",
      career: CareerSector.medicine,
      salary: 20000.0,
      skillRequirement: 3000,
      timeConsumed: 200,
      tier: 4);

  const Job({
    required this.title,
    required this.career,
    required this.salary,
    required this.skillRequirement,
    required this.timeConsumed,
    required this.tier,
    this.asset = AlphaAssets.jobProgrammer,
  });

  final String title;
  final double salary;
  final CareerSector career;
  final int skillRequirement;
  final int timeConsumed;
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
