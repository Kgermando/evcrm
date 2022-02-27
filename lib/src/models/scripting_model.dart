class ScriptingModel {
  final int? id;
  final String campaignName;
  final List scripting;
  final DateTime date;
  final String role;
  final String userName;
  final String superviseur;

  ScriptingModel(
      {this.id,
      required this.campaignName,
      required this.scripting,
      required this.date,
      required this.role,
      required this.userName,
      required this.superviseur});

  factory ScriptingModel.fromSQL(List<dynamic> row) {
    return ScriptingModel(
        id: row[0],
        campaignName: row[1],
        scripting: row[2],
        date: row[3],
        role: row[4],
        userName: row[5],
        superviseur: row[6]);
  }

  factory ScriptingModel.fromJson(Map<String, dynamic> json) {
    return ScriptingModel(
        id: json['id'],
        campaignName: json['campaignName'],
        scripting: json['scripting'],
        date: DateTime.parse(json['date']),
        role: json["role"],
        userName: json["userName"],
        superviseur: json["superviseur"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignName': campaignName,
      'scripting': scripting,
      'date': date.toIso8601String(),
      'role': role,
      "userName": userName,
      'superviseur': superviseur
    };
  }
}
