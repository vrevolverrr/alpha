import 'package:alpha/model/player.dart';
import 'package:flutter/material.dart';

class BudgetGraph extends StatefulWidget {
  final Player player;
  const BudgetGraph({super.key, required this.player});

  @override
  State<StatefulWidget> createState() => _BudgetGraphState();
}

class _BudgetGraphState extends State<BudgetGraph> {
  late final Map<String, double> budgets;

  @override
  void initState() {
    budgets = widget.player.getBudgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        const SizedBox(height: 40.0),
        FilledButton(
            onPressed: () => {
                  setState(() {
                    widget.player.updateBudgets("Savings", 0.5);
                  })
                },
            child: const Text("Hello"))
      ],
    );
  }
}
