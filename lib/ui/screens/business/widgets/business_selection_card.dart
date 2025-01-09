import 'package:alpha/extensions.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class BusinessSelectionCard extends StatelessWidget {
  final double width;
  final Business business;
  final BusinessSectorState businessSectorState;

  const BusinessSelectionCard(this.business, this.businessSectorState,
      {super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: width,
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                color: Color(0xffFEA079)),
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(business.name, style: TextStyles.bold30),
              const SizedBox(height: 10.0),
              Wrap(spacing: 12.0, children: [
                _CardTag(getSectorEmoji(business.sector), business.sector.name),
                _CardTag("♻️", "ESG ${business.esgRating}"),
              ]),
              const SizedBox(height: 20.0),
              Text("Est. Revenue",
                  style: TextStyles.bold20
                      .copyWith(color: const Color(0xFF383838))),
              Text(
                (businessSectorState.grossProfit - business.operationalCosts)
                    .prettyCurrency,
                style: TextStyles.bold38,
              ),
              const SizedBox(height: 15.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _GenericTitleValue(
                        "Total Market Revenue",
                        businessSectorState.totalMarketRevenue.prettyCurrency,
                      ),
                      const SizedBox(width: 10.0),
                      _GenericTitleValue(
                        "Market Share",
                        "${business.marketShare}%",
                        width: 180.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _GenericTitleValue(
                        "Initial Costs",
                        (business.initialCost).prettyCurrency,
                      ),
                      const SizedBox(width: 10.0),
                      _GenericTitleValue(
                        "Operational Costs",
                        business.operationalCosts.prettyCurrency,
                        width: 180.0,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BusinessSelectionCardSm extends StatelessWidget {
  final double width;
  final Business business;
  final BusinessSectorState businessSectorState;

  const BusinessSelectionCardSm(this.business, this.businessSectorState,
      {super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: width,
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                color: Color(0xffFEA079)),
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(business.name, style: TextStyles.bold30),
              const SizedBox(height: 10.0),
              Wrap(spacing: 12.0, children: [
                _CardTag(getSectorEmoji(business.sector), business.sector.name),
                _CardTag("♻️", "ESG ${business.esgRating}"),
              ]),
              const SizedBox(height: 25.0),
              Text("Est. Revenue",
                  style: TextStyles.bold20
                      .copyWith(color: const Color(0xFF383838))),
              Text(
                (businessSectorState.grossProfit - business.operationalCosts)
                    .prettyCurrency,
                style: TextStyles.bold40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenericTitleValue extends StatelessWidget {
  final String title;
  final String value;
  final double width;

  const _GenericTitleValue(this.title, this.value, {this.width = 200.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
                  TextStyles.bold17.copyWith(color: const Color(0xFF383838))),
          Text(value, style: TextStyles.bold25),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      height: 38.0,
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
              child: Text(emoji, style: TextStyles.medium18)),
          Text(
            title,
            style: TextStyles.medium15,
          )
        ],
      ),
    );
  }
}

String getSectorEmoji(BusinessSector sector) {
  switch (sector) {
    case BusinessSector.technology:
      return "📱";
    case BusinessSector.eCommerce:
      return "🛍️";
    case BusinessSector.foodAndBeverage:
      return "🍔";
    case BusinessSector.influencer:
      return "📸";
    case BusinessSector.pharmaceutical:
      return "💊";
    case BusinessSector.noBusiness:
      return "❌";
    default:
      return "❓";
  }
}
