import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_animations.dart';
import 'package:flutter/material.dart';

class DashboardPlayerStatCard<T extends num> extends StatelessWidget {
  final String title;
  final String emoji;
  final T value;
  final double valueWidth;
  final Color? valueColor;
  final bool isCurrency;

  const DashboardPlayerStatCard(
      {super.key,
      required this.emoji,
      required this.title,
      required this.value,
      this.valueWidth = 135.0,
      this.valueColor,
      this.isCurrency = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: Colors.black, width: 3.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(emoji, style: TextStyles.black18),
          const SizedBox(width: 5.0),
          Text(title, style: TextStyles.bold16),
          const SizedBox(width: 6.0),
          SizedBox(
            width: valueWidth,
            height: 22.0,
            child: AnimatedNumber<T>(
              value,
              formatCurrency: isCurrency,
              duration: Durations.long1,
              delay: Durations.medium2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? const Color(0xff00734A),
                  fontSize: 18.0),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}

class DashboardExpandablePlayerStatCard<T extends num> extends StatefulWidget {
  const DashboardExpandablePlayerStatCard({super.key});

  @override
  State<StatefulWidget> createState() =>
      _DashboardExpandablePlayerStatCardState<T>();
}

class _DashboardExpandablePlayerStatCardState<T extends num>
    extends State<DashboardExpandablePlayerStatCard> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
