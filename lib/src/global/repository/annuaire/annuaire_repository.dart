import 'dart:convert';
import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/annuaire_model.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnuaireRepository with ChangeNotifier {
  final String table = 'annuaire';

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();

      await connection.open();

      await connection.query('''
        CREATE TABLE IF NOT EXISTS $table(
          "id" serial primary key NOT NULL,
          "categorie" VARCHAR NOT NULL,
          "nomPostnomPrenom" VARCHAR NOT NULL,
          "email" VARCHAR,
          "mobile1" VARCHAR NOT NULL,
          "mobile2" VARCHAR,
          "secteurActivite" VARCHAR,
          "nomEntreprise" VARCHAR,
          "grade" VARCHAR,
          "adresseEntreprise" VARCHAR,
          "userName" VARCHAR NOT NULL,
          "superviseur" VARCHAR NOT NULL,
          "campaign" VARCHAR NOT NULL
      );
      ''');
      return connection;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<AnnuaireModel>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <AnnuaireModel>{};

      var _keyUser = 'tokenKey';
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyUser);

      if (json != null) {
        User user = User.fromJson(jsonDecode(json));
        String userName = user.userName;
        String role = user.role;
        String superviseur = user.superviseur;

        if (role == 'Admin') {
          var querySQL = "SELECT * FROM $table  ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        } else if (role == 'Superviseur') {
          var querySQL =
              "SELECT * FROM $table WHERE \"superviseur\"='$superviseur'  ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        } else if (role == 'Agent') {
          var querySQL =
              "SELECT * FROM $table WHERE \"userName\"='$userName' ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        } else if (role == 'SuperAdmin') {
          var querySQL = "SELECT * FROM $table ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        }
      }

      await closeConnection(connection);

      return data.toList().toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<AnnuaireModel>> getAllDataSearchClient(String query) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <AnnuaireModel>{};

      var _keyUser = 'tokenKey';
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyUser);

      if (json != null) {
        User user = User.fromJson(jsonDecode(json));
        String userName = user.userName;
        String role = user.role;
        String superviseur = user.superviseur;

        if (role == 'Admin') {
          var querySQL =
              "SELECT * FROM $table  ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        } else if (role == 'Superviseur') {
          var querySQL =
              "SELECT * FROM $table WHERE \"superviseur\"='$superviseur'  ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        } else if (role == 'Agent') {
          var querySQL =
              "SELECT * FROM $table WHERE \"userName\"='$userName' ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        } else if (role == 'SuperAdmin') {
          var querySQL =
              "SELECT * FROM $table ORDER BY \"nomPostnomPrenom\" ASC;";
          List<List<dynamic>> results = await connection.query(querySQL);
          for (var row in results) {
            data.add(AnnuaireModel.fromSQL(row));
          }
        }
      }

      await closeConnection(connection);

      return data.toList().where((value) {
        final categorieLower = value.categorie.toLowerCase();
        final nomPostnomPrenomLower = value.nomPostnomPrenom.toLowerCase();
        final mobile1Lower = value.mobile1.toLowerCase();
        final mobile2Lower = value.mobile2.toLowerCase();
        final secteurActiviteLower = value.secteurActivite.toLowerCase();
        final searchLower = query.toLowerCase();
        return categorieLower.contains(searchLower) ||
            nomPostnomPrenomLower.contains(searchLower) ||
            mobile1Lower.contains(searchLower) ||
            mobile2Lower.contains(searchLower) ||
            secteurActiviteLower.contains(searchLower);
      }).toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  
  Future<AnnuaireModel> getOneData(int id) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      List<List<dynamic>> results =
          await connection.query('SELECT * FROM $table WHERE id=$id;');

      await closeConnection(connection);

      return AnnuaireModel.fromSQL(results[0]);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  insertData(AnnuaireModel annuaireModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var categorie = annuaireModel.categorie;
      var nomPostnomPrenom = annuaireModel.nomPostnomPrenom;
      var email = annuaireModel.email;
      var mobile1 = annuaireModel.mobile1;
      var mobile2 = annuaireModel.mobile2;
      var secteurActivite = annuaireModel.secteurActivite;
      var nomEntreprise = annuaireModel.nomEntreprise;
      var grade = annuaireModel.grade;
      var adresseEntreprise = annuaireModel.adresseEntreprise;
      var userName = annuaireModel.userName;
      var superviseur = annuaireModel.superviseur;
      var campaign = annuaireModel.campaign;

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute(
            "INSERT INTO $table VALUES (nextval('annuaire_id_seq'), '$categorie', '$nomPostnomPrenom', '$email', '$mobile1', '$mobile2', '$secteurActivite' , '$nomEntreprise', '$grade', '$adresseEntreprise', '$userName', '$superviseur', '$campaign');");
      });

      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  updateData(AnnuaireModel annuaireModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var id = annuaireModel.id;
      var categorie = annuaireModel.categorie;
      var nomPostnomPrenom = annuaireModel.nomPostnomPrenom;
      var email = annuaireModel.email;
      var mobile1 = annuaireModel.mobile1;
      var mobile2 = annuaireModel.mobile2;
      var secteurActivite = annuaireModel.secteurActivite;
      var nomEntreprise = annuaireModel.nomEntreprise;
      var grade = annuaireModel.grade;
      var adresseEntreprise = annuaireModel.adresseEntreprise;
      var userName = annuaireModel.userName;
      var superviseur = annuaireModel.superviseur;
      var campaign = annuaireModel.campaign;

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute(
            "UPDATE $table SET \"categorie\"='$categorie', \"nomPostnomPrenom\"='$nomPostnomPrenom', \"email\"='$email', \"mobile1\"='$mobile1', \"mobile2\"='$mobile2', \"secteurActivite\"='$secteurActivite', \"nomEntreprise\"='$nomEntreprise' , \"grade\"='$grade', \"adresseEntreprise\"='$adresseEntreprise', \"userName\"='$userName', \"superviseur\"='$superviseur', \"campaign\"='$campaign' WHERE id=$id;");
      });
      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  deleteData(int id) async {
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
