import 'package:alpha/extensions.dart';
import 'package:alpha/logic/stocks.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_entry.dart';
import 'package:flutter/material.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  int _stockUnits = 10;
  late final Stock _selectedStock;

  @override
  void initState() {
    _selectedStock = context.gameState.financialMarket.stocks[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Investments",
        onTapBack: () => Navigator.of(context).pop(),
        children: <Widget>[
          const SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Stock Market",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 22.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: 600.0,
                    child: SingleChildScrollView(
                      child: Column(
                        children: context.gameState.financialMarket.stocks
                            .map((stock) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: StockMarketEntry(stock: stock),
                                ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  const Row(
                    children: <Widget>[
                      AlphaContainer(
                          width: 400.0, height: 390.0, child: SizedBox()),
                      SizedBox(width: 30.0),
                      AlphaContainer(
                          width: 320.0, height: 390.0, child: SizedBox())
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  AlphaContainer(
                      width: 750.0,
                      height: 200.0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 15.0),
                              const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    "Units",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0),
                                  )),
                              const SizedBox(height: 5.0),
                              AlphaContainer(
                                  width: 260.0,
                                  height: 70.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  shadowOffset: const Offset(0.5, 2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          if (_stockUnits <= 0) return;
                                          setState(() => _stockUnits--);
                                        },
                                        child: const Icon(Icons.remove),
                                      ),
                                      Text(
                                        "${_stockUnits.toString()} ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 40.0,
                                            height: 1.75),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => _stockUnits++),
                                        child: const Icon(Icons.add),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Total Value",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: TweenAnimationBuilder(
                                    tween: Tween<double>(
                                        begin: 0.0,
                                        end:
                                            _selectedStock.price * _stockUnits),
                                    duration: Durations.medium3,
                                    builder: (BuildContext context,
                                            double value, Widget? child) =>
                                        Text(
                                      "\$${value.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40.0),
                                    ),
                                  )),
                              const SizedBox(height: 2.0),
                              const Row(
                                children: <Widget>[
                                  AlphaButton(
                                    width: 180.0,
                                    height: 60.0,
                                    title: "Buy",
                                    icon: Icons.shopping_cart_outlined,
                                    color: Color(0xff96DE9D),
                                  ),
                                  SizedBox(width: 20.0),
                                  AlphaButton(
                                    width: 180.0,
                                    height: 60.0,
                                    title: "Sell",
                                    icon: Icons.close,
                                    color: Color(0xffFF6B6B),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ],
              )
            ],
          )
        ]);
  }
}
