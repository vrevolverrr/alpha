import 'package:alpha/assets.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:flutter/material.dart';

class BusinessSelectionCard extends StatelessWidget {
  final Business business;
  final bool eligible;
  final bool selected;
  const BusinessSelectionCard(
      {super.key,
      required this.business,
      this.eligible = true,
      this.selected = false});

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
                duration: const Duration(milliseconds: 120),
                shadowOffset:
                    !selected ? const Offset(0.5, 3.0) : const Offset(5.0, 6.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0)),
                          color: eligible
                              ? const Color(0xffFEA079)
                              : const Color(0xffBDBDBD)),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      children: <Widget>[
                        Text(
                          business.titleName,
                          style: TextStyles.bold25,
                        ),
                        const SizedBox(height: 13.0),
                        BusinessDescriptionTagCollection(
                            business: business, eligible: eligible)
                      ],
                    )
                  ],
                )),
            _JobHeroImage(
                asset: eligible ? business.asset : business.assetBW,
                eligible: eligible),
            RenderIfFalse(condition: eligible, child: _IneligibleBanner())
          ],
        ),
      ),
    );
  }
}

class _JobHeroImage extends StatelessWidget {
  /// Widget for the hero image on each job card
  final AlphaAssets asset;
  final bool eligible;

  const _JobHeroImage({required this.asset, required this.eligible});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0.0, -20.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          asset.path,
          height: 220.0,
        ),
      ),
    );
  }
}

class _IneligibleBanner extends StatelessWidget {
  ///
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(0.0, -45.0)
            ..scale(1.06, 1.06, 1.0),
          width: 320.0,
          height: 45.0,
          padding: const EdgeInsets.only(top: 4.0),
          decoration: BoxDecoration(
              color: const Color(0xffEC5757),
              border: Border.all(color: Colors.black, width: 2.5),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black, offset: Offset(1.0, 3.0))
              ]),
          child: const Text(
            "Ineligible",
            style: TextStyles.bold20,
          ),
        ));
  }
}

class _BusinessDescriptionTag extends StatelessWidget {
  final String title;
  final bool eligible;
  const _BusinessDescriptionTag({required this.title, this.eligible = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: eligible ? const Color(0xffB5D2AD) : const Color(0xffBDBDBD),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.black, width: 2.5),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(0.5, 1.8))
          ]),
      child: Text(
        title,
        style: TextStyles.medium16,
      ),
    );
  }
}

class BusinessDescriptionTagCollection extends StatelessWidget {
  final Business business;
  final bool eligible;
  const BusinessDescriptionTagCollection(
      {super.key, required this.business, required this.eligible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 15.0,
        alignment: WrapAlignment.center,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          _BusinessDescriptionTag(
            title: "💵 \$${business.totalMarketRevenue.toStringAsFixed(0)}",
            eligible: eligible,
          ),
          _BusinessDescriptionTag(
            title: "🕒 ${business.timeConsumed}",
            eligible: eligible,
          ),
        ],
      ),
    );
  }
}
