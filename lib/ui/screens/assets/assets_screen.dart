// ignore_for_file: prefer_const_constructors

import 'package:alpha/extensions.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/assets/screens/owned_cars_screen.dart';
import 'package:alpha/ui/screens/assets/screens/owned_real_estate_screen.dart';
import 'package:alpha/ui/screens/assets/widgets/select_asset.dart';
import 'package:flutter/material.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Assets",
        onTapBack: () => Navigator.of(context).pop(),
        children: <Widget>[
          SizedBox(height: 35.0),
          Text(
            "Choose an asset type to manage",
            style: TextStyles.medium20,
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () => context.navigateTo(const OwnedCarsScreen()),
                  child: SelectableAsset()),
              SizedBox(width: 40.0),
              GestureDetector(
                  onTap: () =>
                      context.navigateTo(const OwnedRealEstateScreen()),
                  child: SelectableAsset())
            ],
          )
        ]);
  }
}
