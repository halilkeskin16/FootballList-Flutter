import 'dart:convert';

class CountryLeagueModel {
  int id;
  Area area;
  String name;
  String code;
  String type;
  String? emblem;
  String plan;


  CountryLeagueModel({
    required this.id,
    required this.area,
    required this.name,
    required this.code,
    required this.type,
    this.emblem,
    required this.plan,
  });
  CountryLeagueModel copyWith({
    int? id,
    Area? area,
    String? name,
    String? code,
    String? type,
    String? emblem,
    String? plan,
  }) {
    return CountryLeagueModel(
      id: id ?? this.id,
      area: area ?? this.area,
      name: name ?? this.name,
      code: code ?? this.code,
      type: type ?? this.type,
      emblem: emblem ?? this.emblem,
      plan: plan ?? this.plan,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area.toMap(),
      'name': name,
      'code': code,
      'type': type,
      'emblem': emblem,
      'plan': plan,
    };
  }
  factory CountryLeagueModel.fromMap(Map<String, dynamic> map) {
    return CountryLeagueModel(
      id: map['id'],
      area: Area.fromMap(map['area']),
      name: map['name'],
      code: map['code'],
      type: map['type'],
      emblem: map['emblem'],
      plan: map['plan'],
    );
  }
  String toJson() => json.encode(toMap());
  factory CountryLeagueModel.fromJson(String source) => CountryLeagueModel.fromMap(json.decode(source));
  @override
  String toString() {
    return 'CountryLeagueModel(id: $id, area: $area, name: $name, code: $code, type: $type, emblem: $emblem, plan: $plan)';
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CountryLeagueModel &&
      other.id == id &&
      other.area == area &&
      other.name == name &&
      other.code == code &&
      other.type == type &&
      other.emblem == emblem &&
      other.plan == plan;
  }
  @override
  int get hashCode {
    return id.hashCode ^
      area.hashCode ^
      name.hashCode ^
      code.hashCode ^
      type.hashCode ^
      emblem.hashCode ^
      plan.hashCode;
  }
}

class Area {
  int id;
  String name;
  String code;
  String? flag;

 
  Area({
    required this.id,
    required this.name,
    required this.code,
    this.flag,
  });
  Area copyWith({
    int? id,
    String? name,
    String? code,
    String? flag,
  }) {
    return Area(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      flag: flag ?? this.flag,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'flag': flag,
    };
  }
  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      flag: map['flag'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Area.fromJson(String source) => Area.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Area(id: $id, name: $name, code: $code, flag: $flag)';
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Area &&
      other.id == id &&
      other.name == name &&
      other.code == code &&
      other.flag == flag;
  }
  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      flag.hashCode;
  }
}
class CurrentSeason {
  int id;
  DateTime startDate;
  DateTime endDate;
  int? currentMatchday;
  dynamic winner;

 
  CurrentSeason({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.currentMatchday,
    required this.winner,
  });
  CurrentSeason copyWith({
    int? id,
    DateTime? startDate,
    DateTime? endDate,
    int? currentMatchday,
    dynamic winner,
  }) {
    return CurrentSeason(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      currentMatchday: currentMatchday ?? this.currentMatchday,
      winner: winner ?? this.winner,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'currentMatchday': currentMatchday,
      'winner': winner,
    };
  }
  factory CurrentSeason.fromMap(Map<String, dynamic> map) {
    return CurrentSeason(
      id: map['id'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      currentMatchday: map['currentMatchday'],
      winner: map['winner'],
    );
  }
  String toJson() => json.encode(toMap());
  factory CurrentSeason.fromJson(String source) => CurrentSeason.fromMap(json.decode(source));
  @override
  String toString() {
    return 'CurrentSeason(id: $id, startDate: $startDate, endDate: $endDate, currentMatchday: $currentMatchday, winner: $winner)';
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CurrentSeason &&
      other.id == id &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.currentMatchday == currentMatchday &&
      other.winner == winner;
  }
  @override
  int get hashCode {
    return id.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      currentMatchday.hashCode ^
      winner.hashCode;
  }
}
