import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/fake_model.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class FakeDBRepository with ChangeNotifier {
  final String table = 'fakeData';

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();
      await connection.open();
      await connection.query('''
          CREATE TABLE IF NOT EXISTS $table(
            "id" serial primary key NOT NULL,
            "date" TIMESTAMP NOT NULL,
            "shift" VARCHAR NOT NULL,
            "fullName" VARCHAR NOT NULL,
            "sexe" VARCHAR NOT NULL,
            "telephone" VARCHAR NOT NULL,
            "lieu" VARCHAR NOT NULL,
            "statut" VARCHAR NOT NULL,
            "heure" TIMESTAMP NOT NULL,
            "reseau" VARCHAR NOT NULL,
            "commentaire" VARCHAR NOT NULL,
            "orientation" VARCHAR NOT NULL,
            "ageSVV" VARCHAR NOT NULL,
            "ageAppelant" VARCHAR NOT NULL,
            "sourceInfos" VARCHAR NOT NULL,
            "lieuViol" VARCHAR NOT NULL,
            "feedback" VARCHAR NOT NULL,
            "agents" VARCHAR NOT NULL
          );
        ''');
      return connection;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<FakeModel>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <FakeModel>{};
      var querySQL = "SELECT * FROM $table  ORDER BY \"date\" DESC;";
      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(FakeModel.fromSQL(row));
      }
      await closeConnection(connection);
      return data.toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<FakeModel>> getAllDataSearch(String query) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <FakeModel>{};
      var querySQL = "SELECT * FROM $table  ORDER BY \"date\" DESC;";
      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(FakeModel.fromSQL(row));
      }
      await closeConnection(connection);
      return data.toList().where((fakeModel) {
        final campaignNameLower = fakeModel.statut.toLowerCase();
        final searchLower = query.toLowerCase();
        return campaignNameLower.contains(searchLower);
      }).toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<FakeModel> getOneData(int id) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      List<List<dynamic>> results =
          await connection.query('SELECT * FROM $table WHERE id=$id;');

      await closeConnection(connection);

      return FakeModel.fromSQL(results[0]);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  insertData(FakeModel fakeModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var date = fakeModel.date;
      var shift = fakeModel.shift;
      var fullName = fakeModel.fullName;
      var sexe = fakeModel.sexe;
      var telephone = fakeModel.telephone;
      var lieu = fakeModel.lieu;
      var statut = fakeModel.statut;
      var reseau = fakeModel.reseau;
      var heure = fakeModel.heure;
      var commentaire = fakeModel.commentaire;
      var orientation = fakeModel.orientation;
      var ageSVV = fakeModel.ageSVV;
      var ageAppelant = fakeModel.ageAppelant;
      var sourceInfos = fakeModel.sourceInfos;
      var lieuViol = fakeModel.lieuViol;
      var feedbackdate = fakeModel.feedback;
      var agents = fakeModel.agents;

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute("""
            INSERT INTO $table VALUES (
              nextval('fakeData_id_seq'),
              '$date', '$shift', '$fullName', '$sexe','$telephone', '$lieu',
              '$statut', '$reseau', '$heure', '$commentaire', '$orientation', 
              '$ageSVV', '$ageAppelant', '$sourceInfos', '$lieuViol','$feedbackdate',
              '$agents'
            );
          """);
      });
      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  // updateData(FakeModel fakeModel) async {
  //   try {
  //     PostgreSQLConnection connection = await openConnection();
  //     var id = fakeModel.id;
  //     var date = fakeModel.date;
  //     var shift = fakeModel.shift;
  //     var fullName = fakeModel.fullName;
  //     var sexe = fakeModel.sexe;
  //     var telephone = fakeModel.telephone;
  //     var lieu = fakeModel.lieu;
  //     var statut = fakeModel.statut;
  //     var reseau = fakeModel.reseau;
  //     var heure = fakeModel.heure;
  //     var commentaire = fakeModel.commentaire;
  //     var orientation = fakeModel.orientation;
  //     var ageSVV = fakeModel.ageSVV;
  //     var ageAppelant = fakeModel.ageAppelant;
  //     var sourceInfos = fakeModel.sourceInfos;
  //     var lieuViol = fakeModel.lieuViol;
  //     var feedbackdate = fakeModel.feedback;
  //     var agents = fakeModel.agents;

  //     await connection.transaction((conn) async {
  //       // ignore: unused_local_variable
  //       var result = await conn.execute(
  //           "UPDATE $table SET \"campaignName\"='$campaignName', \"scripting\"='$scripting', \"date\"='$date', \"role\"='$role', \"telephone\"='$telephone', \"fullName\"='$fullName', \"sexe\"='$sexe', \"email\"='$email' WHERE id=$id;");
  //     });
  //     await closeConnection(connection);
  //   } on SocketException {
  //     throw Failure('Vous avez perdu internet 😒');
  //   }
  // }

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
