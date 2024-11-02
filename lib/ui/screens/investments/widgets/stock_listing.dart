import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:alpha/ui/screens/investments/widgets/stock_graph.dart';
import 'package:flutter/material.dart';

class StockListing extends StatelessWidget {
  final Stock stock;
  final bool selected;

  const StockListing({super.key, required this.stock, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: !selected ? Offset.zero : const Offset(0.05, 0.0),
      curve: Curves.decelerate,
      duration: Durations.medium1,
      child: AlphaAnimatedContainer(
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
                    style: TextStyles.bold24,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    "${stock.percentPriceChange().toStringAsFixed(2)}%",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0,
                        color: stock.percentPriceChange() == 0
                            ? const Color(0xFF5B5B5B)
                            : (stock.percentPriceChange() < 0
                                ? const Color(0xffE15353)
                                : const Color(0xff3AB59E))),
                  ),
                  const SizedBox(width: 5.0),
                  RenderIfTrue(
                      condition: stock.percentPriceChange() != 0,
                      child: Transform.translate(
                        offset: const Offset(0, -3.5),
                        child: Transform.rotate(
                          angle:
                              stock.percentPriceChange() <= 0 ? -1.571 : 1.571,
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: stock.percentPriceChange() < 0
                                ? const Color(0xffE15353)
                                : const Color(0xff3AB59E),
                            size: 24.0,
                          ),
                        ),
                      )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: StockGraph(
                            width: 100.0, height: 30.0, stock: stock)),
                  ))
                ],
              ),
              Text(
                stock.name,
                style: TextStyles.medium15,
              ),
              const SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Total Shares",
                        style: TextStyles.bold14,
                      ),
                      const SizedBox(height: 2.0),
                      SizedBox(
                        width: 170.0,
                        child: Text(
                          // TODO add own stocks
                          "\$${(stock.price * 10).toStringAsFixed(2)}",
                          style: TextStyles.bold25,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Share Price",
                        style: TextStyles.bold14,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        "\$${stock.price.toStringAsFixed(2)}",
                        style: TextStyles.bold25,
                      )
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
