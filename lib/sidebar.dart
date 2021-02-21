import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
//Pages
import 'pages/home.dart';
import 'pages/zeitplanung.dart';
import 'pages/zeiterfassung.dart';
import 'pages/info.dart';
import 'pages/settings.dart';
import 'pages/log.dart';

//Helper classes
class MenuItem extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap, this.iconColor}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}
class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.black;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {//this is here because flutter wants it to be here...
    return true;
  }

}

//Navigation Environment
enum NavigationEvents {
  HomePageClicked,
  ZeitplanungClicked,
  ZeiterfassungClicked,
  InfoClicked,
  SettingsClicked,
  LogClicked,
}
abstract class NavigationStates {}
class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Home();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClicked:
        yield Home();
        break;
      case NavigationEvents.ZeitplanungClicked:
        yield Zeitplanung();
        break;
      case NavigationEvents.ZeiterfassungClicked:
        yield Zeiterfassung();
        break;
      case NavigationEvents.InfoClicked:
        yield Info();
        break;
      case NavigationEvents.SettingsClicked:
        yield Settings();
        break;
      case NavigationEvents.LogClicked:
        yield Log();
        break;
    }
  }
}

//Displaying Classes
class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}
class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 400);
  Map<String, MenuItem> menuItems;

  _SideBarState(){
    menuItems={
      'Home': MenuItem(
        icon: Icons.home,
        title: "Home",
        //color: iconColor,
        onTap: () {
          onIconPressed();
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClicked);
        },
      ),//Home
      'Zeitplanung': MenuItem(
        icon: Icons.calendar_today_outlined,
        title: "Zeitplanung",
        //color: iconColor,
        onTap: () {
          onIconPressed();
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ZeitplanungClicked);
        },
      ),
      'Zeiterfassung': MenuItem(
        icon: Icons.access_alarm_rounded,
        title: "Zeiterfassung",
        //color: iconColor,
        onTap: () {
          onIconPressed();
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ZeiterfassungClicked);
        },
      ),
      'Info': MenuItem(
        icon: Icons.info,
        title: "Info",
        //color: iconColor,
        onTap: () {
          onIconPressed();
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.InfoClicked);
        },
      ),
      'Settings': MenuItem(
        icon: Icons.settings,
        title: "Settings",
        onTap: () {
          onIconPressed();
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SettingsClicked);
        },
      ),// Settings
      'Log':MenuItem(
        icon: Icons.exit_to_app,
        title: "Logout",
        onTap: () {
          onIconPressed();
          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LogClicked);
        },
      ),//needs a lot of work
    };
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }
  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    //Color fontColor= Colors.black;
    Color bgColor= Colors.red[900];
    //Color iconColor = Colors.grey[500];

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 35,
          child: SafeArea(
            child: Row(//this is the SIDEBAR
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: bgColor,
                    child: Column(
                      children: <Widget>[
                        /*
                        !!!!!!!!!!!!!!!!!!!!!!!!keep this for later!!!!!!!!!!!!!!!!!!!!!!!!
                        SizedBox(
                          height: 100,
                        ),
                        ListTile(
                          title: Text(
                            "Prateek",
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            "www.techieblossom.com",
                            style: TextStyle(
                              color: Color(0xFF1BB5FD),
                              fontSize: 18,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                            ),
                            radius: 40,
                          ),
                        ),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        //can't I just automate these things

                         */
                        Divider(
                          height: 50,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        menuItems['Home'],
                        menuItems['Zeitplanung'],
                        menuItems['Zeiterfassung'],
                        menuItems['Info'],
                        Divider(
                          height: 100,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        menuItems['Settings'],
                        menuItems['Log'],// Login-Logout
                      ],
                    ),
                  ),
                ),
                Align(//Little Notch on the right.
                  alignment: Alignment(0, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: Colors.red[900],
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
