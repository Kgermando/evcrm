class CampaignModel {
  final int? id;
  final String campaignName;
  final List scripting;
  final String title;
  final String subTitle;
  final DateTime date;
  final String userName;
  final String superviseur;

  CampaignModel(
      {this.id,
      required this.campaignName,
      required this.scripting,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.userName,
      required this.superviseur,
    }
  );


  factory CampaignModel.fromSQL(List<dynamic> row) {
    return CampaignModel(
        id: row[0],
        campaignName: row[1],
        scripting: row[2],
        title: row[3],
        subTitle: row[4],
        date: row[5],
        userName: row[6],
        superviseur: row[7]
    );
  }

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      campaignName: json['campaignName'],
      scripting: json['scripting'],
      title: json['title'],
      subTitle: json['subTitle'],
      date: DateTime.parse(json['date']),
      userName: json["userName"],
      superviseur: json["superviseur"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignName': campaignName,
      'scripting': scripting,
      'title': title,
      'subTitle': subTitle,
      'date': date.toIso8601String(),
      'userName': userName,
      "superviseur": superviseur
    };
  }

}
