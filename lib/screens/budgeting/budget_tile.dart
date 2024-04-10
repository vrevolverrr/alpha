import 'package:flutter/material.dart';

class BudgetingTile extends StatefulWidget {
  final Color color;
  final String title;
  final double initial;
  final Function updateCallback;

  const BudgetingTile(
      {super.key,
      required this.color,
      required this.title,
      required this.initial,
      required this.updateCallback});

  @override
  State<StatefulWidget> createState() => _BudgetingTileState();
}

class _BudgetingTileState extends State<BudgetingTile> {
  late double fillPercent;
  bool hover = false;

  @override
  void initState() {
    fillPercent = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 80),
      scale: !hover ? 1.0 : 1.05,
      child: Listener(
        onPointerMove: (event) => setState(() {
          double percentDelta = event.delta.dy / 400;

          if (fillPercent + percentDelta >= 1.0) {
            fillPercent = 1.0;
          } else if (fillPercent + percentDelta <= 0.0) {
            fillPercent = 0.0;
          } else {
            fillPercent += percentDelta;
          }
        }),
        onPointerDown: (event) => {
          setState(() {
            hover = true;
          })
        },
        onPointerUp: (event) =>
            {setState(() => hover = false), widget.updateCallback(fillPercent)},
        onPointerCancel: (event) => {
          setState(() {
            hover = false;
          })
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color(0xffe86d64),
                Color(0xffe86d64),
                Color(0xffff968f),
                Color(0xffff968f)
              ], stops: [
                0.0,
                1 - fillPercent,
                1 - fillPercent,
                1.0
              ], end: Alignment.topCenter, begin: Alignment.bottomCenter),
              borderRadius: const BorderRadius.all(Radius.circular(18.0))),
          width: 200.0,
          height: 250.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  "${((1 - fillPercent) * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                      fontSize: 55.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
