import 'package:bloc/bloc.dart';
import '../pages/zeitplanung.dart';
import '../pages/zeiterfassung.dart';
import '../pages/home.dart';
import '../pages/info.dart';

enum NavigationEvents {
  HomePageClicked,
  ZeitplanungClicked,
  ZeiterfassungClicked,
  InfoClicked,
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
    }
  }
}
