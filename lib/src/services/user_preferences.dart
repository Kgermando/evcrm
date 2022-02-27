import 'dart:convert';

import 'package:crm_spx/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  static const tokenKey = 'tokenKey';

  static Future<User> read() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(tokenKey);
    if (json != null) {
      User user = User.fromJson(jsonDecode(json)); 
      // print("User $user");
      return user;
    } else {
      // Si le user n'est pas connecté
      final user = User(
        firstName: 'firstName',
        lastName: 'lastName',
        userName: 'userName',
        email: 'email',
        telephone: 'telephone',
        adresse: 'adresse',
        sexe: 'sexe',
        role: 'role',
        campaign: 'campaign',
        superviseur: 'superviseur',
        isOnline: false, // suivre l'enregistrement
        isActive: false,
        createdAt: DateTime.now());
      return user;
    }
  }

  static save(String key, User value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authJWT = prefs.getBool("authJWT") ?? false;
    // print('authJWT $authJWT');
    return authJWT;
  }

  static setAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("authJWT", true);
  }

  static Future<bool> removeAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authJWT = await prefs.remove("authJWT");
    // print('authJWT $authJWT');
    return authJWT;
  }
}
