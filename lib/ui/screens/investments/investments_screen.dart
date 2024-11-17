import 'package:alpha/extensions.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_listing.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_graph.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_price_change.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_risk_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  int _stockUnits = 10;
  Stock _selectedStock = marketManager.stocks.first;

  void _handleBuyShare(BuildContext context) {}

  void _handleSellShare(BuildContext context) {}

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
                                    child: StockListing(
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
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    _selectedStock.name,
                                    style: TextStyles.bold22,
                                  ),
                                  const SizedBox(width: 10.0),
                                  StockPriceChangeIndicator(
                                      change:
                                          _selectedStock.percentPriceChange()),
                                ],
                              ),
                              const SizedBox(height: 2.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Transform.translate(
                                    offset: const Offset(1.0, 3.5),
                                    child: Text(
                                      _selectedStock.code,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  const SizedBox(width: 15.0),
                                  StockRiskLabel(risk: _selectedStock.risk),
                                  const SizedBox(width: 8.0),
                                  _ESGLabel(esgRating: _selectedStock.esgRating)
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              Row(children: <Widget>[
                                _GenericTitleValue(
                                  title: "Share Price",
                                  value: _selectedStock.price.prettyCurrency,
                                  width: 120.0,
                                ),
                                _GenericTitleValue(
                                  title: "Total Shares",
                                  value: _selectedStock.price.prettyCurrency,
                                  width: 240.0,
                                ),
                              ]),
                              const SizedBox(height: 45.0),
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
                                style: TextStyles.bold20,
                              ),
                              Text(
                                (true)
                                    ? 543.24.prettyCurrency
                                    : activePlayer
                                        .investments.balance.prettyCurrency,
                                style: TextStyles.bold25,
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                "Portfolio Value",
                                style: TextStyles.bold20,
                              ),
                              const SizedBox(height: 2.0),
                              const Text(
                                "\$1656.12",
                                style: TextStyles.bold30,
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
                              const SizedBox(height: 10.0),
                              const Expanded(child: _PortfolioTable())
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
                                      value.prettyCurrency,
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

  AlphaDialogBuilder _buildConfirmBuyDialog(
      BuildContext context, void Function() onTapConfirm) {
    return AlphaDialogBuilder(
        title: "Confirm Buy",
        child: const Column(
          children: <Widget>[Text("Are you sure you want to buy?")],
        ),
        cancel: DialogButtonData.cancel(context),
        next: DialogButtonData.confirm(onTap: onTapConfirm));
  }
}

class _GenericTitleValue extends StatelessWidget {
  final String title;
  final String value;
  final double width;

  const _GenericTitleValue(
      {required this.title, required this.value, this.width = 120.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyles.bold16,
        ),
        SizedBox(
          width: width,
          child: Text(
            value,
            style: TextStyles.bold22,
          ),
        )
      ],
    );
  }
}

class _ESGLabel extends StatelessWidget {
  final int esgRating;

  const _ESGLabel({required this.esgRating});

  @override
  Widget build(BuildContext context) {
    return (esgRating > 0)
        ? Container(
            width: 95.0,
            height: 30.0,
            alignment: Alignment.center,
            transform: Matrix4.translation(Vector3(-3.0, 1.0, 0.0)),
            decoration: BoxDecoration(
              color: const Color(0xFF73EB75),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black, width: 2.5),
            ),
            child: Transform.translate(
              offset: const Offset(-1.0, 0.5),
              child: Text("ESG $esgRating",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700)),
            ),
          )
        : const SizedBox();
  }
}

// A table that displays the player's portfolio, listing each stock on the market, and the number of shares owned, with the total value.
class _PortfolioTable extends StatelessWidget {
  const _PortfolioTable();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black, width: 2.0),
        columnWidths: const {
          0: FixedColumnWidth(55.0),
          1: FixedColumnWidth(85.0),
          2: FixedColumnWidth(60.0),
          3: FixedColumnWidth(65.0),
        },
        children: <TableRow>[
          _buildTableHeader(),
          _buildTableRow("GSPC", "\$987.54", "50", 7.84),
          _buildTableRow("DJI", "\$424.83", "35", 8.21),
          _buildTableRow("REIT", "\$161.41", "15", 4.23),
          _buildTableRow("ETI", "\$82.34", "20", -5.23),
          _buildTableRow("MYS", "\$0.00", "0", 0),
          _buildTableRow("VRX", "\$0.00", "0", 0),
          _buildTableRow("ECW", "\$0.00", "0", 0),
          _buildTableRow("STI", "\$0.00", "0", 0),
        ],
      ),
    );
  }
}

TableRow _buildTableHeader() {
  return const TableRow(
      decoration: BoxDecoration(color: Color(0xffE0E0E0)),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Text(
            "Code",
            textAlign: TextAlign.center,
            style: TextStyles.bold13,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 3.0, left: 5.0, right: 5.0),
            child: Text(
              "Total Value",
              style: TextStyles.bold13,
            )),
        Padding(
            padding: EdgeInsets.only(top: 3.0, left: 5.0, right: 5.0),
            child: Text(
              "Units",
              style: TextStyles.bold13,
            )),
        Padding(
            padding: EdgeInsets.only(top: 3.0, left: 5.0, right: 5.0),
            child: Text(
              "Change",
              style: TextStyles.bold13,
            ))
      ]);
}

TableRow _buildTableRow(
    String code, String value, String units, double percentChange) {
  return TableRow(children: <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        code,
        textAlign: TextAlign.center,
        style: TextStyles.bold15,
      ),
    ),
    Padding(
        padding:
            const EdgeInsets.only(top: 3.0, bottom: 2.0, left: 5.0, right: 5.0),
        child: Text(
          value,
          style: TextStyles.medium15,
        )),
    Padding(
        padding:
            const EdgeInsets.only(top: 3.0, bottom: 2.0, left: 5.0, right: 5.0),
        child: Text(
          units,
          style: TextStyles.medium15,
        )),
    Padding(
        padding:
            const EdgeInsets.only(top: 3.0, bottom: 2.0, left: 5.0, right: 5.0),
        child: Text(
          "$percentChange%",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
              color: percentChange == 0
                  ? const Color(0xFF5B5B5B)
                  : (percentChange < 0
                      ? const Color(0xffE15353)
                      : const Color(0xff3AB59E))),
        ))
  ]);
}
