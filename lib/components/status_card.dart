import 'package:flutter/material.dart';
import 'dart:math';
import 'package:covid_india_report/chart/line_chart.dart';

class StatusCard extends StatefulWidget {
  final double cardHeight;
  final double cardWidth;
  final Color color;
  final String text;
  final String numberOf;
  final Map<String, int> data;
  final String delta;

  StatusCard(
      {this.cardHeight,
      this.cardWidth,
      this.color = Colors.redAccent,
      this.text = "CONFIRMED",
      this.numberOf = "5822",
      this.data,
      this.delta});

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  double _cardWidth;
  double _cardHeight;
  double _varCardWidth;
  double _varCardHeight;
  Color _color;
  String _text;
  String _numberOf;
  Map<String, int> _data;
  String _delta;

  @override
  void initState() {
    _cardWidth = widget.cardWidth;
    _cardHeight = widget.cardHeight;
    _varCardWidth = widget.cardWidth;
    _varCardHeight = widget.cardHeight;
    _color = widget.color;
    _text = widget.text;
    _numberOf = widget.numberOf;
    _delta = widget.delta;
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _cardHeight,
      width: _cardWidth,
      child: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (_) {
            print("pan start");
            setState(() {
              _varCardHeight = _cardHeight * 0.98;
              _varCardWidth = _cardWidth * 0.98;
            });
          },
          onPanEnd: (_) {
            print("pan end");
            setState(() {
              _varCardHeight = _cardHeight;
              _varCardWidth = _cardWidth;
            });
          },
          child: AnimatedContainer(
            height: _varCardHeight,
            width: _varCardWidth,
            alignment: Alignment.center,
            duration: Duration(seconds: 1),
            curve: Curves.elasticOut,
            child: Card(
              elevation: 5.0,
              child: Container(
                height: _varCardHeight,
                width: _varCardWidth,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      _text,
                      style: TextStyle(
                        color: _color.withOpacity(0.7),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _delta,
                      style: TextStyle(
                        color: _color.withOpacity(0.7),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      _numberOf,
                      style: TextStyle(
                        color: _color,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    LineChartCorona(
                      chartHeight: 80,
                      chartWidth: _cardWidth - 20,
                      data: _data,
                      color: _color,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
