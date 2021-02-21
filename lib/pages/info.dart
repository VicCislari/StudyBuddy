import 'package:flutter/material.dart';
import 'package:studybuddy/bloc/navigation_bloc/navigation_bloc.dart';

class Info extends StatefulWidget with NavigationStates {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int ninjalevel=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Ninja'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation:0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          setState((){
            ninjalevel+=1;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 50.0, 10.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Center(
              child: CircleAvatar(
                radius:40.0,
                //backgroundImage:AssetImage('assets/image.jfif'),
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.grey[600],
            ),
            Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '$ninjalevel',
              style: TextStyle(
                color: Colors.amberAccent,
                letterSpacing: 3.0,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Current Ninja Level',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '20',
              style: TextStyle(
                color: Colors.amberAccent,
                letterSpacing: 3.0,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width:20),
                Text(
                  'chun.li@theninjafactory.com',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
