import 'package:crm_spx/src/models/menu_item.dart';
import 'package:crm_spx/src/pages/auth/profile_auth.dart';
import 'package:crm_spx/src/pages/chat/chat.dart';
import 'package:crm_spx/src/pages/screens/help_screen..dart';
import 'package:crm_spx/src/pages/screens/settings_screen.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

class MenuOptions with ChangeNotifier {
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, size: 20),
          const SizedBox(width: 12),
          Text(item.text)
        ],
      ));

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemProfile:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;

      case MenuItems.itemChate:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Chat()));
        break;

      case MenuItems.itemHelp:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HelpScreen()));
        break;

      case MenuItems.itemSettings:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsScreen()));
        break;

      case MenuItems.itemLogout:
        // Remove stockage jwt here.
        UserPreferences.removeAuth();
        UserPreferences.remove('tokenKey');
        Phoenix.rebirth(context);
    }
  }
}
