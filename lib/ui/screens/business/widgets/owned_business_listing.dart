import 'package:alpha/extensions.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OwnedBusinessListing extends StatelessWidget {
  final Business business;
  final bool selected;

  const OwnedBusinessListing(
      {super.key, required this.business, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: !selected ? Offset.zero : const Offset(0.05, 0.0),
      curve: Curves.decelerate,
      duration: Durations.medium1,
      child: AlphaAnimatedContainer(
          width: 360.0,
          height: 160.0,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100.0,
                height: double.infinity,
                child: Image.asset(
                  business.sector.asset.path,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190.0,
                    height: 50.0,
                    child: AutoSizeText(business.name,
                        style: TextStyles.bold19.copyWith(height: 1.4),
                        maxLines: 2),
                  ),
                  const SizedBox(height: 5.0),
                  _GenericTitleValue(
                      title: "Valuation",
                      child: Text(
                        businessManager
                            .calculateBusinessValuation(business)
                            .prettyCurrency,
                        style: TextStyles.bold22,
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
          style: TextStyles.bold16,
        ),
        const SizedBox(height: 3.0),
        child,
      ],
    );
  }
}
