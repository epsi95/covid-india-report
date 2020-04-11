import 'package:flutter/material.dart';

class BottomRibbon extends StatefulWidget {
  final stateData;
  BottomRibbon({this.stateData});
  @override
  _BottomRibbonState createState() => _BottomRibbonState();
}

class _BottomRibbonState extends State<BottomRibbon> {
  var _stateData;
  List<Widget> rows = [];

  @override
  void initState() {
    _stateData = widget.stateData;
    List<Widget> children = [];
    int totalcase = 0;
    _stateData.forEach((stateName, details) {
      children.clear();
      totalcase = 0;
      for (List<dynamic> each in details) {
        totalcase += each[1];
        children.add(
          Container(
            height: 200.0,
            width: 200.0,
            padding: EdgeInsets.all(20.0),
            color: Color(0xFFDBB2FF),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  each[0],
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Total Confirmed",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  each[1].toString(),
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        );
      }
      children.insert(
        0,
        Container(
          height: 200.0,
          width: 200.0,
          padding: EdgeInsets.all(20.0),
          color: Color(0xFF6200EE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                stateName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Total Confirmed",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                totalcase.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      );
      rows.add(SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.from(children),
        ),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rows.add(Container(
      height: 100,
      color: Color(0xFF6200EE),
    ));
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    );
  }
}
