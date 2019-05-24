import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/screens/hero_detail/stats_table.dart';
import 'package:dota2app/screens/hero_detail/additional_details_table.dart';
import 'package:dota2app/style.dart';

class HeroDetail extends StatelessWidget {
  final DotaHero _dotaHero;

  HeroDetail(this._dotaHero);

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
      appBar: AppBar(
        title: Text(_dotaHero.localizedName),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
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

  TableRow detailTableRow(String title, String value) {
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

class AttributeDetail extends StatelessWidget {
  final String _attr;
  final int _attrBase;
  final double _attrGain;
  final String _primaryAttr;
  final colorMap = {'str': Colors.red, 'agi': Colors.green, 'int': Colors.blue};
  final iconMap = {
    'str': "assets/icons/strIcon.png",
    'agi': "assets/icons/agiIcon.png",
    'int': "assets/icons/intIcon.png",
  };

  AttributeDetail(
      this._attr, this._attrBase, this._attrGain, this._primaryAttr);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
                width: 45.0,
                height: 45.0,
                child: DecoratedBox(decoration: getAttrIcon()))),
        Row(
          children: <Widget>[
            Container(
                child: Text(_attrBase.toString(),
                    style: TextStyle(color: colorMap[_attr]))),
            Container(child: Text(' + ' + _attrGain.toString())),
          ],
        )
      ],
    );
  }

  BoxDecoration getAttrIcon() {
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage(iconMap[_attr]), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
        border: new Border.all(
            color: (_attr == _primaryAttr) ? Colors.amber : Colors.black,
            width: 2.0));
  }
}
