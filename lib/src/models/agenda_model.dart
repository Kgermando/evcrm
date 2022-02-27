
class AgendaModel {
  final int? id;
  final String title;
  final String description;
  final int number;
  final DateTime date;
  final String userName;
  final String superviseur;
  final String campaign;

  AgendaModel({
    this.id, 
    required this.title,
    required this.description, 
    required this.number, 
    required this.date,
    required this.userName,
    required this.superviseur,
    required this.campaign
  });

  factory AgendaModel.fromSQL(List<dynamic> row) {
    return AgendaModel(
      id: row[0],
      title: row[1],
      description: row[2],
      number: row[3],
      date: row[4],
      userName: row[5],
      superviseur: row[6],
      campaign: row[7]
    );
  }

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      number: json['number'],
      date: DateTime.parse(json['date']),
      userName: json['userName'],
      superviseur: json['superviseur'],
      campaign: json['campaign']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'number': number,
      'date': date.toIso8601String(),
      'userName': userName,
      'superviseur': superviseur,
      'campaign': campaign
    };
  }
}
