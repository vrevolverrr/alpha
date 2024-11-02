import 'package:alpha/logic/data/careers.dart';
import 'package:flutter/foundation.dart';

class Career extends ChangeNotifier {
  late Job _job;

  Career({required Job initial}) : _job = initial;

  Job get job => _job;
  double get salary => _job.salary;
  String get sSalary => _job.salary.toStringAsFixed(2);
  double get cpf => 0.20 * _job.salary;

  void set(Job newJob) => _job = newJob;
}
