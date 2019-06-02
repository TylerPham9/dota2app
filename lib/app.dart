import 'package:flutter/material.dart';
import 'style.dart';

import 'package:dota2app/screens/heroes/heroes.dart';
import 'package:dota2app/screens/hero_detail/hero_detail.dart';

const HeroesRoute = '/';
const HeroDetailRoute = '/hero_detail';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case HeroesRoute:
          screen = Heroes();
          break;
        case HeroDetailRoute:
          screen = HeroDetail(arguments['hero']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
      textTheme: TextTheme(
        title: TitleTextStyle,
        body1: Body1TextStyle,
      ),
    );
  }
}
