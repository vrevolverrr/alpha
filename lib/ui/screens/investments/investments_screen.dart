import 'package:alpha/extensions.dart';
import 'package:alpha/logic/accounts_logic.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/hints_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_animations.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/investments/dialogs/landing_dialog.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_listing.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_graph.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_price_change.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_risk_label.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  int _stockUnits = 10;
  Stock _selectedStock = marketManager.stocks.first;

  bool _isUnitIncreaseButtonHeld = false;
  bool _isUnitDecreaseButtonHeld = false;

  final InvestmentAccount investments =
      accountsManager.getInvestmentAccount(activePlayer);

  void _handleBuyShare(BuildContext context) {
    if (_stockUnits <= 0) {
      context.showSnackbar(message: "Please select a valid number of units");
      return;
    }

    final double totalValue = _selectedStock.price * _stockUnits;

    if (investments.balance < totalValue) {
      context.showSnackbar(message: "Insufficient funds");
      return;
    }

    final AlphaDialogBuilder dialog = _buildConfirmBuyDialog(context, () {
      investments.purchaseShare(_selectedStock, _stockUnits);
      context.dismissDialog();
    });

    context.showDialog(dialog);
  }

  void _handleSellShare(BuildContext context) {
    if (_stockUnits <= 0) {
      context.showSnackbar(message: "Please select a valid number of units");
      return;
    }

    final int units = investments.getStockUnits(_selectedStock.item);

    if (units < _stockUnits) {
      context.showSnackbar(message: "Insufficient shares to sell");
      return;
    }

    final AlphaDialogBuilder dialog = _buildConfirmSellDialog(context, () {
      investments.sellShare(_selectedStock, _stockUnits);
      context.dismissDialog();
    });

    context.showDialog(dialog);
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Investments",
      landingDialog:
          (hintsManager.shouldShowHint(activePlayer, Hint.investment))
              ? AlphaDialogBuilder.dismissable(
                  title: "Welcome",
                  dismissText: "Start Investing",
                  width: 350.0,
                  child: const InvestmentsLandingDialog())
              : null,
      onTapBack: () => Navigator.of(context).pop(),
      children: <Widget>[
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildStockMarketColumn(),
            _buildInvestmentDetailsColumn(context),
          ],
        ),
      ],
    );
  }

  Widget _buildStockMarketColumn() {
    return Column(
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
                          onTap: () => setState(() => _selectedStock = stock),
                          child: StockListing(
                            stock: stock,
                            selected: _selectedStock == stock,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentDetailsColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildStockDetailsContainer(),
            const SizedBox(width: 30.0),
            _buildInvestmentAccountContainer(),
          ],
        ),
        const SizedBox(height: 25.0),
        _buildTransactionControls(context),
      ],
    );
  }

  Widget _buildStockDetailsContainer() {
    return AlphaContainer(
      width: 410.0,
      height: 450.0,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
                change: _selectedStock.percentPriceChange(),
              ),
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
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              StockRiskLabel(risk: _selectedStock.risk),
              const SizedBox(width: 8.0),
              _ESGLabel(esgRating: _selectedStock.esgRating),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              _GenericTitleValue(
                title: "Share Price",
                value: _selectedStock.price.prettyCurrency,
                width: 120.0,
              ),
              ListenableBuilder(
                listenable: investments,
                builder: (context, _) => _GenericTitleValue(
                  title: "Shares Owned",
                  value: (() {
                    final owned =
                        investments.getStockUnits(_selectedStock.item);

                    return "${(owned * _selectedStock.price).prettyCurrency} ($owned)";
                  })(),
                  width: 240.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 45.0),
          Center(
            child: LargeStockGraph(
              width: 350.0,
              height: 200.0,
              stock: _selectedStock,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentAccountContainer() {
    return AlphaContainer(
      width: 310.0,
      height: 450.0,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Investment Account",
            style: TextStyles.bold20,
          ),
          ListenableBuilder(
            listenable: investments,
            builder: (context, child) => AnimatedNumber(
              investments.balance,
              style: TextStyles.bold30,
              formatCurrency: true,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Portfolio Value",
            style: TextStyles.bold20,
          ),
          const SizedBox(height: 2.0),
          ListenableBuilder(
              listenable: investments,
              builder: (builder, _) => AnimatedNumber(
                    investments.getPortfolioValue(),
                    style: TextStyles.bold30,
                    formatCurrency: true,
                  )),
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
              Text(
                "${investments.getPortfolioProfitChange(startNth: 1).prettyCurrency} "
                "(${investments.getPortfolioProfitPercentChange(startNth: 1)}%)",
                style: const TextStyle(
                  color: Color(0xff3AB59E),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
              child: ListenableBuilder(
                  listenable: investments,
                  builder: (context, _) => _PortfolioTable(investments))),
        ],
      ),
    );
  }

  /// TODO REFACTOR THIS WIDGET OUT AND INTRODUCE A CONTROLLER
  /// TODO make it faster the longer it is held
  Widget _buildTransactionControls(BuildContext context) {
    return AlphaContainer(
      width: 750.0,
      height: 200.0,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
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
                ),
              ),
              const SizedBox(height: 5.0),
              AlphaContainer(
                width: 260.0,
                height: 70.0,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                shadowOffset: const Offset(0.5, 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTapDown: (_) => Future.doWhile(() {
                        if (_stockUnits <= 0) return false;

                        setState(() {
                          _stockUnits--;
                          _isUnitDecreaseButtonHeld = true;
                        });

                        return Future.delayed(const Duration(milliseconds: 100))
                            .then((_) => _isUnitDecreaseButtonHeld);
                      }),
                      onTapUp: (_) =>
                          setState(() => _isUnitDecreaseButtonHeld = false),
                      onTapCancel: () =>
                          setState(() => _isUnitDecreaseButtonHeld = false),
                      child: const Icon(Icons.remove),
                    ),
                    Text(
                      "${_stockUnits.toString()} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 40.0,
                        height: 1.75,
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) => Future.doWhile(() {
                        setState(() {
                          _stockUnits++;
                          _isUnitIncreaseButtonHeld = true;
                        });

                        return Future.delayed(const Duration(milliseconds: 100))
                            .then((_) => _isUnitIncreaseButtonHeld);
                      }),
                      onTapUp: (_) =>
                          setState(() => _isUnitIncreaseButtonHeld = false),
                      onTapCancel: () =>
                          setState(() => _isUnitIncreaseButtonHeld = false),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Total Value",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: AnimatedNumber(
                  _selectedStock.price * _stockUnits,
                  formatCurrency: true,
                  style: TextStyles.bold40,
                ),
              ),
              const SizedBox(height: 2.0),
              Builder(
                builder: (context) => Row(
                  children: <Widget>[
                    AlphaButton(
                      width: 180.0,
                      height: 60.0,
                      title: "Buy",
                      icon: Icons.shopping_cart_outlined,
                      color: const Color(0xff96DE9D),
                      onTap: () => _handleBuyShare(context),
                    ),
                    const SizedBox(width: 20.0),
                    AlphaButton(
                      width: 180.0,
                      height: 60.0,
                      title: "Sell",
                      icon: Icons.close,
                      color: const Color(0xffFF6B6B),
                      onTap: () => _handleSellShare(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AlphaDialogBuilder _buildConfirmBuyDialog(
      BuildContext context, void Function() onTapConfirm) {
    return AlphaDialogBuilder(
      title: "Confirm Purchase",
      child: Column(
        children: <Widget>[
          const Text(
            "Are you sure you want to buy?",
            style: TextStyles.bold24,
          ),
          const SizedBox(height: 10.0),
          Text(
            "${_stockUnits.toString()} units of ${_selectedStock.name} stock for",
            style: TextStyles.bold22,
          ),
          const SizedBox(height: 10.0),
          Text(
            (_stockUnits * _selectedStock.price).prettyCurrency,
            style: const TextStyle(
              color: Color(0xFFDF3737),
              fontSize: 48.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
      cancel: DialogButtonData.cancel(context),
      next: DialogButtonData.confirm(onTap: onTapConfirm),
    );
  }

  AlphaDialogBuilder _buildConfirmSellDialog(
      BuildContext context, void Function() onTapConfirm) {
    return AlphaDialogBuilder(
      title: "Confirm Sell",
      child: Column(
        children: <Widget>[
          const Text(
            "Are you sure you want to sell?",
            style: TextStyles.bold24,
          ),
          const SizedBox(height: 10.0),
          Text(
            "${_stockUnits.toString()} units of ${_selectedStock.name} stock for",
            style: TextStyles.bold22,
          ),
          const SizedBox(height: 10.0),
          Text(
            (_stockUnits * _selectedStock.price).prettyCurrency,
            style: const TextStyle(
              color: Color.fromARGB(255, 59, 182, 43),
              fontSize: 48.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
      cancel: DialogButtonData.cancel(context),
      next: DialogButtonData.confirm(onTap: onTapConfirm),
    );
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

// A table that displays the player's portfolio, listing each stock on the market,
//and the number of shares owned, with the total value.
class _PortfolioTable extends StatelessWidget {
  final InvestmentAccount investments;

  const _PortfolioTable(this.investments);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black, width: 2.0),
        columnWidths: const {
          0: FixedColumnWidth(53.0),
          1: FixedColumnWidth(85.0),
          2: FixedColumnWidth(60.0),
          3: FixedColumnWidth(68.0),
        },
        children: <TableRow>[
          _buildTableHeader(),
          ...marketManager.stocks.map((stock) {
            final int units = investments.getStockUnits(stock.item);

            final double totalValue = stock.price * units;

            return _buildTableRow(
                stock.code,
                totalValue.prettyCurrency,
                units.toString(),
                investments.getStockProfitPercent(stock.item));
          })
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
        child: Text(value, style: TextStyles.medium15)),
    Padding(
        padding:
            const EdgeInsets.only(top: 3.0, bottom: 2.0, left: 5.0, right: 5.0),
        child: Text(units, style: TextStyles.medium15)),
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
