import 'package:alpha/assets.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class JobSelectionCard extends StatelessWidget {
  const JobSelectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AlphaAnimatedContainer(
            child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  color: Color(0xffFEA079)),
            ),
            const SizedBox(height: 20.0),
            const Column(
              children: <Widget>[
                Text(
                  "Programmer",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0),
                ),
                SizedBox(height: 13.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 15.0,
                    alignment: WrapAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      _JobDescriptionTag(title: "💵 \$4300"),
                      _JobDescriptionTag(title: "🕒 135"),
                      _JobDescriptionTag(title: "🎓 Bachelors"),
                    ],
                  ),
                )
              ],
            )
          ],
        )),
        Transform.translate(
          offset: const Offset(0.0, -20.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              AlphaAssets.jobProgrammer.path,
              height: 220.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _JobDescriptionTag extends StatelessWidget {
  final String title;
  const _JobDescriptionTag({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: const Color(0xffB5D2AD),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black, width: 2.5),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(0.5, 1.8))
          ]),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
