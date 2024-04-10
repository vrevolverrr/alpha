import 'package:alpha/screens/budgeting/budget_tile.dart';
import 'package:alpha/model/player.dart';
import 'package:flutter/material.dart';

class BudgetingScreen extends StatefulWidget {
  final Player player;

  const BudgetingScreen({super.key, required this.player});

  @override
  State<BudgetingScreen> createState() => _BudgetingScreenState();
}

class _BudgetingScreenState extends State<BudgetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
            size: 28.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("💰 Monthly Budget",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20.0),
          Text(
            "Take-Home Pay (\$${widget.player.salary.toStringAsFixed(2)}) minus Financial Commitments (\$${widget.player.commitments.toStringAsFixed(2)})",
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15.0),
          Text(
            "💵 ${widget.player.savings.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 20.0),
              BudgetingTile(
                title: "Savings",
                initial: widget.player.getBudgets()["Savings"]!,
                color: Colors.red,
                updateCallback: (percentage) =>
                    widget.player.updateBudgets("Savings", percentage),
              ),
              BudgetingTile(
                title: "Investments",
                initial: widget.player.getBudgets()["Investment"]!,
                color: Colors.red,
                updateCallback: (percentage) =>
                    widget.player.updateBudgets("Investment", percentage),
              ),
              BudgetingTile(
                title: "Daily Expenses",
                initial: widget.player.getBudgets()["Daily Expenses"]!,
                color: Colors.red,
                updateCallback: (percentage) =>
                    widget.player.updateBudgets("Daily Expenses", percentage),
              ),
              BudgetingTile(
                title: "Recreational",
                initial: widget.player.getBudgets()["Recreational"]!,
                color: Colors.red,
                updateCallback: (percentage) =>
                    widget.player.updateBudgets("Recreational", percentage),
              ),
              BudgetingTile(
                title: "Self Improvement",
                initial: widget.player.getBudgets()["Self Improvement"]!,
                color: Colors.red,
                updateCallback: (percentage) =>
                    widget.player.updateBudgets("Self Improvement", percentage),
              ),
              const SizedBox(width: 20.0),
            ],
          ),
          const SizedBox(height: 50.0)
        ],
      ),
    );
  }
}
