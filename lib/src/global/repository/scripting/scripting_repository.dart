import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/scripting_model.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class ScriptingRepository with ChangeNotifier {
  final String table = 'scripting';

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();
      await connection.open();
      await connection.query('''
          CREATE TABLE IF NOT EXISTS $table(
            "id" serial primary key NOT NULL,
            "campaignName" VARCHAR NOT NULL,
            "scripting" JSON,
            "date" TIMESTAMP NOT NULL,
            "role" VARCHAR NOT NULL,
            "userName" VARCHAR NOT NULL,
            "superviseur" VARCHAR NOT NULL
          );
        ''');
      return connection;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<ScriptingModel>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <ScriptingModel>{};
      var querySQL = "SELECT * FROM $table  ORDER BY \"date\" DESC;";
      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(ScriptingModel.fromSQL(row));
      }
      await closeConnection(connection);
      return data.toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<ScriptingModel>> getAllDataSearch(String query) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <ScriptingModel>{};
      var querySQL = "SELECT * FROM $table  ORDER BY \"date\" DESC;";
      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(ScriptingModel.fromSQL(row));
      }
      await closeConnection(connection);
      return data.toList().where((scriptingModel) {
        final campaignNameLower = scriptingModel.campaignName.toLowerCase();
        final searchLower = query.toLowerCase();
        return campaignNameLower.contains(searchLower);
      }).toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<ScriptingModel> getOneData(int id) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      List<List<dynamic>> results =
          await connection.query('SELECT * FROM $table WHERE id=$id;');

      await closeConnection(connection);

      return ScriptingModel.fromSQL(results[0]);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  insertData(ScriptingModel scriptingModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var campaignName = scriptingModel.campaignName;
      var scripting = scriptingModel.scripting;
      var date = scriptingModel.date;
      var role = scriptingModel.role;
      var userName = scriptingModel.userName;
      var superviseur = scriptingModel.superviseur;

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute("""
            INSERT INTO $table VALUES (
              nextval('scripting_id_seq'),
              '$campaignName', '$scripting', 
              '$date', '$role', '$userName', '$superviseur'
            );
          """);
      });
      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  updateData(ScriptingModel scriptingModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var id = scriptingModel.id;
      var campaignName = scriptingModel.campaignName;
      var scripting = scriptingModel.scripting;
      var date = scriptingModel.date;
      var role = scriptingModel.role;
      var userName = scriptingModel.userName;
      var superviseur = scriptingModel.superviseur;

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute(
            "UPDATE $table SET \"campaignName\"='$campaignName', \"scripting\"='$scripting', \"date\"='$date', \"role\"='$role', \"userName\"='$userName', \"superviseur\"='$superviseur' WHERE id=$id;");
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