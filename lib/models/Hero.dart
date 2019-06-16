import 'package:dota2app/models/Talents.dart';

const ImageHost = 'http://cdn.dota2.com';

class HeroList {
  Map<String, List<DotaHero>> heroes;
  List<DotaHero> _agiHeroes;
  List<DotaHero> _strHeroes;
  List<DotaHero> _intHeroes;

  HeroList({this.heroes});

  HeroList.fromJson(Map<String, dynamic> json, Map<String, List<Talent>> talents) {
    heroes = new Map<String, List<DotaHero>>();
    _agiHeroes = new List<DotaHero>();
    _strHeroes = new List<DotaHero>();
    _intHeroes = new List<DotaHero>();

    json.keys.forEach((key) {
      DotaHero temp = new DotaHero.fromJson(json[key]);
      temp.talentTree = new TalentTree(talents[temp.name]);
      switch (temp.primaryAttr) {
        case ('str'):
          {
            _strHeroes.add(temp);
          }
          break;
        case ('agi'):
          {
            _agiHeroes.add(temp);
          }
          break;
        case ('int'):
          {
            _intHeroes.add(temp);
          }
          break;
        default:
          break;
      }
    });
    _agiHeroes.sort((a, b) {
      return sortByName(a, b);
    });
    _strHeroes.sort((a, b) {
      return sortByName(a, b);
    });
    _intHeroes.sort((a, b) {
      return sortByName(a, b);
    });

    heroes['str'] = _strHeroes;
    heroes['agi'] = _agiHeroes;
    heroes['int'] = _intHeroes;
  }

  int sortByName(DotaHero a, DotaHero b) {
    return a.localizedName
        .toLowerCase()
        .compareTo(b.localizedName.toLowerCase());
  }
}

class DotaHero {
  int id;
  String name;
  String localizedName;
  String primaryAttr;
  String attackType;
  List<String> roles;
  String img;
  String icon;
  int baseHealth;
  double baseHealthRegen;
  int baseMana;
  double baseManaRegen;
  double baseArmor;
  int baseMr;
  int baseAttackMin;
  int baseAttackMax;
  int baseStr;
  int baseAgi;
  int baseInt;
  double strGain;
  double agiGain;
  double intGain;
  int attackRange;
  int projectileSpeed;
  double attackRate;
  int moveSpeed;
  double turnRate;
  bool cmEnabled;
  int legs;
  TalentTree talentTree;

  DotaHero(
      {this.id,
      this.name,
      this.localizedName,
      this.primaryAttr,
      this.attackType,
      this.roles,
      this.img,
      this.icon,
      this.baseHealth,
      this.baseHealthRegen,
      this.baseMana,
      this.baseManaRegen,
      this.baseArmor,
      this.baseMr,
      this.baseAttackMin,
      this.baseAttackMax,
      this.baseStr,
      this.baseAgi,
      this.baseInt,
      this.strGain,
      this.agiGain,
      this.intGain,
      this.attackRange,
      this.projectileSpeed,
      this.attackRate,
      this.moveSpeed,
      this.turnRate,
      this.cmEnabled,
      this.legs,
      this.talentTree});

  DotaHero.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localized_name'];
    primaryAttr = json['primary_attr'];
    attackType = json['attack_type'];
    roles = json['roles'].cast<String>();
    img = ImageHost + json['img'];
    icon = json['icon'];
    baseHealth = json['base_health'];
    baseHealthRegen = (json['base_health_regen'] == null)
        ? 0.0
        : json['base_health_regen'].toDouble();
    baseMana = json['base_mana'];
    baseManaRegen = json['base_mana_regen'].toDouble();
    baseArmor = json['base_armor'].toDouble();
    baseMr = json['base_mr'];
    baseAttackMin = json['base_attack_min'];
    baseAttackMax = json['base_attack_max'];
    baseStr = json['base_str'];
    baseAgi = json['base_agi'];
    baseInt = json['base_int'];
    strGain = json['str_gain'].toDouble();
    agiGain = json['agi_gain'].toDouble();
    intGain = json['int_gain'].toDouble();
    attackRange = json['attack_range'];
    projectileSpeed = json['projectile_speed'];
    attackRate = json['attack_rate'].toDouble();
    moveSpeed = json['move_speed'];
    turnRate = json['turn_rate'].toDouble();
    cmEnabled = json['cm_enabled'];
    legs = json['legs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['localized_name'] = this.localizedName;
    data['primary_attr'] = this.primaryAttr;
    data['attack_type'] = this.attackType;
    data['roles'] = this.roles;
    data['img'] = this.img;
    data['icon'] = this.icon;
    data['base_health'] = this.baseHealth;
    data['base_health_regen'] = this.baseHealthRegen;
    data['base_mana'] = this.baseMana;
    data['base_mana_regen'] = this.baseManaRegen;
    data['base_armor'] = this.baseArmor;
    data['base_mr'] = this.baseMr;
    data['base_attack_min'] = this.baseAttackMin;
    data['base_attack_max'] = this.baseAttackMax;
    data['base_str'] = this.baseStr;
    data['base_agi'] = this.baseAgi;
    data['base_int'] = this.baseInt;
    data['str_gain'] = this.strGain;
    data['agi_gain'] = this.agiGain;
    data['int_gain'] = this.intGain;
    data['attack_range'] = this.attackRange;
    data['projectile_speed'] = this.projectileSpeed;
    data['attack_rate'] = this.attackRate;
    data['move_speed'] = this.moveSpeed;
    data['turn_rate'] = this.turnRate;
    data['cm_enabled'] = this.cmEnabled;
    data['legs'] = this.legs;
    return data;
  }


//  static List<DotaHero> fetchAll() {
//
//  }

//  static DotaHero fetchByID(int heroID) {
//    //fetch all locations, iterate them and when we find the location
//    //with the id we want, return immediately
//    List<DotaHero> heroes = DotaHero.fetchAll();
//    for (var i = 0; i < heroes.length; i++){
//      if (heroes[i].id == heroID){
//        return heroes[i];
//      }
//    }
//    return null;
//  }

}
