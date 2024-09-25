import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final String title;
  final String description;
  final double cost;
  final int xp;
  final bool selected;
  final bool affordable;
  const EducationCard(
      {super.key,
      required this.cost,
      required this.xp,
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
                height: 200.0,
                duration: const Duration(milliseconds: 120),
                shadowOffset:
                    !selected ? const Offset(0.5, 3.0) : const Offset(5.0, 6.0),
                child: Column(
                  //////////////////////////////Make changes here//////////////////////////////////////////
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 3),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text("+${xp.toString()} xp",
                            style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 88, 231, 93))),
                      ),
                    ),

                    // ignore: sized_box_for_whitespace
                    Container(
                      height: 91,
                      child: Column(
                        children: <Widget>[
                          Text(title, style: TextStyles.bold22),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              description,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontSize: 14.0, height: 1.8),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 68.0,
                      decoration: BoxDecoration(
                          border: const Border(
                              top: BorderSide(
                            color: Colors.black,
                            width: 4.0,
                          )),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0)),
                          color: affordable
                              ? const Color(0xffFEA079)
                              : const Color(0xffBDBDBD)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Ensures the row sizes itself to its content
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "💵",
                              style: TextStyle(
                                fontSize:
                                    28.0, // Larger font size for the emoji
                              ),
                            ),
                            const SizedBox(
                                width:
                                    8.0), // Add spacing between emoji and text
                            Text("-\$${cost.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                    color: Color.fromARGB(255, 230, 45, 32))),
                          ],
                        ),
                      ),
                    ),
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
    return Transform(
      alignment: Alignment.topLeft,
      transform: Matrix4.identity()
        ..rotateZ(
            -0.5236) // Rotate 30 degrees counterclockwise (-0.5236 radians)
        ..translate(-40.0, 20.0), // Adjust translation to fit your needs
      child: Container(
        alignment: Alignment.center,
        width: 110.0, // Adjust width for a better diagonal fit
        height: 35.0,
        padding: const EdgeInsets.only(top: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xffEC5757),
          border: Border.all(color: Colors.black, width: 2.5),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(1.0, 3.0))
          ],
        ),
        child: const Text(
          "Cannot Afford",
          style: TextStyles.bold12,
        ),
      ),
    );
  }
}
