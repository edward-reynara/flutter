import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/signin/authentication/bloc/authentication_bloc.dart';
import '../../feature/signin/authentication/bloc/authentication_event.dart';
import '../helper/restart_app.dart';
import '../navigation/routes.dart';

class AlertWidget extends StatefulWidget {
  @override
  _AlertWidget createState() => _AlertWidget();
}

class _AlertWidget extends State<AlertWidget> {
  @override
  void initState() {
    super.initState();
    Timer.run(() => _showDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(" ",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16)));
  }

  void _showDialog() {
    final ButtonStyle style = OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Theme.of(context).primaryColor);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: new Text("Info"),
              content: new Text(
                  "Your session is expired. Please login to continue."),
              actions: <Widget>[
                new ElevatedButton(
                  style: style,
                  child: new Text("OK"),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.logout, (Route<dynamic> route) => false);
                    RestartWidget.restartApp(context);
                  },
                ),
              ],
            ));
      },
    );
  }
}
