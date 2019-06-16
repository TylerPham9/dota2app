class AbilityTalentList {
  Map<String, AbilityTalent> ATList;
  Map<String, List<String>> Abilities;
  Map<String, List<Talent>> Talents;
//  Map<String, Map<int, List<String>>> Talents;
//  List<AbilityTalent> ATList;
  AbilityTalentList({this.ATList});

  AbilityTalentList.fromJson(Map<String, dynamic> json) {
//    ATList = new Map<String, AbilityTalent>();
//    ATList = new List<AbilityTalent>();
    Abilities = new Map<String, List<String>>();
//    Talents = new Map<String, Map<int, List<String>>>();
    Talents = new Map<String, List<Talent>>();

    json.keys.forEach((key) {
      AbilityTalent temp = new AbilityTalent.fromJson(json[key]);
//      ATList[key] = temp;
      Talents[key] = temp.talents;
      Abilities[key] = temp.abilities;
//      ATList.add(new AbilityTalent.fromJson(json[key]));
    });
  }
}

class AbilityTalent {
  List<String> abilities;
  List<Talent> talents;
//  Map<int, List<String>> talents;

  AbilityTalent({this.abilities, this.talents});

  AbilityTalent.fromJson(Map<String, dynamic> json) {
    abilities = json['abilities'].cast<String>();
    if (json['talents'] != null) {
      talents = new List<Talent>();
//      talents = new Map<int, List<String>>();
      json['talents'].forEach((v) {
//          Talent temp = new Talent.fromJson(v);
//          if (talents[temp.level] == null){
//            talents[temp.level] = [temp.name];
//          } else {
//            talents[temp.level].add(temp.name);
//          }

        talents.add(new Talent.fromJson(v));
      });
    }
  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['abilities'] = this.abilities;
//    if (this.talents != null) {
//      data['talents'] = this.talents.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
}

class TalentTree {
  Map<int, List<String>> level;

  TalentTree(List<Talent> talents){
    this.level = new Map<int, List<String>>();
    talents.forEach((talent) {
      if (this.level[talent.level] == null) {
        this.level[talent.level] = [talent.name];
      } else {
        this.level[talent.level].add(talent.name);
      }
    });
  }
}

class Talent {

  String name;
//  String dname;
  int level;

  Talent({this.name, this.level});

  Talent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = (json['level']-1)*5 + 10;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}