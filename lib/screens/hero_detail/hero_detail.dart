import 'package:flutter/material.dart';

import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/screens/hero_detail/hero_base_detail/hero_base_detail.dart';
import 'package:dota2app/screens/hero_detail/hero_talents/hero_talents.dart';

import 'package:dota2app/style.dart';

class HeroDetail extends StatelessWidget {
  final DotaHero _dotaHero;

  HeroDetail(this._dotaHero);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text(_dotaHero.localizedName),
              backgroundColor: attrColors[_dotaHero.primaryAttr],
              bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [Tab(text: 'Base Details'), Tab(text: 'Talents')])),
          body: TabBarView(children: [
            HeroBaseDetail(_dotaHero),
            HeroTalents(),
          ]),
        ));
  }
}
