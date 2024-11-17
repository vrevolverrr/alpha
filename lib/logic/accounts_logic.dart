import 'package:alpha/logic/data/stocks.dart';
import 'package:alpha/logic/financial_market_logic.dart';
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
  late final Map<StockItem, ShareOwnership> shares;

  InvestmentAccount({double initial = 0.0}) : super(initial, interest: 4.5) {
    shares = {};

    for (var item in StockItem.values) {
      shares[item] = ShareOwnership(item: item);
    }
  }

  bool purchaseShare(Stock stock, int units) {
    final double totalPrice = stock.price * units;
    final bool status = deduct(totalPrice);

    if (status) {
      if (shares.keys.contains(stock.item)) {
        shares[stock.item]!.units += units;
      } else {
        shares[stock.item] = ShareOwnership(item: stock.item, units: units);
      }
    }

    // true if enough cash in investment account to purchase else false
    notifyListeners();
    return status;
  }

  bool sellShare(Stock stock, int units) {
    if (!shares.keys.contains(stock.item)) {
      /// Player does not own any units of the stock.
      shares[stock.item] = ShareOwnership(item: stock.item, units: 0);
      return false;
    }

    final int ownedUnits = shares[stock.item]!.units;

    if (ownedUnits < units) {
      /// Player does not have sufficient units to sell.
      return false;
    }

    final double totalPrice = stock.price * units;
    add(totalPrice);
    shares[stock.item]!.units -= units;

    notifyListeners();
    return true;
  }
}

class ShareOwnership {
  final StockItem item;
  int units;
  double buyinPrice;

  ShareOwnership({required this.item, this.units = 0, this.buyinPrice = 0.0});
}
