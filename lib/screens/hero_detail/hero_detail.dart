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
    int lvl15 = 14;
    int lvl25 = 24;


    final Stat str = new Stat(
        'Str',
        '0',
        hero.baseStr.toString(),
        (hero.baseStr.toDouble() + (lvl15 * hero.strGain).round())
            .toInt()
            .toString(),
        (hero.baseStr.toDouble() + (lvl25 * hero.strGain).round())
            .toInt()
            .toString());
    final Stat intel = new Stat(
        'Int',
        '0',
        hero.baseInt.toString(),
        (hero.baseInt.toDouble() + (lvl15 * hero.intGain).round())
            .toInt()
            .toString(),
        (hero.baseInt.toDouble() + (lvl25 * hero.intGain).round())
            .toInt()
            .toString());
    final Stat agi = new Stat(
        'Agi',
        '0',
        hero.baseAgi.toString(),
        (hero.baseAgi.toDouble() + (lvl15 * hero.agiGain).round())
            .toInt()
            .toString(),
        (hero.baseAgi.toDouble() + (lvl25 * hero.agiGain).round())
            .toInt()
            .toString());

    int healthPerStr = 20;
    final Stat health = new Stat(
      'Health',
      hero.baseHealth.toString(),
      (hero.baseHealth.toDouble() + healthPerStr * double.parse(str.lvl1)).toString(),
      (hero.baseHealth.toDouble() + healthPerStr * double.parse(str.lvl15)).toString(),
      (hero.baseHealth.toDouble() + healthPerStr * double.parse(str.lvl25)).toString(),
    );

    double hRegenPerStr = 0.1;
    final Stat hRegen = new Stat(
      'Health Regen',
      hero.baseHealthRegen.toString(),
      (hero.baseHealthRegen + hRegenPerStr * double.parse(str.lvl1)).toStringAsFixed(2),
      (hero.baseHealthRegen + hRegenPerStr * double.parse(str.lvl15)).toStringAsFixed(2),
      (hero.baseHealthRegen + hRegenPerStr * double.parse(str.lvl25)).toStringAsFixed(2),
    );

    double mResPerStr = 0.08;
    final Stat magicRes = new Stat(
      'Magic Res',
      hero.baseMr.toString() + '%',
//      (1-(1-(hero.baseMr/100))*(1-1.84)).toStringAsFixed(2) + '%',
//      (1-(1-(hero.baseMr/100))*(1-1.84)).toStringAsFixed(2) + '%',
      (1 - (1 - hero.baseMr/100)*(1 - mResPerStr * double.parse(str.lvl1)))
            .toStringAsFixed(2) + '%',
      (1 - (1 - hero.baseMr/100)*(1 - mResPerStr * double.parse(str.lvl15)))
          .toStringAsFixed(2) + '%',
      (1 - (1 - hero.baseMr/100)*(1 - mResPerStr * double.parse(str.lvl25)))
          .toStringAsFixed(2) + '%',
    );

    int manaPerIntel = 12;
    final Stat mana = new Stat(
      'Mana',
      hero.baseMana.toString(),
      (hero.baseMana.toInt() + manaPerIntel * int.parse(intel.lvl1)).toString(),
      (hero.baseMana.toInt() + manaPerIntel * int.parse(intel.lvl15)).toString(),
      (hero.baseMana.toInt() + manaPerIntel * int.parse(intel.lvl25)).toString(),
    );

    double spellDmgPerIntel = 0.07;
    final Stat spellDmg = new Stat(
      'Spell Dmg',
      '0',
      (spellDmgPerIntel * double.parse(intel.lvl1)).toStringAsFixed(2) + '%',
      (spellDmgPerIntel * double.parse(intel.lvl15)).toStringAsFixed(2) + '%',
      (spellDmgPerIntel * double.parse(intel.lvl25)).toStringAsFixed(2) + '%',
    );

    double mRegenPerIntel = 0.05;
    final Stat mRegen = new Stat(
      'Mana Regen',
      hero.baseManaRegen.toString(),
      (hero.baseManaRegen + mRegenPerIntel * double.parse(intel.lvl1))
          .toStringAsFixed(2),
      (hero.baseManaRegen + mRegenPerIntel * double.parse(intel.lvl15))
          .toStringAsFixed(2),
      (hero.baseManaRegen + mRegenPerIntel * double.parse(intel.lvl25))
          .toStringAsFixed(2),
    );

    double armorPerAgi = 0.16;
    final Stat armor = new Stat(
      'Armor',
      hero.baseArmor.toString(),
      (hero.baseArmor + armorPerAgi * double.parse(agi.lvl1))
          .toStringAsFixed(2),
      (hero.baseArmor + armorPerAgi * double.parse(agi.lvl15))
          .toStringAsFixed(2),
      (hero.baseArmor + armorPerAgi * double.parse(agi.lvl25))
          .toStringAsFixed(2),
    );

    final Stat atkspeed = new Stat(
      'Att/sec',
      hero.attackRate.toString(),
      (((100 + double.parse(agi.lvl1)) * 0.01) / hero.attackRate)
          .toStringAsFixed(2),
      (((100 + double.parse(agi.lvl15)) * 0.01) / hero.attackRate)
          .toStringAsFixed(2),
      (((100 + double.parse(agi.lvl25)) * 0.01) / hero.attackRate)
          .toStringAsFixed(2),
    );

    double moveSpPerAgi = 0.05;
    final Stat moveSpAmp = new Stat(
      'Move sp amp.',
      '0%',
      (moveSpPerAgi * double.parse(agi.lvl1)).toStringAsFixed(2) + '%',
      (moveSpPerAgi * double.parse(agi.lvl15)).toStringAsFixed(2) + '%',
      (moveSpPerAgi * double.parse(agi.lvl25)).toStringAsFixed(2) + '%',
    );

    int bonusDmgLvl1;
    int bonusDmgLvl15;
    int bonusDmgLvl25;

    switch (hero.primaryAttr) {
      case "agi":
        {
          bonusDmgLvl1 = int.parse(agi.lvl1);
          bonusDmgLvl15 = int.parse(agi.lvl15);
          bonusDmgLvl25 = int.parse(agi.lvl25);
        }
        break;
      case "str":
        {
          bonusDmgLvl1 = int.parse(str.lvl1);
          bonusDmgLvl15 = int.parse(str.lvl15);
          bonusDmgLvl25 = int.parse(str.lvl25);
        }
        break;
      case "int":
        {
          bonusDmgLvl1 = int.parse(intel.lvl1);
          bonusDmgLvl15 = int.parse(intel.lvl15);
          bonusDmgLvl25 = int.parse(intel.lvl25);
        }
        break;
      default:
        break;
    }

    final Stat damage = new Stat(
      'Damage',
      hero.baseAttackMin.toString() + '-' + hero.baseAttackMax.toString(),
      ((hero.baseAttackMin + bonusDmgLvl1).toString() + '-' +
          (hero.baseAttackMax + bonusDmgLvl1).toString()),
      ((hero.baseAttackMin + bonusDmgLvl15).toString() + '-' +
          (hero.baseAttackMax + bonusDmgLvl15).toString()),
      ((hero.baseAttackMin + bonusDmgLvl25).toString() + '-' +
          (hero.baseAttackMax + bonusDmgLvl25).toString()),
    );

    stats.add(health);
    stats.add(hRegen);
    stats.add(magicRes);
    stats.add(mana);
    stats.add(mRegen);
    stats.add(spellDmg);
    stats.add(armor);
    stats.add(atkspeed);
    stats.add(moveSpAmp);
    stats.add(damage);

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
