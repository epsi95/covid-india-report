import 'package:flutter/material.dart';
import 'pages/status_page.dart';
import 'pages/dashboard.dart';
import 'pages/dashboardV2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardV2(),
    );
  }
}
