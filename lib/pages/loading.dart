import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xFF6200EE),
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  height: 400.0,
                  width: 400.0,
                  child: Lottie.asset(
                      'assets/18289-stay-home-stay-safe-red.json')),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Loading data from https://api.covid19india.org/ ...",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
