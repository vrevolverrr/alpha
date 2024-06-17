import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_entry.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_graph.dart';
import 'package:flutter/material.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  int _stockUnits = 10;
  late Stock _selectedStock;

  @override
  void initState() {
    _selectedStock = marketManager.stocks[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Investments",
        onTapBack: () => Navigator.of(context).pop(),
        children: <Widget>[
          const SizedBox(height: 30.0),
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
                      style: TextStyles.bold22,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: 640.0,
                    width: 360.0,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: marketManager.stocks
                            .map((stock) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedStock = stock),
                                    child: StockMarketEntry(
                                      stock: stock,
                                      selected: _selectedStock == stock,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AlphaContainer(
                          width: 410.0,
                          height: 450.0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 175.0)
                              Text(
                                _selectedStock.name,
                                style: TextStyles.bold20,
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                _selectedStock.code,
                                style: TextStyles.medium18,
                              ),
                              const SizedBox(height: 8.0),
                              Row(children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      "Share Price",
                                      style: TextStyles.bold16,
                                    ),
                                    SizedBox(
                                        width: 120.0,
                                        child: Text(
                                          "\$${_selectedStock.price.toStringAsFixed(2)}",
                                          style: TextStyles.bold22,
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      "Total Shares",
                                      style: TextStyles.bold16,
                                    ),
                                    SizedBox(
                                      width: 130.0,
                                      child: Text(
                                        "\$${(_selectedStock.price * 10).toStringAsFixed(2)}",
                                        style: TextStyles.bold22,
                                      ),
                                    )
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Owned Shares",
                                      style: TextStyles.bold16,
                                    ),
                                    Text("10 units", style: TextStyles.bold22)
                                  ],
                                ),
                              ]),
                              const SizedBox(height: 40.0),
                              Center(
                                child: LargeStockGraph(
                                  width: 350.0,
                                  height: 200.0,
                                  stock: _selectedStock,
                                ),
                              )
                            ],
                          )),
                      const SizedBox(width: 30.0),
                      AlphaContainer(
                          width: 310.0,
                          height: 450.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Investment Account",
                                style: TextStyles.bold22,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "\$${activePlayer.investments.sBalance}",
                                style: TextStyles.bold35,
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                "Total Returns",
                                style: TextStyles.bold20,
                              ),
                              const SizedBox(height: 5.0),
                              const Text(
                                "\$234.54",
                                style: TextStyles.bold32,
                              ),
                              Row(
                                children: <Widget>[
                                  Transform.translate(
                                    offset: const Offset(0.0, -2.5),
                                    child: Transform.rotate(
                                      angle: 1.571,
                                      child: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: Color(0xff3AB59E),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2.0),
                                  const Text(
                                    "6.82% since last turn",
                                    style: TextStyle(
                                        color: Color(0xff3AB59E),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Expanded(
                                  child: ListView(
                                children: const <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[Text("GLO"), Text("30")],
                                  )
                                ],
                              ))
                            ],
                          ))
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
                                    style: TextStyles.bold20,
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
