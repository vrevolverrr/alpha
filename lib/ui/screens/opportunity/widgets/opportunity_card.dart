import 'package:alpha/assets.dart';
import 'package:alpha/logic/data/opportunity.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class OpportunityCardBack extends StatelessWidget {
  final Opportunity opportunity;
  const OpportunityCardBack({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 450,
      child: CardBack(opportunity: opportunity),
    );
  }
}

class OpportunityCardFront extends StatelessWidget {
  final Opportunity opportunity;
  const OpportunityCardFront({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 450,
      child: CardFront(opportunity: opportunity),
    );
  }
}

class _QuestionMarkIcon extends StatelessWidget {
  // Widget for the question mark icon on each card
  final AlphaAssets asset;

  const _QuestionMarkIcon({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0.0, 75.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          asset.path,
          height: 300.0,
        ),
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  // Widget for the question mark icon on each card
  final Opportunity opportunity;

  const _CardIcon({required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0.0, 35.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          opportunity.asset.path,
          height: 300.0,
        ),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final Opportunity opportunity;

  const CardBack({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return AlphaAnimatedContainer(
        color: opportunity.colorPrimary,
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: 500.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
          ),
          const _QuestionMarkIcon(asset: AlphaAssets.opportunityQuestionMark),
        ]));
  }
}

class CardFront extends StatelessWidget {
  final Opportunity opportunity;

  const CardFront({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    return AlphaAnimatedContainer(
        color: opportunity.colorPrimary,
        child: Stack(alignment: Alignment.topCenter, children: [
          Container(
            width: double.infinity,
            height: 500.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
          ),
          _CardIcon(opportunity: opportunity),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Container(
              width: 290,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: opportunity.colorSecondary,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600, offset: const Offset(0, 2.5))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Container(
                width: 250,
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  opportunity.titleName,
                  style: TextStyles.bold20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child: Container(
              width: 250,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                opportunity.description,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          )
        ]));
  }
}
