import 'dart:collection';
import 'dart:math';

import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/stocks.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Represents a player's account in the game. A player has a [SavingsAccount],
/// [InvestmentAccount], and [CPFAccount].
class Account extends ChangeNotifier {
  /// Interest rate in percent (%)
  final double interest;

  /// Remaining balance in the [Account]
  double _balance;
  double get balance => _balance;

  Account(double balance, {this.interest = 1.0}) : _balance = balance;

  /// Updates the balance after crediting the interest.
  void returnOnInterest() {
    _balance =
        double.parse((_balance * (1 + interest / 100)).toStringAsFixed(2));
  }

  /// Deducts the [amount] from the balance. Returns true if the deduction was successful.
  bool deduct(double amount) {
    if (_balance < amount) return false;

    _balance -= amount;
    notifyListeners();

    return true;
  }

  /// Adds the [amount] to the balance.
  void add(double amount) {
    _balance += amount;
    notifyListeners();
  }
}

/// THe Central Provident Fund (CPF) account of a player. The CPF account has a
/// high interest rate but its funds cannot be used to purchase things in the game.
/// This account is credited with 20% of the player's salary every round.
class CPFAccount extends Account {
  CPFAccount({double initial = 0.0}) : super(initial, interest: 12.0);
}

/// The savings account of a player. The savings account has a lower interest rate
/// but its funds can be used to purchase things in the game.
///
/// When salary is credited to the player, it is automatically added to the
/// unbudgeted portion of the account, after which the player will be prompted to
/// allocate the budget for different aspects of their life.
///
/// See [BudgetManager] for details on budget allocation.
class SavingsAccount extends Account {
  // The amount of money in the savings that is not allocated to any budget.
  double _unbudgeted = 0.0;

  SavingsAccount({double initial = 0.0}) : super(initial, interest: 2.5);

  double get unbudgeted => _unbudgeted;

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
  InvestmentAccount({double initial = 0.0}) : super(initial, interest: 4.5);

  final List<ShareOwnership> _shareOwnership = [];

  UnmodifiableListView<ShareOwnership> get shareOwnership =>
      UnmodifiableListView(_shareOwnership);

  /// Get the number of shares of a stock owned by the player.
  int getStockUnits(StockItem stockItem) {
    int count = 0;

    for (ShareOwnership share in shareOwnership) {
      if (share.item == stockItem) {
        count += share.units;
      }
    }

    return count;
  }

  /// Get the profit of a specific stock owned by the player.
  double getStockProfit(StockItem stockItem) {
    double profit = 0;

    for (ShareOwnership share in shareOwnership) {
      if (share.item == stockItem) {
        profit += marketManager.getStockPrice(stockItem) - share.buyinPrice;
      }
    }

    return profit;
  }

  /// Get the profit percentage of a stock owned by the player.
  double getStockProfitPercent(StockItem stockItem) {
    /// Total Buy In = Sum of (Buy In Price * Units)
    final double totalBuyIn = _shareOwnership
        .where((share) => share.item == stockItem)
        .fold(0, (prev, share) => prev + share.buyinPrice * share.units);

    /// Total Value Now = Sum of (Current Price * Units)
    final double totalValueNow = _shareOwnership
        .where((share) => share.item == stockItem)
        .fold(
            0,
            (prev, share) =>
                prev + share.units * marketManager.getStockPrice(share.item));

    /// Handle zero base value case
    if (totalBuyIn == 0) {
      if (totalValueNow > 0) return 100.0;
      if (totalValueNow < 0) return -100.0;
      return 0.0; // No change if both zero
    }

    final double percentChange = (totalValueNow / totalBuyIn - 1.0) * 100;

    /// Return in 2 d.p.
    return double.parse(percentChange.toStringAsFixed(2));
  }

  /// Purchase a number of shares of a stock.
  bool purchaseShare(Stock stock, int units) {
    final double totalPrice = stock.price * units;

    /// Return false if player does not have sufficient funds to purchase the shares.
    if (totalPrice > balance) return false;

    /// Deduct from investment account balance
    deduct(totalPrice);

    /// Register ownership of the shares
    _shareOwnership.add(ShareOwnership(
        round: gameManager.round,
        item: stock.item,
        units: units,
        buyinPrice: stock.price));

    notifyListeners();
    return true;
  }

