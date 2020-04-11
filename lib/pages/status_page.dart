import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_india_report/components/status_card.dart';
import 'package:covid_india_report/utils/network_data_fetch.dart';
import 'package:covid_india_report/components/bottom_ribbon.dart';
import 'loading.dart';
import 'network_failure.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("during build");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<dynamic>(
      future: getAllIndiaData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          if (snapshot.hasError)
            return NetworkFailure(
              callBackFn: refresh,
            );
          else
            return Center(
                child: (snapshot.data)[0] == "Error"
                    ? NetworkFailure(callBackFn: refresh)
                    : Details(
                        width: width,
                        callBackFn: refresh,
                        dataAll: snapshot
                            .data)); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );

//      Details(width: width, data: data);
  }
}

class Details extends StatelessWidget {
  const Details({
    @required this.width,
    @required this.dataAll,
    @required this.callBackFn,
  });

  final double width;
  final dataAll;
  final callBackFn;

  @override
  Widget build(BuildContext context) {
    var data = dataAll[0];
    var stateData = dataAll[1];
//    print(stateData);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          callBackFn();
        },
        label: Text(data[data.length - 1]),
        backgroundColor: Color(0xFF6200EE),
        icon: Icon(Icons.refresh),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    StatusCard(
                      cardHeight: 200.0,
                      cardWidth: (width - 8) / 2,
                      text: "CONFIRMED",
                      color: Color(0xFFFF4C71),
                      data: data[0],
                      numberOf: data[4].toString(),
                      delta: data[8],
                    ),
                    StatusCard(
                      cardHeight: 200.0,
                      cardWidth: (width - 8) / 2,
                      text: "ACTIVE",
                      color: Color(0xFF53A5FF),
                      data: data[1],
                      numberOf: data[5].toString(),
                      delta: data[9],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    StatusCard(
                      cardHeight: 200.0,
                      cardWidth: (width - 8) / 2,
                      text: "RECOVERED",
                      color: Color(0xFF2DA94A),
                      data: data[2],
                      numberOf: data[6].toString(),
                      delta: data[10],
                    ),
                    StatusCard(
                      cardHeight: 200.0,
                      cardWidth: (width - 8) / 2,
                      text: "DECEASED",
                      color: Color(0xFF6D767E),
                      data: data[3],
                      numberOf: data[7].toString(),
                      delta: data[11],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: BottomRibbon(
            stateData: stateData,
          ))
        ],
      ),
    );
  }
}
