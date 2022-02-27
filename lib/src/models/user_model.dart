class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String telephone;
  final String adresse;
  final String sexe;
  final String role;
  final String campaign;
  final String superviseur;
  final bool isOnline;
  final bool isActive;
  final DateTime createdAt;
  final String? password;

  const User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.sexe,
    required this.role,
    required this.campaign,
    required this.superviseur,
    required this.isOnline,
    required this.isActive,
    required this.createdAt,
    this.password,
  });

  factory User.fromSQL(List<dynamic> row) {
    return User(
        id: row[0],
        firstName: row[1],
        lastName: row[2],
        userName: row[3],
        email: row[4],
        telephone: row[5],
        adresse: row[6],
        sexe: row[7],
        role: row[8],
        campaign: row[9],
        superviseur: row[10],
        isOnline: row[11],
        isActive: row[12],
        createdAt: row[13],
        password: row[14]
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      userName: json["userName"],
      email: json["email"],
      telephone: json["telephone"],
      adresse: json["adresse"],
      sexe: json["sexe"],
      role: json["role"],
      campaign: json["campaign"],
      superviseur: json["superviseur"],
      isOnline: json["isOnline"],
      isActive: json["isActive"],
      createdAt: DateTime.parse(json['createdAt']),
      password: json["password"]
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'sexe': sexe,
      'role': role,
      'campaign': campaign,
      'superviseur': superviseur,
      'isOnline': isOnline,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'password': password
    };
  }
}


class UserCountModel {
  final int count;

  const UserCountModel({required this.count});

  factory UserCountModel.fromSQL(List<dynamic> row) {
    return UserCountModel(count: row[0]);
  }

  factory UserCountModel.fromJson(Map<String, dynamic> json) {
    return UserCountModel(count: json['count']);
  }

  factory UserCountModel.fromJsonSqlite(Map<String, dynamic> json) {
    return UserCountModel(count: json['COUNT(*)']);
  }

  Map<String, dynamic> toJson() {
    return {'count': count};
  }
}
