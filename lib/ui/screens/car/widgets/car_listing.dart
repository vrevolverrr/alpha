import 'package:alpha/extensions.dart';
import 'package:alpha/logic/car_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CarListing extends StatelessWidget {
  final Car car;
  final bool selected;

  const CarListing({super.key, required this.car, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: !selected ? Offset.zero : const Offset(0.05, 0.0),
      curve: Curves.decelerate,
      duration: Durations.medium1,
      child: AlphaAnimatedContainer(
          width: 360.0,
          height: 175.0,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100.0,
                height: double.infinity,
                child: Image.asset(
                  car.type.image.path,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.0,
                    child: AutoSizeText(car.name,
                        style: TextStyles.bold19.copyWith(height: 1.4),
                        maxLines: 1),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      _GenericTitleValue(
                          title: "Car Type",
                          child: Text(
                            car.type.name,
                            style: TextStyles.bold20,
                          )),
                      const SizedBox(width: 14.0),
                      _GenericTitleValue(
                          title: "ESG",
                          child: Text(
                            car.esgBonus.toString(),
                            style: TextStyles.bold20,
                          )),
                      const SizedBox(width: 14.0),
                      _GenericTitleValue(
                          title: "Happiness",
                          child: Text(
                            car.happinessBonus.toString(),
                            style: TextStyles.bold20,
                          )),
                    ],
                  ),
                  _GenericTitleValue(
                      title: "Cost",
                      child: Text(
                        car.price.prettyCurrency,
                        style: TextStyles.bold20,
                      )),
                ],
              )
            ],
          )),
    );
  }
}

class _GenericTitleValue extends StatelessWidget {
  final String title;
  final Widget child;

  const _GenericTitleValue({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyles.bold14,
        ),
        const SizedBox(height: 3.0),
        child,
      ],
    );
  }
}

class _CardTag extends StatelessWidget {
  final String title;
  final String emoji;

  const _CardTag(this.emoji, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      width: 75.0,
      height: 20.0,
      decoration: BoxDecoration(
          color: const Color(0xffB5D2AD),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: Colors.black, width: 2.5),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(1.0, 2.0))
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
              offset: const Offset(-2.5, -3.0),
              child: Text(emoji, style: TextStyles.medium14)),
          Text(
            title,
            style: TextStyles.medium13,
          )
        ],
      ),
    );
  }
}
