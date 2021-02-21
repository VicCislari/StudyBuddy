import 'package:flutter/material.dart';
import '../sidebar.dart';//no idea why this has to be imported, but it works...

class Log extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Log In",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
