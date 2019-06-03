class AbilityTalentList {
  List<AbilityTalent> ATList;

  AbilityTalentList({this.ATList});

  AbilityTalentList.fromJson(Map<String, dynamic> json) {
    ATList = new List<AbilityTalent>();
    json.keys.forEach((key) {
//      AbilityTalent temp = new AbilityTalent.fromJson(json[key]);
      ATList.add(new AbilityTalent.fromJson(json[key]));`
    });
  }
}

class AbilityTalent {
  List<String> abilities;
  List<Talents> talents;

  AbilityTalent({this.abilities, this.talents});

  AbilityTalent.fromJson(Map<String, dynamic> json) {
    abilities = json['abilities'].cast<String>();
    if (json['talents'] != null) {
      talents = new List<Talents>();
      json['talents'].forEach((v) {
        talents.add(new Talents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abilities'] = this.abilities;
    if (this.talents != null) {
      data['talents'] = this.talents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Talents {
  String name;
  int level;

  Talents({this.name, this.level});

  Talents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}