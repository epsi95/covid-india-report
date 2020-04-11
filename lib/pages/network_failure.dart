import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NetworkFailure extends StatefulWidget {
  final callBackFn;

  NetworkFailure({this.callBackFn});
  @override
  _NetworkFailureState createState() => _NetworkFailureState();
}

class _NetworkFailureState extends State<NetworkFailure> {
  Function _callBackfn;

  @override
  void initState() {
    _callBackfn = widget.callBackFn;
    super.initState();
  }

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
                child: Lottie.asset('assets/11645-no-internet-animation.json'),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "oops..",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.0,
              ),
              RaisedButton(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  _callBackfn();
                },
                child: Text(
                  "RETRY",
                  style: TextStyle(
                      color: Color(0xFF6200EE),
                      fontSize: 26,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
