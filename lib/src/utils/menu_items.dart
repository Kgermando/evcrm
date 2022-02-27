import 'package:crm_spx/src/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemProfile,
    itemChate,
    itemHelp,
    itemSettings,
  ];

  static const List<MenuItem> itemsSecond = [
    itemLogout,
  ];

  static const itemProfile = MenuItem(
    text: 'Profil',
    icon: Icons.person,
  );

  static const itemChate = MenuItem(
    text: 'Chat',
    icon: Icons.chat,
  );

  static const itemHelp = MenuItem(text: 'Aide', icon: Icons.help);

  static const itemSettings = MenuItem(
    text: 'Settings',
    icon: Icons.settings,
  );

  static const itemLogout = MenuItem(text: 'Déconnexion', icon: Icons.logout);
}

