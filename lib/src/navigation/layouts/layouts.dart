import 'package:crm_spx/locator.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/navigation/drawer/drawer_menu.dart';
import 'package:crm_spx/src/provider/controller.dart';
import 'package:crm_spx/src/routing/route_names.dart';
import 'package:crm_spx/src/routing/router.dart';
import 'package:crm_spx/src/services/navigation_service.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Layouts extends StatefulWidget {
  const Layouts({Key? key}) : super(key: key);

  @override
  State<Layouts> createState() => _LayoutsState();
}

class _LayoutsState extends State<Layouts> {
  @override
  void initState() {
    super.initState();
    userPrefs();
  }

  bool? auth;

  Future userPrefs() async {
    var result = await UserPreferences.getAuth();
    if (result) {
      if (!mounted) return;
      setState(() {
        auth = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<Controller>().scaffoldKey,
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: DrawerMenu(),
              ),
            Expanded(
              flex: 5,
              child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: dashboardRoute
              ),
            )
          ],
        ),
      ));
  }
}
