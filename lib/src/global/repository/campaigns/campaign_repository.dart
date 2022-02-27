import 'dart:io';

import 'package:crm_spx/src/global/api.dart';
import 'package:crm_spx/src/global/handler.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class CampaignRepository with ChangeNotifier {
  final String table = 'campaigns';

  Future<PostgreSQLConnection> openConnection() async {
    try {
      var connection = await ConnexionDatabase().connection();
      await connection.open();
      await connection.query('''
          CREATE TABLE IF NOT EXISTS $table(
            "id" serial primary key NOT NULL,
            "campaignName" VARCHAR NOT NULL,
            "scripting" JSON,
            "title" VARCHAR NOT NULL,
            "subTitle" VARCHAR NOT NULL,
            "date" TIMESTAMP NOT NULL,
            "userName" VARCHAR NOT NULL,
            "superviseur" VARCHAR NOT NULL
          );
        ''');
      return connection;
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }



  Future<List<CampaignModel>> getAllData() async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <CampaignModel>{};
      var querySQL =
          "SELECT * FROM $table  ORDER BY \"date\" DESC;";
      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(CampaignModel.fromSQL(row));
      }
      await closeConnection(connection);
      return data.toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<List<CampaignModel>> getAllDataSearch(String query) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var data = <CampaignModel>{};
      var querySQL = "SELECT * FROM $table  ORDER BY \"date\" DESC;";
      List<List<dynamic>> results = await connection.query(querySQL);
      for (var row in results) {
        data.add(CampaignModel.fromSQL(row));
      }
      await closeConnection(connection);
      return data.toList().where((campaignModel) {
        final campaignNameLower = campaignModel.campaignName.toLowerCase();
        final searchLower = query.toLowerCase();
        return campaignNameLower.contains(searchLower);
      }).toList();
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  Future<CampaignModel> getOneData(int id) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      List<List<dynamic>> results =
          await connection.query('SELECT * FROM $table WHERE id=$id;');

      await closeConnection(connection);

      return CampaignModel.fromSQL(results[0]);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  insertData(CampaignModel campaignModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();

      var campaignName = campaignModel.campaignName;
      var scripting = campaignModel.scripting;
      var title = campaignModel.title;
      var subTitle = campaignModel.subTitle;
      var date = campaignModel.date;
      var userName = campaignModel.userName;
      var superviseur = campaignModel.superviseur;

      await connection.transaction((ctx) async {
        // ignore: unused_local_variable
        var result = await ctx.execute(
          """
            INSERT INTO $table VALUES (
              nextval('campaigns_id_seq'),
              '$campaignName', '$scripting', '$title', 
              '$subTitle', '$date', '$userName', '$superviseur'
            );
          """);
      });
      await closeConnection(connection);
    } on SocketException {
      throw Failure('Vous avez perdu internet 😒');
    }
  }

  updateData(CampaignModel campaignModel) async {
    try {
      PostgreSQLConnection connection = await openConnection();
      var id = campaignModel.id;
      var campaignName = campaignModel.campaignName;
      var scripting = campaignModel.scripting;
      var title = campaignModel.title;
      var subTitle = campaignModel.subTitle;
      var date = campaignModel.date;
      var userName = campaignModel.userName;
      var superviseur = campaignModel.superviseur;

      await connection.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute(
          "UPDATE $table SET \"campaignName\"='$campaignName', \"scripting\"='$scripting', \"title\"='$title', \"subTitle\"='$subTitle', \"date\"='$date', \"userName\"='$userName', \"superviseur\"='$superviseur' WHERE id=$id;");
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
