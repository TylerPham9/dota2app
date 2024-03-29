import 'package:flutter/material.dart';

//Models
import 'package:dota2app/models/Hero.dart';

//Subsections
import 'package:dota2app/screens/hero_detail/hero_base_detail/stats_table.dart';
import 'package:dota2app/screens/hero_detail/hero_base_detail/additional_details_table.dart';
import 'package:dota2app/screens/hero_detail/hero_base_detail/attributes.dart';

//Style
import 'package:dota2app/style.dart';

class HeroBaseDetail extends StatelessWidget {
  final DotaHero _dotaHero;

  HeroBaseDetail(this._dotaHero);

  @override
  Widget build(BuildContext context) {
    List<List<String>> details = [
      ['Movement Speed', _dotaHero.moveSpeed.toString()],
      ['Turn Rate', _dotaHero.turnRate.toString()],
      ['Attack Range', _dotaHero.attackRange.toString()],
      [
        'Projectile Speed',
        (_dotaHero.projectileSpeed == 0)
            ? 'Instant'
            : _dotaHero.projectileSpeed.toString()
      ],
      ['Base attack time', _dotaHero.attackRate.toString()],
      ['Captains Mode', _dotaHero.cmEnabled.toString()]
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                    constraints: BoxConstraints.expand(
                      height: 144.0,
                      width: 256.0,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_dotaHero.img),
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AttributeDetail('str', _dotaHero.baseStr, _dotaHero.strGain,
                        _dotaHero.primaryAttr),
                    AttributeDetail('agi', _dotaHero.baseAgi, _dotaHero.agiGain,
                        _dotaHero.primaryAttr),
                    AttributeDetail('int', _dotaHero.baseInt, _dotaHero.intGain,
                        _dotaHero.primaryAttr),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: StatsTable(_dotaHero),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
                child: AdditionalDetailTable(details),
              ),
            ]),
      ),
    );
  }

  TableRow baseDetailTableRow(String title, String value) {
    return TableRow(children: [
      TableCell(
        child: Padding(
          padding: CellPadding,
          child: Text(title, style: boldTextStyle),
        ),
      ),
      TableCell(
        child: Padding(
          padding: CellPadding,
          child: Text(value),
        ),
      )
    ]);
  }
}
