class FakeModel {
  final int? id;
  final DateTime date;
  final String shift;
  final String fullName;
  final String sexe;
  final String telephone;
  final String lieu;
  final String statut;
  final DateTime heure;
  final String reseau;
  final String commentaire;
  final String orientation;
  final String ageSVV;
  final String ageAppelant;
  final String sourceInfos;
  final String lieuViol;
  final String feedback;
  final String agents;
  

  FakeModel(
      {this.id,
      required this.date,
      required this.shift,
      required this.fullName,
      required this.sexe,
      required this.telephone,
      required this.lieu,
      required this.statut,
      required this.heure,
      required this.reseau,
      required this.commentaire,
      required this.orientation,
      required this.ageSVV,
      required this.ageAppelant,
      required this.sourceInfos,
      required this.lieuViol,
      required this.feedback,
      required this.agents
    });

  factory FakeModel.fromSQL(List<dynamic> row) {
    return FakeModel(
        id: row[0],
        date: row[1],
        shift: row[2],
        fullName: row[3],
        sexe: row[4],
        telephone: row[5],
        lieu: row[6],
        statut: row[7],
        heure: row[8],
        reseau: row[9],
        commentaire: row[10],
        orientation: row[11],
        ageSVV: row[12],
        ageAppelant: row[13],
        sourceInfos: row[14],
        lieuViol: row[15],
        feedback: row[16],
        agents: row[17]
    );
  }

  factory FakeModel.fromJson(Map<String, dynamic> json) {
    return FakeModel(
        id: json['id'],
        date: DateTime.parse(json['date']),
        shift: json['shift'],
        fullName: json['fullName'],
        sexe: json['sexe'],
        telephone: json['telephone'],
        lieu: json['lieu'],
        statut: json["statut"],
        heure: DateTime.parse(json['heure']),
        reseau: json["reseau"],
        commentaire: json["commentaire"],
        orientation: json["orientation"],
        ageSVV: json["ageSVV"],
        ageAppelant: json["ageAppelant"],
        sourceInfos: json["sourceInfos"],
        lieuViol: json["lieuViol"],
        feedback: json["feedback"],
        agents: json["agents"]
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'campaignName': campaignName,
  //     'imgUrl': imgUrl,
  //     'scripting': scripting,
  //     'title': title,
  //     'subTitle': subTitle,
  //     'date': date.toIso8601String(),
  //     'role': role,
  //     "telephone": telephone,
  //     'fullName': fullName,
  //     'sexe': sexe,
  //     'email': email,
  //     'date': date.toIso8601String(),
  //     'role': role,
  //     "telephone": telephone,
  //     'fullName': fullName,
  //     'sexe': sexe,
  //     'email': email
  //   };
  // }
}
