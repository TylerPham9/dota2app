import 'package:flutter/material.dart';
import 'style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/Hero.dart';
import 'screens/heroes.dart';
import 'package:dota2app/screens/hero_detail/hero_detail.dart';

const HeroesUrl =
    'https://raw.githubusercontent.com/odota/dotaconstants/master/build/heroes.json';

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
          screen = HomePage();
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
        brightness: Brightness.light,
        primaryColor: Colors.pink,
        accentColor: Colors.cyan[600]
//        scaffoldBackgroundColor: Color(0xff2F363D),
        );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  HeroList heroList;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(HeroesUrl);
    var decodedJson = jsonDecode(res.body);
    heroList = HeroList.fromJson(decodedJson);
    print("Download Done!");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Heroes(heroList);
  }
}
