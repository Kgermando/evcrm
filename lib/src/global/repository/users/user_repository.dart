import 'dart:convert';
import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends ChangeNotifier {
  final String table = "users";

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();

      await connection.open();

      await connection.query('''
        CREATE TABLE IF NOT EXISTS $table(
          "id" serial primary key NOT NULL,
          "firstName" VARCHAR NOT NULL,
          "lastName" VARCHAR NOT NULL,
          "userName" VARCHAR NOT NULL UNIQUE,
          "email" VARCHAR NOT NULL,
          "telephone" VARCHAR NOT NULL,
          "adresse" VARCHAR NOT NULL,
          "sexe" VARCHAR NOT NULL,
          "role" VARCHAR NOT NULL,
          "campaign" VARCHAR NOT NULL,
          "superviseur" VARCHAR NOT NULL,
          "isOnline" BOOLEAN NOT NULL,
          "isActive" BOOLEAN NOT NULL,
          "createdAt" TIMESTAMP NOT NULL,
          "password" VARCHAR NOT NULL
      );
      ''');
      return connection;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<bool> login(String userName, String password) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var query =
          "SELECT * FROM $table WHERE \"userName\" ='$userName' AND \"password\" ='$password'; ";

      List<dynamic> results = await connection.query(query);

      if (results.isNotEmpty) {
        // final user = results.first;
        final dynamic user = User.fromSQL(results[0]);

        // final userMap = user.toJson();

        UserPreferences.save('tokenKey', user); // Add save user
        UserPreferences.setAuth(); // Add auth true

        print('user $user');
        // print('userMap $userMap');

        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> register(User user) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var firstName = user.firstName;
      var lastName = user.lastName;
      var userName = user.userName;
      var email = user.email;
      var telephone = user.telephone;
      var adresse = user.adresse;
      var sexe = user.sexe;
      var role = user.role;
      var campaign = user.campaign;
      var superviseur = user.superviseur;
      var isOnline = user.isOnline;
      var isActive = user.isActive;
      var createdAt = user.createdAt;
      var password = user.password;

      // if (password != passwordConfirm) {
      //   throw Failure('Le mot de passe ne correspond pas 😒');
      // }

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute(
            "INSERT INTO $table VALUES (nextval('users_id_seq'), '$firstName','$lastName','$userName','$email','$telephone', '$adresse', '$sexe', '$role', '$campaign', '$superviseur', '$isOnline', '$isActive', '$createdAt', '$password');");
      });

      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> updateData(User user) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var id = user.id;
      var firstName = user.firstName;
      var lastName = user.lastName;
      var userName = user.userName;
      var email = user.email;
      var telephone = user.telephone;
      var adresse = user.adresse;
      var sexe = user.sexe;
      var role = user.role;
      var campaign = user.campaign;
      var superviseur = user.superviseur;
      var isOnline = user.isOnline;
      var isActive = user.isActive;
      var createdAt = user.createdAt;
      var password = user.password;

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute(
            "UPDATE $table SET \"firstName\"='$firstName', \"lastName\"='$lastName', \"userName\"='$userName', \"email\"='$email', \"telephone\"='$telephone', \"adresse\"='$adresse', \"sexe\"='$sexe', \"role\"='$role', \"campaign\"='$campaign', \"superviseur\"='$superviseur', \"isOnline\"='$isOnline', \"isActive\"='$isActive', \"createdAt\"='$createdAt', \"password\"='$password' WHERE id=$id;");
      });
      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<User>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var data = <User>{};

      var _keyUser = 'tokenKey';
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyUser);
      User user = User.fromJson(jsonDecode(json!));
      String userName = user.userName;
      String campaign = user.campaign;
      String superviseur = user.superviseur;
      String role = user.role;

      if (role == 'Admin') {
        var querySQL =
            " SELECT * FROM $table WHERE \"campaign\" ='$campaign' ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      } else if (role == 'Superviseur') {
        var querySQL =
            " SELECT * FROM $table WHERE \"campaign\" ='$campaign' AND \"superviseur\" ='$superviseur' ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      } else if (role == 'Agent') {
        var querySQL =
            " SELECT * FROM $table WHERE \"campaign\" ='$campaign' AND \"superviseur\" ='$superviseur' AND \"userName\" ='$userName' ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      } else if (role == 'SuperAdmin') {
        var querySQL = " SELECT * FROM $table ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      }

      await closeConnection(connection);
      return data.toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<User>> getAllDataSearch(String query) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <User>{};

      var _keyUser = 'tokenKey';
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyUser);
      User user = User.fromJson(jsonDecode(json!));
      String campaign = user.campaign;
      String superviseur = user.superviseur;
      String role = user.role;
      String userName = user.userName;

      if (role == 'Admin') {
        var querySQL =
            "SELECT * FROM $table WHERE \"campaign\" ='$campaign' ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      } else if (role == 'Superviseur') {
        var querySQL =
            "SELECT * FROM $table WHERE \"campaign\" ='$campaign' AND \"superviseur\" ='$superviseur' ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      } else if (role == 'Agent') {
        var querySQL =
            "SELECT * FROM $table WHERE \"campaign\" ='$campaign' AND \"superviseur\" ='$superviseur' AND \"userName\" ='$userName' ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      } else if (role == 'SuperAdmin') {
        var querySQL = "SELECT * FROM $table ORDER BY \"createdAt\" DESC; ";

        List<List<dynamic>> results = await connection.query(querySQL);
        for (var row in results) {
          data.add(User.fromSQL(row));
        }
      }

      await closeConnection(connection);

      return data.toList().where((user) {
        final firstNameLower = user.firstName.toLowerCase();
        final lastNameLower = user.lastName.toLowerCase();
        final telephoneLower = user.telephone.toLowerCase();
        final sexeLower = user.sexe.toLowerCase();
        final superviseurLower = user.superviseur.toLowerCase();
        final roleLower = user.role.toLowerCase();
        final searchLower = query.toLowerCase();

        return firstNameLower.contains(searchLower) ||
            lastNameLower.contains(searchLower) ||
            telephoneLower.contains(searchLower) ||
            roleLower.contains(searchLower) ||
            sexeLower.contains(searchLower) ||
            superviseurLower.contains(searchLower);
      }).toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<UserCountModel> getCountUser() async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <UserCountModel>{};
      var querySQL =
          " SELECT COUNT(*) FROM $table; ";

      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(UserCountModel.fromSQL(row));
      }
      notifyListeners();
      await closeConnection(connection);
      return data.single;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> deleteData(int id) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute('DELETE FROM $table WHERE id=$id;');
      });
      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future closeConnection(PostgreSQLConnection connection) async {
    await connection.close();
  }
}
