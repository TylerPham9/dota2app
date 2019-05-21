import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/models/Stat.dart';
import 'package:dota2app/screens/hero_detail/calculations.dart';

const double _cellPadding = 8.0;
const TextStyle _bold = TextStyle(fontWeight: FontWeight.bold);

class StatsTable extends StatelessWidget {
  final DotaHero _dotaHero;

  StatsTable(this._dotaHero);

  @override
  Widget build(BuildContext context) {
    final stats = statsCalc(_dotaHero);
    return Table(
      border: TableBorder.all(width: 1.0, color: Colors.grey),
      children: [
        TableRow(children: _titleCells()),
      ]..addAll(
          stats.map((stat) => TableRow(children: heroDetailsTableRow(stat)))),
    );
  }

  List<TableCell> _titleCells() {
    List<String> titles = ['Level', 'Base', '1', '15', '25'];
    return titles
        .map((title) => TableCell(
                child: Padding(
              padding: const EdgeInsets.all(_cellPadding),
              child: Text(title, style: _bold),
            )))
        .toList();
  }

  List<TableCell> heroDetailsTableRow(Stat stat) {
    List<String> stats = [stat.base, stat.lvl01, stat.lvl15, stat.lvl25];
    return [
      TableCell(
          child: Padding(
        padding: const EdgeInsets.all(_cellPadding),
        child: Text(stat.name, style: _bold),
      ))
    ]..addAll(stats.map((stat) => TableCell(
            child: Padding(
          padding: const EdgeInsets.all(_cellPadding),
          child: Text(stat),
        ))));
  }

  List<Stat> statsCalc(DotaHero hero) {
    List<Stat> stats = [];
    int _lvl01 = 0;
    int _lvl15 = 14;
    int _lvl25 = 24;

    double bonusDmgLvl01;
    double bonusDmgLvl15;
    double bonusDmgLvl25;

    // Attributes calculation
    final Stat str = new Stat(
        'Str',
        hero.baseStr.toString(),
        attrCalc(hero.baseStr, hero.strGain, _lvl01),
        attrCalc(hero.baseStr, hero.strGain, _lvl15),
        attrCalc(hero.baseStr, hero.strGain, _lvl25));
    final Stat agi = new Stat(
        'Agi',
        hero.baseAgi.toString(),
        attrCalc(hero.baseAgi, hero.agiGain, _lvl01),
        attrCalc(hero.baseAgi, hero.agiGain, _lvl15),
        attrCalc(hero.baseAgi, hero.agiGain, _lvl25));
    final Stat intel = new Stat(
        'Int',
        hero.baseInt.toString(),
        attrCalc(hero.baseInt, hero.intGain, _lvl01),
        attrCalc(hero.baseInt, hero.intGain, _lvl15),
        attrCalc(hero.baseInt, hero.intGain, _lvl25));

    final Stat health = new Stat(
      'Health',
      hero.baseHealth.toString(),
      healthCalc(hero.baseHealth, str.lvl01),
      healthCalc(hero.baseHealth, str.lvl15),
      healthCalc(hero.baseHealth, str.lvl25),
    );

    final Stat hRegen = new Stat(
      'Health Regen',
      hero.baseHealthRegen.toString(),
      hRegenCalc(hero.baseHealthRegen, str.lvl01),
      hRegenCalc(hero.baseHealthRegen, str.lvl15),
      hRegenCalc(hero.baseHealthRegen, str.lvl25),
    );

    final Stat magicRes = new Stat(
      'Magic Reg',
      hero.baseMr.toString() + '%',
      mResCalc(hero.baseMr, str.lvl01),
      mResCalc(hero.baseMr, str.lvl15),
      mResCalc(hero.baseMr, str.lvl25),
    );

    final Stat mana = new Stat(
      'Mana',
      hero.baseMana.toString(),
      manaCalc(hero.baseMana, intel.lvl01),
      manaCalc(hero.baseMana, intel.lvl15),
      manaCalc(hero.baseMana, intel.lvl25),
    );

    final Stat spellDmg = new Stat(
      'Spell Dmg',
      '0%',
      spellDmgCalc(intel.lvl01),
      spellDmgCalc(intel.lvl15),
      spellDmgCalc(intel.lvl25),
    );

    final Stat mRegen = new Stat(
      'Mana Regen',
      hero.baseManaRegen.toString(),
      mRegenCalc(hero.baseManaRegen, intel.lvl01),
      mRegenCalc(hero.baseManaRegen, intel.lvl15),
      mRegenCalc(hero.baseManaRegen, intel.lvl25),
    );

    final Stat armor = new Stat(
      'Armor',
      hero.baseArmor.toString(),
      armorCalc(hero.baseArmor, agi.lvl01),
      armorCalc(hero.baseArmor, agi.lvl15),
      armorCalc(hero.baseArmor, agi.lvl25),
    );

    final Stat atkSpd = new Stat(
      'Att/sec',
      atkSpdCalc(hero.attackRate, '0'),
      atkSpdCalc(hero.attackRate, agi.lvl01),
      atkSpdCalc(hero.attackRate, agi.lvl15),
      atkSpdCalc(hero.attackRate, agi.lvl25),
    );

    final Stat moveSpdAmp = new Stat(
      'Move sp amp.',
      '0%',
      moveSpdAmpCalc(agi.lvl01),
      moveSpdAmpCalc(agi.lvl15),
      moveSpdAmpCalc(agi.lvl25),
    );

    switch (hero.primaryAttr) {
      case "agi":
        {
          bonusDmgLvl01 = double.parse(agi.lvl01);
          bonusDmgLvl15 = double.parse(agi.lvl15);
          bonusDmgLvl25 = double.parse(agi.lvl25);
        }
        break;
      case "str":
        {
          bonusDmgLvl01 = double.parse(str.lvl01);
          bonusDmgLvl15 = double.parse(str.lvl15);
          bonusDmgLvl25 = double.parse(str.lvl25);
        }
        break;
      case "int":
        {
          bonusDmgLvl01 = double.parse(intel.lvl01);
          bonusDmgLvl15 = double.parse(intel.lvl15);
          bonusDmgLvl25 = double.parse(intel.lvl25);
        }
        break;
      default:
        break;
    }

    final Stat damage = new Stat(
      'Damage',
      damageCalc(hero.baseAttackMin, hero.baseAttackMax, 0),
      damageCalc(hero.baseAttackMin, hero.baseAttackMax, bonusDmgLvl01),
      damageCalc(hero.baseAttackMin, hero.baseAttackMax, bonusDmgLvl15),
      damageCalc(hero.baseAttackMin, hero.baseAttackMax, bonusDmgLvl25),
    );

//    stats.add(str);
//    stats.add(agi);
//    stats.add(intel);
    stats.add(health);
    stats.add(hRegen);
    stats.add(magicRes);
    stats.add(mana);
    stats.add(mRegen);
    stats.add(spellDmg);
    stats.add(armor);
    stats.add(atkSpd);
    stats.add(moveSpdAmp);
    stats.add(damage);

    return stats;
  }
}
