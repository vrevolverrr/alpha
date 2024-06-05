import 'package:flutter/material.dart';

class SelectionTile extends StatelessWidget {
  final bool eligible;
  final bool selected;
  final Image image;
  final List<Widget> children;

  const SelectionTile(
      {super.key,
      required this.eligible,
      required this.image,
      required this.children,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.decelerate,
      child: Container(
        foregroundDecoration: !eligible
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation)
            : null,
        child: Stack(
          children: [
            Container(
              width: 260.0,
              height: 320.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(60, 149, 157, 165),
                        offset: Offset(0, 3),
                        blurRadius: 12)
                  ]),
              child: DefaultTextStyle(
                style: const TextStyle(
                    color: Colors.black, decoration: TextDecoration.none),
                child: Column(
                  children: [
                    SizedBox(
                        width: 260.0,
                        height: 140.0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0)),
                          child: Image.asset(
                            "assets/images/dashboard_budgeting.png",
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      height: 18.0,
                    ),
                    ...children
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(-1, -3),
              child: Container(
                width: 263.0,
                height: 323.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                    border: selected
                        ? Border.all(color: Colors.red, width: 3.0)
                        : null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
