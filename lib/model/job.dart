import 'package:alpha/model/education.dart';

enum Job {
  surgeon(
      jobTitle: "Surgeon",
      jobSalary: 12000.0,
      education: Education.phd,
      timeConsumed: 240),

  doctor(
      jobTitle: "Doctor",
      jobSalary: 8000.0,
      education: Education.masters,
      timeConsumed: 200),

  engineer(
      jobTitle: "Engineer",
      jobSalary: 4500.0,
      education: Education.bachelors,
      timeConsumed: 140),

  programmer(
      jobTitle: "Programmer",
      jobSalary: 4300.0,
      education: Education.bachelors,
      timeConsumed: 135),

  electrician(
      jobTitle: "Electrician",
      jobSalary: 4200.0,
      education: Education.bachelors,
      timeConsumed: 130),

  mechanic(
      jobTitle: "Mechanic",
      jobSalary: 4100.0,
      education: Education.diploma,
      timeConsumed: 140),

  pumbler(
      jobTitle: "Pumbler",
      jobSalary: 3900.0,
      education: Education.diploma,
      timeConsumed: 130),

  waiter(
      jobTitle: "Waiter",
      jobSalary: 2500.0,
      education: Education.uneducated,
      timeConsumed: 100);

  const Job(
      {required this.jobTitle,
      required this.jobSalary,
      required this.education,
      required this.timeConsumed});

  final String jobTitle;
  final double jobSalary;
  final Education education;
  final int timeConsumed;
}
