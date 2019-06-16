import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/models/Talents.dart';
import 'package:dota2app/screens/heroes/heroes_tabs.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

const HeroesUrl =
    'https://raw.githubusercontent.com/odota/dotaconstants/master/build/heroes.json';
const HeroAbilitiesUrl =
    'https://raw.githubusercontent.com/odota/dotaconstants/master/build/hero_abilities.json';
const AbilitiesUrl =
    'https://raw.githubusercontent.com/odota/dotaconstants/master/build/abilities.json';


class Heroes extends StatefulWidget {
  @override
  HeroesState createState() {
    return new HeroesState();
  }
}

class HeroesState extends State<Heroes> {
  HeroList heroList;
  AbilityTalentList ATList;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var heroesRes = await http.get(HeroesUrl);
    var decodedHeroesJson = jsonDecode(heroesRes.body);

    var heroAbilitiesRes = await http.get(HeroAbilitiesUrl);
    var decodedHeroesAbilitiesJson = jsonDecode(heroAbilitiesRes.body);


    ATList = AbilityTalentList.fromJson(decodedHeroesAbilitiesJson);
//    print(ATList);
//    ATList.ATList['npc_dota_hero_axe']
    heroList = HeroList.fromJson(decodedHeroesJson, ATList.Talents);
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
