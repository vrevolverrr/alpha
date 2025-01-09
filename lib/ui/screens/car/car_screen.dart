import 'package:alpha/extensions.dart';
import 'package:alpha/logic/car_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/common/alpha_stat_cards.dart';
import 'package:alpha/ui/common/animated_value.dart';
import 'package:alpha/ui/screens/car/widgets/car_listing.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  Car _selectedCar = carManager.getAvailableCars(activePlayer).first;

  void _handleBuyRealEstate(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Entitlements",
      onTapBack: () => Navigator.of(context).pop(),
      next: AlphaButton.next(
          onTap: () => context.navigateAndPopTo(const DashboardScreen())),
      children: <Widget>[
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCarListingsColumn(),
            _buildCarDetailsColumn(context),
          ],
        ),
      ],
    );
  }

  Widget _buildCarListingsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Market Listings",
            style: TextStyles.bold22,
          ),
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          height: 640.0,
          width: 380.0,
          child: SingleChildScrollView(
              child: Wrap(
            runSpacing: 15.0,
            children: carManager
                .getAvailableCars(activePlayer)
                .map((car) => GestureDetector(
                      onTap: () => setState(() => _selectedCar = car),
                      child:
                          CarListing(car: car, selected: car == _selectedCar),
                    ))
                .toList(),
          )),
        ),
      ],
    );
  }

  Widget _buildCarDetailsColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 280.0,
          height: 45.0,
          child: PlayerStatCard(
              emoji: "💵",
              title: "Savings",
              value: activePlayer.savings.balance.prettyCurrency),
        ),
        const SizedBox(height: 15.0),
        _buildCarDetails(),
        const SizedBox(height: 15.0),
        _buildPurchaseControls(context),
      ],
    );
  }

  Widget _buildCarDetails() {
    return AlphaContainer(
      width: 650.0,
      height: 310.0,
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          SizedBox(
              width: 280.0,
              height: double.infinity,
              child:
                  Image.asset(_selectedCar.type.image.path, fit: BoxFit.cover)),
          const SizedBox(width: 25.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Car Name",
                    style: TextStyles.bold18.copyWith(color: Colors.black87),
                  ),
                  SizedBox(
                    width: 260.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: 35.0, maxWidth: 260.0),
                      child: AutoSizeText(
                        _selectedCar.name,
                        style: TextStyles.bold25,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              _GenericTitleValue(
                  title: "Price", value: _selectedCar.price.prettyCurrency),
              const SizedBox(height: 8.0),
              _GenericTitleValue(
                  title: "Maintenance Cost",
                  value: _selectedCar.maintenanceCost.prettyCurrency),
              const SizedBox(height: 6.0),
              _GenericTitleValue(
                  title: "Depreciation Rate (per round)",
                  value: "${_selectedCar.depreciationRate}%"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPurchaseControls(BuildContext context) {
    return AlphaContainer(
      width: 650.0,
      height: 185.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Column(children: <Widget>[
                _GenericTitleValue(
                    width: 200.0,
                    title: "Total Loan Amount",
                    value: _selectedCar.loanAmount.prettyCurrency),
                const SizedBox(height: 6.0),
                _GenericTitleValue(
                    width: 200.0,
                    title: "COE Price",
                    value: carManager.calculateCOEPrice().prettyCurrency),
              ]),
              Column(children: <Widget>[
                _GenericTitleValue(
                    width: 190.0,
                    title: "Payment Per Round",
                    value: _selectedCar.repaymentPerRound.prettyCurrency),
                const SizedBox(height: 6.0),
                _GenericTitleValue(
                    width: 190.0,
                    title: "Repayment Period",
                    value: "${_selectedCar.repaymentPeriod} rounds"),
              ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Upfront Payment", style: TextStyles.bold16),
                    AnimatedValue(
                      _selectedCar.upfrontPayment +
                          carManager.calculateCOEPrice(),
                      currency: true,
                      style: TextStyles.bold30,
                    ),
                    const SizedBox(height: 6.0),
                    Builder(
                      builder: (context) => AlphaButton(
                        width: 205.0,
                        height: 60.0,
                        disabled: _selectedCar.upfrontPayment >
                            activePlayer.savings.balance,
                        onTapDisabled: () => context.showSnackbar(
                            message: "✋🏼 Insufficient funds for downpayment"),
                        title: "Buy",
                        icon: Icons.shopping_cart_outlined,
                        color: const Color(0xff96DE9D),
                        onTap: () => _handleBuyRealEstate(context),
                      ),
                    ),
                  ]),
            ],
          ),
          // AlphaButton(title: "Purchase", width: 260.0, onTap: () {}),
        ],
      ),
    );
  }
}

class _GenericTitleValue extends StatelessWidget {
  final String title;
  final String value;
  final double width;

  const _GenericTitleValue(
      {required this.title, required this.value, this.width = 260.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyles.bold16.copyWith(color: Colors.black87),
        ),
        SizedBox(
          width: width,
          child: Text(
            value,
            style: TextStyles.bold23,
          ),
        )
      ],
    );
  }
}
