import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool visible;

  const LoadingWidget({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: Container(
        color: Colors.white,
        alignment: FractionalOffset.center,
        child: const CircularProgressIndicator(
          color: Color.fromRGBO(2, 79, 137, 1)
        ),
      ),
    );
  }
}
