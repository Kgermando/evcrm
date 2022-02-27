class SuperviseurModel {
  final int? id;
  final String name;
  final DateTime date;

  SuperviseurModel({
    this.id, 
    required this.name, 
    required this.date
    }
  );


  factory SuperviseurModel.fromSQL(List<dynamic> row) {
    return SuperviseurModel(
        id: row[0],
        name: row[1],
        date: row[2]
    );
  }

  factory SuperviseurModel.fromJson(Map<String, dynamic> json) {
    return SuperviseurModel(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String()
    };
  }
}