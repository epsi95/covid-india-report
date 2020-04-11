import 'package:flutter/material.dart';
import 'status_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardV2 extends StatefulWidget {
  @override
  _DashboardV2State createState() => _DashboardV2State();
}

class _DashboardV2State extends State<DashboardV2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _sendMail() async {
    // Android and iOS
    const uri =
        'mailto:probhakar.95@gmail.com?subject=COVID-INDIA-REPORT BUG REPORT&body=Hi,';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
//      throw 'Could not launch $uri';
      showSnackBar("Could not launch Gmail");
    }
  }

  void showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF6200EE),
          title: Text(
            'C-19 INDIA REPORT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 21.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              tooltip: 'report bug',
              onPressed: () {
                showSnackBar("Send bug report");
                _sendMail();
              },
              icon: Icon(
                Icons.bug_report,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: StatusPage(),
      ),
    );
  }
}
