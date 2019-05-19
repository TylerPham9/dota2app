import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';

const double _cellPadding = 8.0;
const TextStyle _bold = TextStyle(fontWeight: FontWeight.bold);

class HeroDetail extends StatelessWidget {
  final DotaHero _dotaHero;
  HeroDetail(this._dotaHero);

  @override
  Widget build(BuildContext context) {
    final stats = heroDetailsCalculation(_dotaHero);

    return Scaffold(
      appBar: AppBar(
        title: Text(_dotaHero.localizedName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          Row(
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
          Table(
              border: TableBorder.all(width: 1.0, color: Colors.grey),
              children: [
                TableRow(children: titleCells()),

//              TableRow(children: heroDetailsTableRow(statMap['heath'])),
//              TableRow(children: heroDetailsTableRow(statMap['mana']))
              ]..addAll(stats
                  .map((stat) => TableRow(children: heroDetailsTableRow(stat))))

//              statMap.map((stat) => TableRow(
//                children: heroDetailsTableRow(stat)
//              )).toList()

//              TableRow(
//                children: [
//                  TableCell(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        Text('Level', style: TextStyle(fontWeight: FontWeight.bold)),
//                        Text('Base', style: TextStyle(fontWeight: FontWeight.bold)),
//                        Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
//                        Text('15', style: TextStyle(fontWeight: FontWeight.bold)),
//                        Text('25', style: TextStyle(fontWeight: FontWeight.bold)),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  TableCell(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        Text('Health',
//                            style: TextStyle(fontWeight: FontWeight.bold)),
//                        Text(_dotaHero.baseHealth.toString()),
//                        Text((_dotaHero.baseHealth + 20 * _dotaHero.baseStr)
//                            .toString()),
//                      ],
//                    ),
//                  ),
//                ],
//              )
//            ],
              )
        ],
      ),
    );
  }

  List<Stat> heroDetailsCalculation(DotaHero hero) {
    List<Stat> stats = [];
    final Stat str = new Stat(
        'Str',
        '0',
        hero.baseStr.toString(),
        (hero.baseStr.toDouble() + (14.0 * hero.strGain).round())
            .toInt()
            .toString(),
        (hero.baseStr.toDouble() + (24.0 * hero.strGain).round())
            .toInt()
            .toString());
    final Stat intel = new Stat(
        'Int',
        '0',
        hero.baseInt.toString(),
        (hero.baseInt.toDouble() + (14.0 * hero.intGain).round())
            .toInt()
            .toString(),
        (hero.baseInt.toDouble() + (24.0 * hero.intGain).round())
            .toInt()
            .toString());
    final Stat agi = new Stat(
        'Agi',
        '0',
        hero.baseAgi.toString(),
        (hero.baseAgi.toDouble() + (14.0 * hero.agiGain).round())
            .toInt()
            .toString(),
        (hero.baseAgi.toDouble() + (24.0 * hero.agiGain).round())
            .toInt()
            .toString());

    final Stat health = new Stat(
      'Health',
      hero.baseHealth.toString(),
      (hero.baseHealth.toDouble() + 20 * double.parse(str.lvl1)).toString(),
      (hero.baseHealth.toDouble() + 20 * double.parse(str.lvl15)).toString(),
      (hero.baseHealth.toDouble() + 20 * double.parse(str.lvl25)).toString(),
    );
    final Stat hRegen = new Stat(
      'Health Regen',
      hero.baseHealthRegen.toString(),
      (hero.baseHealthRegen + 0.1 * double.parse(str.lvl1)).toStringAsFixed(2),
      (hero.baseHealthRegen + 0.1 * double.parse(str.lvl15)).toStringAsFixed(2),
      (hero.baseHealthRegen + 0.1 * double.parse(str.lvl25)).toStringAsFixed(2),
    );
    final Stat magicRes = new Stat(
      'Magic Res',
      hero.baseMr.toString() + '%',
      (hero.baseMr + 0.08 * double.parse(str.lvl1)).toStringAsFixed(2) + '%',
      (hero.baseMr + 0.08 * double.parse(str.lvl15)).toStringAsFixed(2) + '%',
      (hero.baseMr + 0.08 * double.parse(str.lvl25)).toStringAsFixed(2) + '%',
    );

    final Stat mana = new Stat(
      'Mana',
      hero.baseMana.toString(),
      (hero.baseMana.toInt() + 12 * int.parse(intel.lvl1)).toString(),
      (hero.baseMana.toInt() + 12 * int.parse(intel.lvl15)).toString(),
      (hero.baseMana.toInt() + 12 * int.parse(intel.lvl25)).toString(),
    );
    final Stat spellDmg = new Stat(
      'Spell Dmg',
      '0',
      (0.07 * double.parse(intel.lvl1)).toString(),
      (0.07 * double.parse(intel.lvl15)).toString(),
      (0.07 * double.parse(intel.lvl25)).toString(),
    );

    stats.add(str);
    stats.add(health);
    stats.add(hRegen);

    return stats;
  }
}

class AttributeDetail extends StatelessWidget {
  final String _attr;
  final int _attrBase;
  final double _attrGain;
  final String _primaryAttr;
  final colorMap = {'str': Colors.red, 'agi': Colors.green, 'int': Colors.blue};

  AttributeDetail(
      this._attr, this._attrBase, this._attrGain, this._primaryAttr);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            (_attr == _primaryAttr) ? Icons.favorite : Icons.favorite_border,
            size: 30.0,
          ),
        ),
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
}

class StatsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

List<TableCell> titleCells() {
  return [
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text('Level', style: _bold),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text('Base', style: _bold),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text('1', style: _bold),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text('15', style: _bold),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text('25', style: _bold),
      ),
    ),
  ];
}

List<TableCell> heroDetailsTableRow(Stat stat) {
  return [
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text(stat.name, style: _bold),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text(stat.base),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text(stat.lvl1),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text(stat.lvl15),
      ),
    ),
    TableCell(
      child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text(stat.lvl25),
      ),
    ),
  ];
}

class Stat {
  String name;
  String base;
  String lvl1;
  String lvl15;
  String lvl25;
  Stat(this.name, this.base, this.lvl1, this.lvl15, this.lvl25);
}
