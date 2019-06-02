import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/screens/heroes/heroes_tabs.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

const HeroesUrl =
    'https://raw.githubusercontent.com/odota/dotaconstants/master/build/heroes.json';

class Heroes extends StatefulWidget {
  @override
  HeroesState createState() {
    return new HeroesState();
  }
}

class HeroesState extends State<Heroes> {
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
    if (heroList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return HeroesTabs(heroList);
    }
  }
}
