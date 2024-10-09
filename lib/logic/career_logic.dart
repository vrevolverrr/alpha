import 'package:alpha/logic/data/careers.dart';
import 'package:flutter/foundation.dart';

class Career extends ChangeNotifier {
  late Job _job;

  Career({required Job initial}) : _job = initial;

  Job get job => _job;
  double get salary => _job.jobSalary;
  String get sSalary => _job.jobSalary.toStringAsFixed(2);

  void set(Job newJob) => _job = newJob;
}
