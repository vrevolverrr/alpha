import 'dart:math';

import 'package:alpha/logic/stocks.dart';
import 'package:alpha/ui/screens/investments/widgets/line_graph_painter.dart';
import 'package:flutter/material.dart';

class StockGraph extends StatelessWidget {
  final double width;
  final double height;
  final Stock stock;

  static const _priceHistoryDuration = 20;

  final List<Point<double>> points =
      List.filled(StockGraph._priceHistoryDuration, const Point(0.0, 0.0));

  StockGraph(
      {super.key,
      required this.width,
      required this.height,
      required this.stock}) {
    /// Get last 10 prices of the stock
    final List<double> prices = stock.market.historicPrices.sublist(
        stock.market.historicPrices.length - StockGraph._priceHistoryDuration);

    /// Calculate scale
    final double dx = width / StockGraph._priceHistoryDuration;
    final double yMax = prices.reduce(max);
    final double yMin = prices.reduce(min);
    final double dy = height / (yMax - yMin);

    /// Scale the prices to fit the points
    for (int i = 0; i < prices.length; i++) {
      // Coordinate system (0, 0) at top left of canvas (height increases downwards)
      // y_scaled = distance between y to top of canvas (x, 0)
      //          = canvasHeight - (y - yMin) * dy
      // the height * factor term is to add some padding below the line
      final Point<double> point =
          Point(i * dx, height - (prices[i] - yMin) * dy - height * 0.15);
      points[i] = point;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: LineGraphPainter(points,
          color: stock.percentPriceChange() <= 0
              ? const Color(0xffE15353)
              : const Color(0xff3AB59E)),
    );
  }
}
