import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final String title;
  final String description;
  final bool selected;
  final bool affordable;
  const EducationCard(
      {super.key,
      required this.title,
      required this.description,
      this.selected = false,
      this.affordable = true});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 120),
      offset: !selected ? Offset.zero : const Offset(0.0, -0.03),
      child: AnimatedScale(
        scale: !selected ? 1.0 : 1.03,
        duration: const Duration(milliseconds: 120),
        child: Stack(
          children: <Widget>[
            AlphaAnimatedContainer(
                width: 400.0,
                height: 500.0,
                duration: const Duration(milliseconds: 120),
                shadowOffset:
                    !selected ? const Offset(0.5, 3.0) : const Offset(5.0, 6.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 280.0,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          color: affordable
                              ? const Color(0xffFEA079)
                              : const Color(0xffBDBDBD)),
                    ),
                    const SizedBox(height: 25.0),
                    Column(
                      children: <Widget>[
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25.0),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16.0, height: 1.8),
                          ),
                        )
                      ],
                    )
                  ],
                )),
            RenderIfFalse(condition: affordable, child: _UnaffordableBanner())
          ],
        ),
      ),
    );
  }
}

class _UnaffordableBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(.0, 150.0)
            ..scale(1.06, 1.06, 1.0),
          width: 400.0,
          height: 50.0,
          padding: const EdgeInsets.only(top: 4.0),
          decoration: BoxDecoration(
              color: const Color(0xffEC5757),
              border: Border.all(color: Colors.black, width: 2.5),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black, offset: Offset(1.0, 3.0))
              ]),
          child: const Text(
            "Cannot Afford",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ));
  }
}
