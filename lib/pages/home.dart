import 'package:flutter/material.dart';
//import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:studybuddy/bloc/navigation_bloc/navigation_bloc.dart';

class Home extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
