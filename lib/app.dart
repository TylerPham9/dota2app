import 'package:flutter/material.dart';
import 'style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/Hero.dart';
import 'screens/heroes.dart';

const HeroesUrl =
    'https://raw.githubusercontent.com/odota/dotaconstants/master/build/heroes.json';

const HeroesRoute = '/';
const HeroDetailRoute = '/hero_detail';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Heroes',
      home: HomePage(),
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
  HeroHub heroHub;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(HeroesUrl);
    var decodedJson = jsonDecode(res.body);
    heroHub = HeroHub.fromJson(decodedJson);
    print("Download Done!");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Heroes(heroHub);
  }
}
