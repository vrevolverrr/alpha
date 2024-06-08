import 'package:alpha/logic/stocks.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_graph.dart';
import 'package:flutter/material.dart';

class StockMarketEntry extends StatelessWidget {
  final Stock stock;

  const StockMarketEntry({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return AlphaAnimatedContainer(
        width: 340.0,
        height: 152.0,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  stock.code,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 24.0),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${stock.percentPriceChange().toStringAsFixed(2)}%",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                      color: stock.percentPriceChange() <= 0
                          ? const Color(0xffE15353)
                          : const Color(0xff3AB59E)),
                ),
                const SizedBox(width: 5.0),
                Transform.translate(
                  offset: const Offset(0, -3.5),
                  child: Transform.rotate(
                    angle: stock.percentPriceChange() <= 0 ? -1.571 : 1.571,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: stock.percentPriceChange() <= 0
                          ? const Color(0xffE15353)
                          : const Color(0xff3AB59E),
                      size: 24.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: StockGraph(width: 100.0, height: 30.0, stock: stock),
                ))
              ],
            ),
            Text(
              stock.name,
              style: const TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 7.0),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Total Shares",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14.0),
                    ),
                    const SizedBox(height: 2.0),
                    SizedBox(
                      width: 170.0,
                      child: Text(
                        // TODO add own stocks
                        "\$${(stock.price * 10).toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Share Price",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14.0),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "\$${stock.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 25.0),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
