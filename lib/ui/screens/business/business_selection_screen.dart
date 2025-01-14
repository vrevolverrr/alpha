import 'package:alpha/extensions.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:alpha/logic/hints_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/common/alpha_stat_card.dart';
import 'package:alpha/ui/screens/business/dialogs/confirm_loan_dialog.dart';
import 'package:alpha/ui/screens/business/dialogs/confirm_purchase_business_dialog.dart';
import 'package:alpha/ui/screens/business/dialogs/landing_dialog_selection.dart';
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
  late final List<Business> _businesses =
      businessManager.generateBusinesses(widget.sector, 5);

  final CarouselSliderController _controller = CarouselSliderController();

  late Business _selectedBusiness = _businesses[0];

  final ValueNotifier<bool> hasPurchasedBusiness = ValueNotifier(false);
  final ValueNotifier<bool> hasTookLoan = ValueNotifier(false);

  get width => null;

  @override
  void initState() {
    super.initState();
  }

  void _handlePageChanged(int index) {
    setState(() {
      _selectedBusiness = _businesses[index];
    });
  }

  bool _canPurchase() {
    return accountsManager.getAvailableBalance(activePlayer) <
        _selectedBusiness.initialCost;
  }

  void _handlePurchase(BuildContext context) {
    if (_canPurchase()) {
      context.showSnackbar(
          message: "✋🏼 Insufficients funds to start this business");
      return;
    }
    context.showDialog(buildConfirmBuyBusinessDialog(context, _selectedBusiness,
        businessManager.getBusinessState(_selectedBusiness.sector), () {
      businessManager.buyBusiness(_selectedBusiness, activePlayer);
      context.dismissDialog();
      hasPurchasedBusiness.value = true;
      context.showSnackbar(
          message:
              "🎉 Business purchased successfully. Press Next to continue.");
    }));
  }

  void _handleApplyLoan(BuildContext context) {
    context.showDialog(buildConfirmBusinessLoanDialog(context, () {
      loanManager.applyBusinessLoan(activePlayer);
      hasTookLoan.value = true;
      context.dismissDialog();
      context.showSnackbar(
          message: "🎉 Loan success. You can now purchase a business.");
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Choose A Business",
      onTapBack: () => Navigator.pop(context),
      landingDialog: hintsManager.shouldShowHint(activePlayer, Hint.buyBusiness)
          ? AlphaDialogBuilder.dismissable(
              title: "Welcome",
              dismissText: "Confirm",
              width: 350.0,
              child: const BusinessesLandingDialog())
          : null,
      mainAxisAlignment: MainAxisAlignment.center,
      next:
          AlphaButton.next(onTap: () => context.navigateTo(DashboardScreen())),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlayerAccountBalanceStatCard(
                accountsManager.getPlayerAccount(activePlayer)),
            const SizedBox(width: 20.0),
            PlayerDebtStatCard(loanManager.getPlayerDebt(activePlayer)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: BusinessSelectionCard(
                  business,
                  sectorState,
                ));
          },
          options: CarouselOptions(
              onPageChanged: (index, _) => _handlePageChanged(index),
              height: 375.0,
              enlargeFactor: 0.25,
              viewportFraction: 0.4),
        ),
        const SizedBox(height: 30.0),
        ValueListenableBuilder(
            valueListenable: hasPurchasedBusiness,
            builder: (context, purchased, _) => !purchased
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListenableBuilder(
                          listenable: hasTookLoan,
                          builder: (context, _) => (!hasTookLoan.value)
                              ? AlphaButton(
                                  width: 260.0,
                                  title: "Apply loan",
                                  color: const Color(0xFF91CE77),
                                  onTap: () => _handleApplyLoan(context))
                              : const SizedBox.shrink()),
                      const SizedBox(width: 20.0),
                      ListenableBuilder(
                        listenable:
                            accountsManager.getPlayerAccount(activePlayer),
                        builder: (context, _) => AlphaButton(
                            width: 380.0,
                            title: "Purchase Business",
                            disabled: _canPurchase(),
                            onTapDisabled: () => _handlePurchase(context),
                            onTap: () => _handlePurchase(context)),
                      ),
                      const SizedBox(width: 60.0),
                    ],
                  )
                : const SizedBox(height: 70.0)),
        const SizedBox(height: 60.0),
      ],
    );
  }
}
