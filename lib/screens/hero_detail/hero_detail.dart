import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';

class HeroDetail extends StatelessWidget {
  final DotaHero _dotaHero;
  HeroDetail(this._dotaHero);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dotaHero.localizedName),
      ),
    );
  }
}