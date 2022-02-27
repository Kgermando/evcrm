import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/superviseur_model.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class SuperviseurRepository extends ChangeNotifier {
  final String table = 'superviseur';

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();

      await connection.open();

      await connection.query('''
        CREATE TABLE IF NOT EXISTS $table(
          "id" serial primary key NOT NULL,
          "name" VARCHAR NOT NULL,
          "date" TIMESTAMP NOT NULL
      );
      ''');
      return connection;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<SuperviseurModel>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var data = <SuperviseurModel>{};

      var querySQL = "SELECT * FROM $table; ";

      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(SuperviseurModel.fromSQL(row));
      }

      notifyListeners();
      await closeConnection(connection);
      return data.toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> insertData(SuperviseurModel superviseurModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var name = superviseurModel.name;
      var date = superviseurModel.date;

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute(
            "INSERT INTO $table VALUES (nextval('superviseur_id_seq'), '$name', '$date');");
      });

      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> updateData(SuperviseurModel superviseurModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var id = superviseurModel.id;
      var name = superviseurModel.name;
      var date = superviseurModel.date;

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute(
            "UPDATE $table SET \"name\"='$name', \"date\"='$date' WHERE id=$id;");
      });
      await closeConnection(connection);
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
