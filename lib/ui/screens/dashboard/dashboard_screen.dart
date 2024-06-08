import 'package:alpha/extensions.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/investments/investments_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Dashboard",
        mainAxisAlignment: MainAxisAlignment.center,
        next: AlphaButton(
          width: 235.0,
          title: "End Turn",
          onTap: () => context.navigateTo(const InvestmentsScreen()),
        ),
        children: const <Widget>[]);
  }
}