  /// Sell a number of shares of a stock owned by the player.
  bool sellShare(Stock stock, int units) {
    /// Filter and sort shares by round bought in ascending order
    final List<ShareOwnership> sharesToSell = shareOwnership
        .where((share) => share.item == stock.item)
        .toList()
      ..sort((a, b) => a.round.compareTo(b.round));

    final int totalUnits =
        sharesToSell.fold(0, (prev, share) => prev + share.units);

    /// Player does not own enough units of the stock to sell
    if (totalUnits < units) return false;

    int remainingUnits = units;
    final currentSharePrice = marketManager.getStockPrice(stock.item);

    double totalProfit = 0.0;

    for (ShareOwnership share in sharesToSell) {
      /// All required units have been sold
      if (remainingUnits <= 0) break;

      final int unitsToSell = min(remainingUnits, share.units);
      final double salePrice = currentSharePrice * unitsToSell;

      share.units -= unitsToSell;
      remainingUnits -= unitsToSell;

      if (share.units == 0) {
        shareOwnership.remove(share);
      }

      totalProfit += salePrice;
    }

    /// Credit the player with the total profit from the sale
    acos(totalProfit);

    notifyListeners();
    return true;
  }

  /// Gets the total portfolio value of the player up to the nth round.
  double getPortfolioValue({int? nth}) {
    nth = (nth ?? gameManager.round).clamp(1, gameManager.round);

    return shareOwnership.where((share) => share.round <= nth!).fold(
        0,
        (prev, share) =>
            prev + share.units * marketManager.getStockPrice(share.item));
  }

  /// Gets the change in portfolio value from the [startNth] round to the [endNth] round.
  /// If no [startNth] is provided, the change from the last round is calculated.
  double getPortfolioValueChange({int? startNth, int? endNth}) {
    startNth = (startNth ?? 1).clamp(1, gameManager.round);
    endNth = (endNth ?? gameManager.round).clamp(1, gameManager.round);

    final double startValue = getPortfolioValue(nth: startNth);
    final double endValue = getPortfolioValue(nth: endNth);

    return endValue - startValue;
  }

  /// Gets the percentage change in portfolio value from the [startNth] round to the [endNth] round.
  /// If no startNth is provided, the change from the last round is calculated.
  double getPortfolioPercentChange({int? startNth, int? endNth}) {
    final double startValue = getPortfolioValue(nth: startNth);
    final double endValue = getPortfolioValue(nth: endNth);

    /// Handle zero base value case
    if (startValue == 0) {
      if (endValue > 0) return 100.0;
      if (endValue < 0) return -100.0;
      return 0.0; // No change if both zero
    }

    final double percentChange = (endValue - startValue) / startValue * 100;

    return double.parse(percentChange.toStringAsFixed(2));
  }

