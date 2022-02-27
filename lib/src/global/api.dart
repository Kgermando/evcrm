import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class ConnexionDatabase extends ChangeNotifier {
  // Future<PostgreSQLConnection> connection() async {
  //   var connection = PostgreSQLConnection(
  //       "ec2-34-225-66-116.compute-1.amazonaws.com", 5432, "d29msvmr088dfp",
  //       username: "ppxjgtuvpitxjk",
  //       password:
  //           "b37e387cc07305849d91b2bc7891bd2573f99103f0c6a629a3d8cb46a90fc73c",
  //       useSSL: true);
  //   return connection;
  // }

  // Future<PostgreSQLConnection> connection() async {
  //   var connection = PostgreSQLConnection("192.168.43.225", 5432, "server",
  //       username: "server", password: "1234", useSSL: false);
  //   return connection;
  // }

  Future<PostgreSQLConnection> connection() async {
    var connection = PostgreSQLConnection("localhost", 5432, "crm",
        username: "postgres", password: "kataku", useSSL: false);
    notifyListeners();
    return connection;
  }
}
