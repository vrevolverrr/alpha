import 'package:alpha/assets.dart';
import 'package:alpha/logic/data/education.dart';

enum Job {
  surgeon(
      jobTitle: "Surgeon",
      jobSalary: 12000.0,
      education: Education.phd,
      timeConsumed: 240,
      hasProgression: true,
      tier: 0,
      nextJob: surgeonChief),

  surgeonChief(
      jobTitle: "Chief Surgeon",
      jobSalary: 20000.0,
      education: Education.phd,
      timeConsumed: 350,
      hasProgression: false,
      tier: 1),

  doctor(
      jobTitle: "Doctor",
      jobSalary: 8000.0,
      education: Education.masters,
      timeConsumed: 200,
      hasProgression: true,
      tier: 0,
      nextJob: doctorSpecialist),

  doctorSpecialist(
      jobTitle: "Specialist",
      jobSalary: 15000.0,
      education: Education.phd,
      timeConsumed: 200,
      hasProgression: true,
      tier: 1),

  engineer(
      jobTitle: "Engineer",
      jobSalary: 4500.0,
      education: Education.bachelors,
      timeConsumed: 140,
      hasProgression: true,
      tier: 0,
      nextJob: engineerSenior),

  engineerSenior(
      jobTitle: "Senior Engineer",
      jobSalary: 5700.0,
      education: Education.bachelors,
      timeConsumed: 160,
      hasProgression: true,
      tier: 1,
      nextJob: engineerLead),

  engineerLead(
      jobTitle: "Lead Engineer",
      jobSalary: 7400.0,
      education: Education.masters,
      timeConsumed: 165,
      hasProgression: false,
      tier: 2),

  programmer(
      jobTitle: "Programmer",
      jobSalary: 4300.0,
      education: Education.bachelors,
      timeConsumed: 135,
      hasProgression: true,
      tier: 0,
      asset: AlphaAssets.jobProgrammer,
      assetBW: AlphaAssets.jobProgrammerBW,
      nextJob: programmerSenior),

  programmerSenior(
      jobTitle: "Senior Programmer",
      jobSalary: 5400.0,
      education: Education.bachelors,
      timeConsumed: 140,
      hasProgression: true,
      tier: 1,
      nextJob: programmerLead),

  programmerLead(
      jobTitle: "Lead Programmer",
      jobSalary: 7000.0,
      education: Education.bachelors,
      timeConsumed: 150,
      hasProgression: false,
      tier: 2),

  electrician(
      jobTitle: "Electrician",
      jobSalary: 4200.0,
      education: Education.bachelors,
      timeConsumed: 130,
      hasProgression: false,
      tier: 0),

  mechanic(
      jobTitle: "Mechanic",
      jobSalary: 4100.0,
      education: Education.diploma,
      timeConsumed: 140,
      hasProgression: false,
      tier: 0),

  pumbler(
      jobTitle: "Pumbler",
      jobSalary: 3900.0,
      education: Education.diploma,
      timeConsumed: 130,
      hasProgression: false,
      tier: 0),

  waiter(
      jobTitle: "Waiter",
      jobSalary: 2500.0,
      education: Education.uneducated,
      timeConsumed: 100,
      hasProgression: false,
      tier: 0),

  unemployed(
      jobTitle: "Unemployed",
      jobSalary: 0.0,
      education: Education.uneducated,
      timeConsumed: 0,
      hasProgression: false,
      tier: -1);

  const Job(
      {required this.jobTitle,
      required this.jobSalary,
      required this.education,
      required this.timeConsumed,
      required this.hasProgression,
      required this.tier,
      this.asset = AlphaAssets.jobProgrammer,
      this.assetBW = AlphaAssets.jobProgrammerBW,
      this.nextJob});

  final String jobTitle;
  final double jobSalary;
  final Education education;
  final int timeConsumed;
  final bool hasProgression;
  final int tier;
  final AlphaAssets asset;
  final AlphaAssets assetBW;
  final Job? nextJob;
}
