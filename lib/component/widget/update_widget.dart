// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:store_redirect/store_redirect.dart';
//
// class UpdateWidget extends StatefulWidget {
//   @override
//   _UpdateWidget createState() => _UpdateWidget();
// }
//
// class _UpdateWidget extends State<UpdateWidget> {
//   @override
//   void initState() {
//     super.initState();
//     Timer.run(() => _showDialog());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text(" ",
//             textAlign: TextAlign.center, style: TextStyle(fontSize: 16)));
//   }
//
//   void _showDialog() {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return WillPopScope(
//             onWillPop: () {},
//             child: new AlertDialog(
//               title: new Text("Update Required"),
//               content: new Text(
//                   "You must update to continue."),
//               actions: <Widget>[
//                 new FlatButton(
//                   child: new Text("Update"),
//                   onPressed: () {
//                     StoreRedirect.redirect(
//                         androidAppId: "id.iwarranty.iwarranty",
//                         iOSAppId: "");
//                   },
//                 ),
//               ],
//             ));
//       },
//     );
//   }
// }
