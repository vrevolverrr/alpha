import 'package:alpha/assets.dart';
import 'package:alpha/ui/common/alpha_next_button.dart';
import 'package:alpha/ui/common/alpha_title.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  final void Function()? onTapNext;
  const LandingScreen({super.key, this.onTapNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              bottom: 0.0,
              right: -40.0,
              child: Image.asset(
                AlphaAssets.bgLandingCities.path,
                scale: 1.65,
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.only(right: 50.0, bottom: 50.0),
                  child: AlphaNextButton(
                    onTap: onTapNext,
                  ))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30.0),
              const Center(
                child: AlphaTitle(
                  "ALPHA",
                  color: Color(0xff7FBC8C),
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 0.0),
              const AlphaTitle(
                "NCF",
                fontSize: 200.0,
                shadowOffset: Offset(8.0, 8.0),
                strokeWidth: 8.0,
              ),
              Transform.translate(
                offset: const Offset(45, -60),
                child: const AlphaTitle(
                  "2025.",
                  fontSize: 200.0,
                  shadowOffset: Offset(8.0, 8.0),
                  strokeWidth: 8.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