  /// Gets the total profit of the player's portfolio up to the [nth] round.
  double getPortfolioProfit({int? nth}) {
    nth = nth ?? gameManager.round;

    double profit = 0.0;

    for (ShareOwnership share in shareOwnership) {
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

  /// The price at which the player bought the stock.
  final double buyinPrice;

  /// The round in which the player bought the stock.
  final int round;

  /// The number of units of the stock that the player purchased.
  int units;

  ShareOwnership({
    required this.item,
    required this.round,
    required this.units,
    required this.buyinPrice,
  });
}

class PlayerAccount extends ChangeNotifier {
  final SavingsAccount savings = SavingsAccount();
  final CPFAccount cpf = CPFAccount();
  final InvestmentAccount investments = InvestmentAccount();

  double get availableBalance => savings.balance + investments.balance;

  double get totalBalance =>
      savings.balance + cpf.balance + investments.balance;

  PlayerAccount(
      {double savingsInitial = 0.0,
      double cpfInitial = 0.0,
      double investmentsInitial = 0.0}) {
    savings.add(savingsInitial);
    cpf.add(cpfInitial);
    investments.add(investmentsInitial);

    savings.addListener(() => notifyListeners());
    cpf.addListener(() => notifyListeners());
    investments.addListener(() => notifyListeners());
  }
}

class AccountsManager implements IManager {
  static const kCPFRate = 0.2;

  @override
  final Logger log = Logger("AccountManager");

  final Map<Player, PlayerAccount> _playerAccounts = {};

  void initialisePlayerAccounts(List<Player> players) {
    for (final player in players) {
      _playerAccounts[player] =
          PlayerAccount(savingsInitial: 4000, investmentsInitial: 1000);
    }
  }

  PlayerAccount getPlayerAccount(Player player) {
    return _playerAccounts[player]!;
  }

  InvestmentAccount getInvestmentAccount(Player player) {
    return getPlayerAccount(player).investments;
  }

  SavingsAccount getSavingsAccount(Player player) {
    return getPlayerAccount(player).savings;
  }

  double getAvailableBalance(Player player) {
    return getPlayerAccount(player).availableBalance;
  }

  double getUnbudgetedSavings(Player player) {
    return getPlayerAccount(player).savings.unbudgeted;
  }

  void clearUnbudgetedSavings(Player player) {
    getPlayerAccount(player).savings.clearUnbudgeted();
  }

  double getTotalBalance(Player player) {
    return getPlayerAccount(player).totalBalance;
  }

  void creditInterest() {
    for (final player in _playerAccounts.keys) {
      _playerAccounts[player]!.investments.returnOnInterest();
      _playerAccounts[player]!.cpf.returnOnInterest();
      _playerAccounts[player]!.savings.returnOnInterest();
    }
  }

  void creditToSavings(Player player, double amount) {
    getPlayerAccount(player).savings.add(amount);
    log.info("Credited $amount to player ${player.name}'s savings account.");
  }

  void creditToSavingsUnbudgeted(Player player, double amount) {
    getPlayerAccount(player).savings.addUnbudgeted(amount);
    log.info(
        "Credited unbudgeted $amount to player ${player.name}'s savings account.");
  }

  void creditToCPF(Player player, double amount) {
    getPlayerAccount(player).cpf.add(amount);
    log.info("Credited $amount to player ${player.name}'s CPF account.");
  }

  void creditToInvestments(Player player, double amount) {
    getPlayerAccount(player).investments.add(amount);
    log.info("Credited $amount to player ${player.name}'s investment account.");
  }

  void deductFromSavings(Player player, double amount) {
    PlayerAccount account = getPlayerAccount(player);

    if (account.savings.balance < amount) {
      log.warning(
          "Player ${player.name} does not have enough money in their savings account to deduct $amount, ignoring.");
      return;
    }

    account.savings.deduct(amount);
    log.info("Deducted $amount from player ${player.name}'s savings account.");
  }

  void deductFromInvestments(Player player, double amount) {
    PlayerAccount account = getPlayerAccount(player);

    if (account.investments.balance < amount) {
      log.warning(
          "Player ${player.name} does not have enough money in their investment account to deduct $amount, ignoring.");
      return;
    }

    account.investments.deduct(amount);
    log.info(
        "Deducted $amount from player ${player.name}'s investment account.");
  }

  void deductAny(Player player, double amount) {
    PlayerAccount account = getPlayerAccount(player);

    if (account.savings.balance + account.investments.balance < amount) {
      log.warning(
          "Player ${player.name} does not have enough money in their savings and investment account to deduct $amount, ignoring.");
      return;
    }

    if (account.savings.balance >= amount) {
      account.savings.deduct(amount);
      log.info(
          "Deducted $amount from player ${player.name}'s savings account.");
      return;
    }

    final double deductibleSavings = account.savings.balance;
    final double deductibleInvestments = amount - deductibleSavings;

    account.savings.deduct(deductibleSavings);
    account.investments.deduct(deductibleInvestments);

    log.info(
        "Deducted $deductibleSavings from player ${player.name}'s savings account and $deductibleInvestments from their investment account.");
  }
}
