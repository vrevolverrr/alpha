import 'package:alpha/logic/data/real_estate.dart';
import 'package:alpha/logic/real_estate_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/assets/widgets/owned_real_estate_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OwnedCarsScreen extends StatefulWidget {
  const OwnedCarsScreen({super.key});

  @override
  State<OwnedCarsScreen> createState() => _OwnedCarsScreenState();
}

class _OwnedCarsScreenState extends State<OwnedCarsScreen> {
  RealEstate _selectedRealEstate = RealEstates.listings.first;

  void _handlePageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _selectedRealEstate = RealEstates.listings[index];
    });
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
          CarouselSlider(
              items: RealEstates.listings
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
                  enlargeFactor: 0.15)),
          const SizedBox(height: 35.0),
          const AlphaButton(
              width: 340.0,
              icon: Icons.shopping_cart_checkout_rounded,
              title: "Sell Property")
        ],
      ),
    );
  }
}
