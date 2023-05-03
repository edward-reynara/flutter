import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                //padding: const EdgeInsets.only(top: 16.0),
                //child: const CircularProgressIndicator(),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightGreen,
                child: Center(
                  child: Image.network(
                    '',
                    width: 200.0,
                    height: 100.0,
                  ),
                ))));
  }
}
