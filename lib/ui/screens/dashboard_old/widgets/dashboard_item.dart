import 'package:flutter/material.dart';

class DashboardItem extends StatefulWidget {
  final String title;
  final String description;
  final void Function() onTap;

  const DashboardItem(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails _) => setState(() {
        hover = true;
      }),
      onTapUp: (TapUpDetails _) => setState(() {
        hover = false;
      }),
      onTapCancel: () => setState(() {
        hover = false;
      }),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        scale: !hover ? 1.0 : 1.02,
        child: Container(
          width: 300.0,
          height: 400.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(60, 149, 157, 165),
                    offset: Offset(0, 3),
                    blurRadius: 12)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 300.0,
                  height: 190.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    child: Image.asset(
                      "assets/images/dashboard_budgeting.png",
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(widget.title,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10.0),
              Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w300),
                  )),
              const SizedBox(height: 15.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Transform.rotate(
                    angle: 3.14,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black54,
                      size: 30.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
