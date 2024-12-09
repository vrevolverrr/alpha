import 'package:alpha/logic/data/stocks.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/services.dart';
import 'package:flutter/foundation.dart';

class Account extends ChangeNotifier {
  /// Interest rate in percent (%)
  final double interest;

  /// Remaining balance in the [Account]
  double _balance;

  Account(double balance, {this.interest = 1.0}) : _balance = balance;

  double get balance => _balance;
  String get sBalance => _balance.toStringAsFixed(2);

  void returnOnInterest() {
    _balance =
        double.parse((_balance * (1 + interest / 100)).toStringAsFixed(2));
  }

  bool deduct(double amount) {
    if (_balance < amount) return false;

    _balance -= amount;
    notifyListeners();
    return true;
  }

  void add(double amount) {
    _balance += amount;
    notifyListeners();
  }
}

class SavingsAccount extends Account {
  // The amount of money in the savings that is not allocated to any budget.
  double _unbudgeted = 0.0;

  SavingsAccount({double initial = 0.0}) : super(initial, interest: 2.5);

  double get unbudgeted => _unbudgeted;
  String get sUnbudgeted => _unbudgeted.toStringAsFixed(2);

  void addUnbudgeted(double amount) {
    add(amount);
    _unbudgeted += amount;
    notifyListeners();
  }

  void clearUnbudgeted() {
    _unbudgeted = 0.0;
    notifyListeners();
  }
}

class InvestmentAccount extends Account {
  final List<ShareOwnership> sharesOwned = [];

  InvestmentAccount({double initial = 0.0}) : super(initial, interest: 4.5);

  /// Get the number of shares of a stock owned by the player.
  int getStockUnits(StockItem stockItem) {
    int count = 0;

    for (ShareOwnership share in sharesOwned) {
      if (share.item == stockItem) {
        count += share.units;
      }
    }

    return count;
  }

  /// Get the profit of a stock owned by the player.
  double getStockProfit(StockItem stockItem) {
    double profit = 0;

    for (ShareOwnership share in sharesOwned) {
      if (share.item == stockItem) {
        profit += marketManager.getStockPrice(stockItem) - share.buyinPrice;
      }
    }

    return profit;
  }

  /// Get the profit percentage of a stock owned by the player.
  double getStockProfitPercent(StockItem stockItem) {
    double profitPercent = 0;

    for (ShareOwnership share in sharesOwned) {
      if (share.item == stockItem) {
        profitPercent +=
            (marketManager.getStockPrice(stockItem) - share.buyinPrice) /
                share.buyinPrice *
                100;
      }
    }

    return double.parse(profitPercent.toStringAsFixed(2));
  }

  /// Purchase a number of shares of a stock.
  bool purchaseShare(Stock stock, int units) {
    final double totalPrice = stock.price * units;
    final bool status = deduct(totalPrice);

    if (!status) return false;

    sharesOwned.add(ShareOwnership(
        round: gameManager.round,
        item: stock.item,
        units: units,
        buyinPrice: stock.price));

    notifyListeners();
    return status;
  }

  /// Sell a number of shares of a stock owned by the player.
  bool sellShare(Stock stock, int units) {
    /// Count number of shares of the stock owned by the player.
    int owned = 0;

    for (ShareOwnership share in sharesOwned) {
      if (share.item == stock.item) {
        owned += share.units;
      }
    }

    /// Player does not own enough units of the stock to sell
    if (owned < units) return false;

    while (units > 0) {
      for (ShareOwnership share in sharesOwned) {
        if (share.item == stock.item) {
          if (share.units >= units) {
            final double totalPrice = stock.price * units;
            add(totalPrice);
            share.units -= units;
            units = 0;
          } else {
            final double totalPrice = stock.price * share.units;
            add(totalPrice);
            units -= share.units;
            share.units = 0;
          }
        }
      }
    }

    notifyListeners();
    return true;
  }

  /// Gets the total portfolio value of the player up to the nth round.
  double getPortfolioValue({int? nth}) {
    double total = 0.0;

    nth = nth ?? gameManager.round;
    nth = nth.clamp(1, gameManager.round);

    for (ShareOwnership share in sharesOwned) {
      /// Skip shares that were bought after the nth round
      if (share.round > nth) continue;

      total += share.units * marketManager.getStockPrice(share.item, nth: nth);
    }

    return total;
  }

  /// Gets the change in portfolio value from the startNth round to the endNth round.
  /// If no startNth is provided, the change from the last round is calculated.
  double getPortfolioValueChange({int? startNth, int? endNth}) {
    startNth = startNth ?? gameManager.round - 1;
    endNth = endNth ?? gameManager.round;

    final double startValue = getPortfolioValue(nth: startNth);
    final double endValue = getPortfolioValue(nth: endNth);

    return endValue - startValue;
  }

  /// Gets the percentage change in portfolio value from the [startNth] round to the [endNth] round.
  /// If no startNth is provided, the change from the last round is calculated.
  double getPortfolioPercentChange({int? startNth, int? endNth}) {
    startNth = startNth ?? gameManager.round - 1;
    endNth = endNth ?? gameManager.round;

    final double startValue = getPortfolioValue(nth: startNth);
    final double endValue = getPortfolioValue(nth: endNth);

    if (startValue == 0) return 0.0;

    final double percentChange = (endValue - startValue) / startValue * 100;

    return double.parse(percentChange.toStringAsFixed(2));
  }

  /// Gets the total profit of the player's portfolio up to the [nth] round.
  double getPortfolioProfit({int? nth}) {
    nth = nth ?? gameManager.round;

    double profit = 0.0;

    for (ShareOwnership share in sharesOwned) {
      if (share.round > nth) continue;

      profit += (marketManager.getStockPrice(share.item, nth: nth) -
              share.buyinPrice) *
          share.units;
    }

    return profit;
  }

  /// Gets the total profit of the player's portfolio from [startNth] to [endNth] round.
  double getPortfolioProfitChange({int? startNth, int? endNth}) {
    startNth = startNth ?? gameManager.round - 1;
    endNth = endNth ?? gameManager.round;

    final double startProfit = getPortfolioProfit(nth: startNth);
    final double endProfit = getPortfolioProfit(nth: endNth);

    return endProfit - startProfit;
  }

  double getPortfolioProfitPercentChange({int? startNth, int? endNth}) {
    startNth = startNth ?? gameManager.round - 1;
    endNth = endNth ?? gameManager.round;

    final double startProfit = getPortfolioProfit(nth: startNth);
    final double endProfit = getPortfolioProfit(nth: endNth);

    if (startProfit == 0) return 0.0;

    final double percentChange = (endProfit - startProfit) / startProfit * 100;

    return double.parse(percentChange.toStringAsFixed(2));
  }
}

/// Represents the ownership of a stock by a player. Each time the player purchases a share,
/// a new instance of [ShareOwnership] is created and added to the [InvestmentAccount].
class ShareOwnership {
  /// The stock item that the player purchased.
  final StockItem item;

  /// The number of units of the stock that the player purchased.
  int units;

  /// The price at which the player bought the stock.
  double buyinPrice;

  /// The round in which the player bought the stock.
  int round;

  ShareOwnership({
    required this.item,
    required this.round,
    this.units = 0,
    this.buyinPrice = 0.0,
  });
}
