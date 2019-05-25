const int _healthPerStr = 20;
const double _hRegendPerStr = 0.1;
const double _mResPerStr = 0.0008;
const int _manaPerIntel = 12;
const double _spellDmgPerIntel = 0.07;
const double _mRegenPerIntel = 0.05;
const double _armorPerAgi = 0.16;
const double _moveSpdPerAgi = 0.05;

String attrCalc(int base, double gain, int lvl) {
  return (base + lvl * gain).toStringAsFixed(2);
}

String healthCalc(int base, String str) {
  return (base + _healthPerStr * double.parse(str).round()).toString();
}

String hRegenCalc(double base, String str) {
  return (base + _hRegendPerStr * double.parse(str)).toStringAsFixed(2);
}

String mResCalc(int base, String str) {
  return ((1 - (1 - (base) / 100.0) * (1 - _mResPerStr * double.parse(str))) *
              100)
          .toStringAsFixed(2) +
      '%';
}

String manaCalc(int base, String intel) {
  return (base + _manaPerIntel * double.parse(intel).round()).toString();
}

String spellDmgCalc(String intel) {
  return (_spellDmgPerIntel * double.parse(intel)).toStringAsFixed(2) + '%';
}

String mRegenCalc(int base, String intel) {
  return (base + _mRegenPerIntel * double.parse(intel)).toStringAsFixed(2);
}

String armorCalc(double base, String agi) {
  return (base + _armorPerAgi * double.parse(agi)).toStringAsFixed(2);
}

String atkSpdCalc(double base, String agi) {
  return (((100 + double.parse(agi)) * 0.01) / base).toStringAsFixed(2);
}

String moveSpdAmpCalc(String agi) {
  return (_moveSpdPerAgi * double.parse(agi)).toStringAsFixed(2) + '%';
}

String damageCalc(int baseMin, int baseMax, double bonusDmg) {
  return ((baseMin + bonusDmg.toInt()).toString() +
      ' - ' +
      (baseMax + bonusDmg.toInt()).toString());
}
