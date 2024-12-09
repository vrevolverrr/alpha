import 'package:alpha/extensions.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/common/alpha_stat_cards.dart';
import 'package:alpha/ui/screens/business/widgets/business_selection_card.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;

class BusinessSelectionScren extends StatefulWidget {
  final BusinessSector sector;

  const BusinessSelectionScren(
      {super.key, this.sector = BusinessSector.technology});

  @override
  State<BusinessSelectionScren> createState() => _BusinessSelectionScrenState();
}

class _BusinessSelectionScrenState extends State<BusinessSelectionScren> {
  final List<Business> _businesses =
      businessManager.generateBusinesses(BusinessSector.technology, 5);

  final CarouselSliderController _controller = CarouselSliderController();

  late Business _selectedBusiness = _businesses[0];

  @override
  void initState() {
    super.initState();
  }

  void _handlePageChanged(int index) {
    setState(() {
      _selectedBusiness = _businesses[index];
    });
  }

  bool _handleCanPurchase() {
    if (activePlayer.savings.balance < _selectedBusiness.initialCost) {
      return true;
    }

    return false;
  }

  void _handlePurchase(BuildContext context) {
    if (_handleCanPurchase()) {
      context.showSnackbar(
          message: "✋🏼 Insufficients funds to start this business");
      return;
    }

    businessManager.buyBusiness(_selectedBusiness, activePlayer);
    context.showSnackbar(
        message:
            "🎉 Congratulations! You are now the proud owner of ${_selectedBusiness.name}");
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Choose A Business",
      onTapBack: () => Navigator.pop(context),
      mainAxisAlignment: MainAxisAlignment.center,
      next: AlphaButton.next(
          onTap: () => context.navigateTo(const DashboardScreen())),
      children: [
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 280.0,
                height: 45.0,
                child: ListenableBuilder(
                  listenable: activePlayer.savings,
                  builder: (context, child) => PlayerStatCard(
                      emoji: "💵",
                      title: "Savings",
                      value: activePlayer.savings.balance.prettyCurrency),
                )),
          ],
        ),
        const SizedBox(height: 20.0),
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: _businesses.length,
          itemBuilder: (context, index, _) {
            final business = _businesses[index];
            final sectorState =
                businessManager.getBusinessState(business.sector);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: (business == _selectedBusiness)
                  ? BusinessSelectionCard(
                      business,
                      sectorState,
                      width: MediaQuery.sizeOf(context).width,
                    )
                  : BusinessSelectionCardSm(business, sectorState,
                      width: MediaQuery.sizeOf(context).width),
            );
          },
          options: CarouselOptions(
              onPageChanged: (index, _) => _handlePageChanged(index),
              height: 480.0,
              enlargeCenterPage: true,
              viewportFraction: 0.4),
        ),
        const SizedBox(height: 30.0),
        Builder(
            builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AlphaButton(
                        width: 260.0,
                        title: "Apply loan",
                        color: const Color(0xFF91CE77),
                        onTap: () => context.showSnackbar(
                            message: "🚧 This feature is under construction")),
                    const SizedBox(width: 20.0),
                    AlphaButton(
                        width: 380.0,
                        title: "Purchase Business",
                        disabled: _handleCanPurchase(),
                        onTapDisabled: () => _handlePurchase(context),
                        onTap: () => _handlePurchase(context)),
                    const SizedBox(width: 60.0),
                  ],
                )),
        const SizedBox(height: 60.0),
      ],
    );
  }
}
