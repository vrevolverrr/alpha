import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlphaScaffold(
        title: "Dashboard",
        next: AlphaButton(width: 235.0, title: "End Turn"),
        children: <Widget>[]);
  }
}
