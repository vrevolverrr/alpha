import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Assets",
        onTapBack: () => Navigator.of(context).pop(),
        children: const <Widget>[]);
  }
}
