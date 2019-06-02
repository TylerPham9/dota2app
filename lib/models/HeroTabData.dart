import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';

class HeroTabData {
  String title;
  Color color;
  List<DotaHero> heroes;

  HeroTabData({this.title, this.color, this.heroes});
}
