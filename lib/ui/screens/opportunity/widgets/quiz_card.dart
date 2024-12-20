import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String title;
  const Questions({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlphaAnimatedContainer(
      width: 700.0,
      height: 300.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Question #1",
              textAlign: TextAlign.center,
              style: TextStyles.bold30,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.bold30,
            ),
          ],
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  final bool selected;
  final String option;

  const Options({
    super.key,
    required this.option,
    this.selected = false,
  });

  final _animDuration = const Duration(milliseconds: 120);
  final _animCurve = Curves.decelerate;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.04 : 1.0,
      duration: _animDuration,
      child: AnimatedSlide(
        offset: selected ? const Offset(0.0, -0.04) : Offset.zero,
        duration: _animDuration,
        curve: _animCurve,
        child: AlphaAnimatedContainer(
          width: 325.0,
          height: 75.0,
          duration: _animDuration, // Highlight if selected
          curve: _animCurve,
          shadowOffset: selected ? const Offset(4.0, 5.0) : null,
          child: Center(
            child: Text(
              option,
              textAlign: TextAlign.center,
              style: TextStyles.bold30,
            ),
          ),
        ),
      ),
    );
  }
}


// class Options extends StatelessWidget {
//   final bool selected;
//   final String option;
//   const Options({super.key, required this.option, this.selected = false});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedScale(
//       scale: selected ? 1.04 : 1.0,
//       duration: Duration(milliseconds: 120),
//       child: AnimatedSlide(
//         offset: selected ? const Offset(0.0, -0.04) : Offset.zero,
//         duration: Duration(milliseconds: 120),
//         child: AlphaAnimatedContainer(
//           width: 325.0,
//           height: 75.0,
//           duration: Duration(milliseconds: 120),
//           child: Center(
//             child: Text(
//               option,
//               textAlign: TextAlign.center,
//               style: TextStyles.bold30,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }