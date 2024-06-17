import 'package:alpha/logic/financial_market_logic.dart';
import 'package:flutter/foundation.dart';

class Account extends ChangeNotifier {
  double _balance;

  Account(double balance) : _balance = balance;

  double get balance => _balance;
  String get sBalance => _balance.toStringAsFixed(2);

  bool credit(double amount) {
    if (_balance < amount) return false;

    _balance -= amount;
    notifyListeners();
    return true;
  }

  void debit(double amount) {
    _balance += amount;
    notifyListeners();
  }
}

class SavingsAccount extends Account {
  SavingsAccount({double initial = 0.0}) : super(initial);
}

class InvestmentAccount extends Account {
  final Map<String, int> shares;

  InvestmentAccount(
      {double initial = 0.0, Map<String, int> ownedShares = const {}})
      : shares = ownedShares,
        super(initial);

  bool purchaseShare(Stock stock, int units) {
    final double totalPrice = stock.price * units;
    final bool status = credit(totalPrice);

    if (status) {
      /// Add to stock count if present else set as `units`
      shares.update(stock.code, (owned) => owned + units,
          ifAbsent: () => units);
    }

    // true if enough cash in investment account to purchase else false
    notifyListeners();
    return status;
  }

  bool sellShare(Stock stock, int units) {
    final int ownedUnits = shares[stock.code] ?? 0;

    if (ownedUnits < units) {
      /// Player does not have sufficient units to sell.
      return false;
    }

    final double totalPrice = stock.price * units;
    debit(totalPrice);
    notifyListeners();
    return true;
  }
}
