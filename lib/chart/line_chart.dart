import 'corona_events.dart';
import 'package:flutter/material.dart';
import 'package:covid_india_report/sample_data/sample_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChartCorona extends StatefulWidget {
  final Map<String, int> data;
  final Color color;
  final double chartHeight;
  final double chartWidth;

  LineChartCorona(
      {this.data = kConfirmedCoronaData,
      this.color = Colors.blueAccent,
      this.chartHeight,
      this.chartWidth});

  @override
  _LineChartCoronaState createState() => _LineChartCoronaState();
}

class _LineChartCoronaState extends State<LineChartCorona> {
  Color _color;
  Map<String, int> _coronaData;
  List<CoronaEvents> _data = [];
  double _chartHeight;
  double _chartWidth;
  var _series;

  @override
  void initState() {
    _color = widget.color;
    _chartHeight = widget.chartHeight;
    _chartWidth = widget.chartWidth;
    _coronaData = widget.data;
//    int index = 0;
//    _coronaData.forEach((k, v) {
//      _data.add(CoronaEvents(index, v));
//      index++;
//    });
//    _series = [
//      charts.Series(
//        id: 'coronaEvents',
//        domainFn: (CoronaEvents coronaData, _) => coronaData.dateOfReport,
//        measureFn: (CoronaEvents coronaData, _) => coronaData.numberOfCase,
//        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//        data: _data,
//      )
//    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _data.clear();
    int index = 0;
    _coronaData.forEach((k, v) {
      _data.add(CoronaEvents(index, v));
      index++;
    });
    _series = [
      charts.Series(
        id: 'coronaEvents',
        domainFn: (CoronaEvents coronaData, _) => coronaData.dateOfReport,
        measureFn: (CoronaEvents coronaData, _) => coronaData.numberOfCase,
        colorFn: (_, __) => charts.Color(
            r: _color.red, g: _color.green, b: _color.blue, a: _color.alpha),
        data: _data,
      )
    ];
    var _chart = charts.LineChart(
      _series,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includePoints: false),
      animationDuration: Duration(seconds: 2),
      // hide x axis
      domainAxis: charts.NumericAxisSpec(
          showAxisLine: false, renderSpec: charts.NoneRenderSpec()),
      // hide y axis
//      primaryMeasureAxis:
//          charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: SizedBox(height: _chartHeight, width: _chartWidth, child: _chart),
    );
  }
}
