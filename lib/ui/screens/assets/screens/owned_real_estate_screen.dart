import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/real_estate.dart';
import 'package:alpha/logic/real_estate_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:alpha/ui/screens/assets/dialogs/confirm_sell_dialog.dart';
import 'package:alpha/ui/screens/assets/dialogs/success_sold_dialog.dart';
import 'package:alpha/ui/screens/assets/widgets/owned_real_estate_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OwnedRealEstateScreen extends StatefulWidget {
  const OwnedRealEstateScreen({super.key});

  @override
  State<OwnedRealEstateScreen> createState() => _OwnedRealEstateScreenState();
}

class _OwnedRealEstateScreenState extends State<OwnedRealEstateScreen> {
  RealEstate? _selectedRealEstate =
      realEstateManager.getOwnedRealEstates(activePlayer).isNotEmpty
          ? realEstateManager.getOwnedRealEstates(activePlayer).first
          : null;

  void _handlePageChanged(int index, CarouselPageChangedReason reason) {
    _selectedRealEstate = RealEstates.listings[index];
  }

  void _handleSellRealEstate(BuildContext context) {
    context.showDialog(
        buildConfirSellRealEstateDialog(context, _selectedRealEstate!, () {
      realEstateManager.sellRealEstate(activePlayer, _selectedRealEstate!);
      context.showDialog(
          buildSoldRealEstateDialog(context, _selectedRealEstate!, () {
        setState(() {
          context.dismissDialog();
        });
      }));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Real Estate",
        onTapBack: () => Navigator.of(context).pop(),
        children: <Widget>[
          const SizedBox(height: 25.0),
          const Text("Manage your owned real estate assets",
              style: TextStyles.medium20),
          const SizedBox(height: 15.0),
          _buildOwnedRealEstate()
        ]);
  }

  Widget _buildOwnedRealEstate() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10.0),
          RenderIfTrue(
              condition: realEstateManager
                  .getOwnedRealEstates(activePlayer)
                  .isNotEmpty,
              child: _buildRealEstateCarousel()),
          const SizedBox(height: 35.0),
          RenderIfTrue(
            condition:
                realEstateManager.getOwnedRealEstates(activePlayer).isNotEmpty,
            child: Builder(
              builder: (context) => AlphaButton(
                width: 340.0,
                icon: Icons.shopping_cart_checkout_rounded,
                title: "Sell Property",
                onTap: () => _handleSellRealEstate(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRealEstateCarousel() {
    return CarouselSlider(
        items: realEstateManager
            .getOwnedRealEstates(activePlayer)
            .map((realEstate) => Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: OwnedRealEstateTile(realEstate: realEstate)))
            .toList(),
        options: CarouselOptions(
            onPageChanged: _handlePageChanged,
            initialPage: 0,
            height: 500.0,
            enableInfiniteScroll: false,
            viewportFraction: 0.47,
            enlargeCenterPage: true,
            enlargeFactor: 0.15));
  }
}
