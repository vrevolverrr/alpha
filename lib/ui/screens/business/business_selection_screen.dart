import 'package:alpha/extensions.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/business/widgets/business_selection_card.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class BusinessSelectionScreen extends StatefulWidget {
  const BusinessSelectionScreen({super.key});

  @override
  State<BusinessSelectionScreen> createState() =>
      _BusinessSelectionScreenState();
}

class _BusinessSelectionScreenState extends State<BusinessSelectionScreen> {
  Business _selectedBusiness = Business.noBusiness;

  /// This function maps each Business to a [BusinessSelectionCard] widget and computes
  /// the eligibility and whether or not the card has been selected
  /// This function is called on each build()
  List<BusinessSelectionCard> _mapBusinessCards() => Business.values
      // TODO optimise performance by only sorting once during initState
      //condition == true ? new Container() : new Container()
      .where((business) => business.totalMarketRevenue > 0)
      .map((business) => BusinessSelectionCard(
            // map each [Job] enum to a [JobSelectionCard] widget
            business: business,
            selected: business == _selectedBusiness,
            eligible: true,
            image: business.asset,
          )) // eliglbe iff player meets education requirements
      .toList()
    // sort by eligible first, then by salary
    ..sort((BusinessSelectionCard a, BusinessSelectionCard b) {
      // sort by eligibility first
      if ((a.eligible && !b.eligible) || (!a.eligible && b.eligible)) {
        return (a.eligible && !b.eligible) ? -1 : 1;
      }

      // then sort by totalMarketRevenue ascending
      return (a.business.totalMarketRevenue - b.business.totalMarketRevenue)
          .toInt();
    });

  void _confirmBusinessSelection(BuildContext context) {
    /// This function maps to the action of the CONFIRM button of the screen
    if (_selectedBusiness == Business.noBusiness) {
      context.showSnackbar(message: "✋🏼 Please select a business to continue");
      return;
    }

    final AlphaDialogBuilder dialog = AlphaDialogBuilder(
        title: "Confirm Business",
        child: Column(
          children: <Widget>[
            Text(
              "You have chosen to invest in the ${_selectedBusiness.titleName} sector.",
              style: TextStyles.medium22,
            ),
            const SizedBox(height: 2.0),
            const Text("Are you sure?", style: TextStyles.medium22),
            const SizedBox(height: 2.0),
            HeadCountBuilder(business: _selectedBusiness),
            const SizedBox(height: 25.0),
            BusinessDescriptionTagCollection(
                business: _selectedBusiness, eligible: true),
            const SizedBox(height: 50.0),
          ],
        ),
        cancel: DialogButtonData.cancel(context),
        next: DialogButtonData.confirm(onTap: _confirmBusinessInDialog));

    context.showDialog(dialog);
  }

  void _incrementHeadCount() {
    BusinessHeadCount.incrementHeadCount(_selectedBusiness);
  }

  void _confirmBusinessInDialog() {
    // // This function maps to the CONFIRM button of the alert dialog
    // activePlayer.career.set(_selectedJob);
    // // TODO change this
    // // activePlayer.creditSalary();
    // Future.delayed(const Duration(milliseconds: 50), () {
    //   _incrementHeadCount();
    // });
    _incrementHeadCount();
    context.navigateAndPopTo(const DashboardScreen());
  }

  void _showIneligibleMessage(BuildContext context) {
    /// This function is called when an ineligible card is pressed
    context.showSnackbar(
        message: "✋🏼 Insufficient money to invest in that business.");
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Choose a Business",
        onTapBack: () => Navigator.of(context).pop(),
        landingMessage: "🎯 Choose a business you would like to invest",
        next: Builder(
            builder: (BuildContext context) => AlphaButton(
                width: 230.0,
                title: "Confirm",
                onTap: () => _confirmBusinessSelection(context))),
        children: <Widget>[
          const SizedBox(height: 5.0),
          Expanded(
            child: Builder(
              builder: (BuildContext context) => GridView.count(
                childAspectRatio: 0.78,
                padding: const EdgeInsets.symmetric(
                    horizontal: 60.0, vertical: 50.0),
                mainAxisSpacing: 50.0,
                crossAxisSpacing: 50.0,
                crossAxisCount: 3,
                children: _mapBusinessCards()
                    .map((BusinessSelectionCard card) => GestureDetector(
                          onTap: card.eligible
                              ? () => setState(
                                  () => _selectedBusiness = card.business)
                              : () => _showIneligibleMessage(context),
                          child: card,
                        ))
                    .toList(),
              ),
            ),
          )
        ]);
  }
}

class HeadCountBuilder extends StatelessWidget {
  final Business business;

  const HeadCountBuilder({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable:
          BusinessHeadCount(), // Ensure this returns your ChangeNotifier
      builder: (context, _) {
        return Text(
            "Current headcount: ${BusinessHeadCount.getHeadCount(business)}",
            style: TextStyles.medium22);
      },
    );
  }
}
