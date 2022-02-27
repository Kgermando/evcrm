import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/agenda_model.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AgendaRepository with ChangeNotifier {
  final String table = "agendas";

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();

      await connection.open();

      await connection.query('''
        CREATE TABLE IF NOT EXISTS $table(
          "id" serial primary key NOT NULL,
          "title" VARCHAR NOT NULL,
          "description" VARCHAR NOT NULL,
          "number" INT4 NOT NULL,
          "date" TIMESTAMP NOT NULL,
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

  Future<List<AgendaModel>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var data = <AgendaModel>{};

      var querySQL = "SELECT * FROM $table ORDER BY \"number\" ASC; ";

      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(AgendaModel.fromSQL(row));
      }

      await closeConnection(connection);
      return data.toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<AgendaModel> getOneData(int id) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      List<List<dynamic>> results =
          await connection.query('SELECT * FROM $table WHERE id=$id;');

      await closeConnection(connection);

      return AgendaModel.fromSQL(results[0]);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> insertData(AgendaModel agendaModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var title = agendaModel.title;
      var description = agendaModel.description;
      var number = agendaModel.number;
      var date = agendaModel.date;
      var userName = agendaModel.userName;
      var superviseur = agendaModel.superviseur;
      var campaign = agendaModel.campaign;

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute(
            "INSERT INTO $table VALUES (nextval('agendas_id_seq'), '$title', '$description', '$number', '$date', '$userName', '$superviseur', '$campaign');");
      });

      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<void> updateData(AgendaModel agendaModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var id = agendaModel.id;
      var title = agendaModel.title;
      var description = agendaModel.description;
      var number = agendaModel.number;
      var date = agendaModel.date;
      var userName = agendaModel.userName;
      var superviseur = agendaModel.superviseur;
      var campaign = agendaModel.campaign;

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute(
          "UPDATE $table SET \"title\"='$title', \"description\"='$description', \"number\"='$number', \"date\"='$date', \"userName\"='$userName', \"superviseur\"='$superviseur', \"campaign\"='$campaign' WHERE id=$id;");
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
