import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/locator.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/navigation/drawer/drawer_list_tile.dart';
import 'package:crm_spx/src/pages/auth/profile_auth.dart';
import 'package:crm_spx/src/provider/app_provider.dart';
import 'package:crm_spx/src/routing/enum.dart';
import 'package:crm_spx/src/routing/route_names.dart';
import 'package:crm_spx/src/services/navigation_service.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool connectionStatus = false;

  final ScrollController _controller = ScrollController();

  String? firstName;
  String? lastName;
  String? role;

  @override
  void initState() {
    userPrefs();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future userPrefs() async {
    var user = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      firstName = user.firstName;
      lastName = user.lastName;
      role = user.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Scrollbar(
      isAlwaysShown: true,
      // controller: _controller,
      child: Drawer(
        child: ListView(
          // controller: _controller,
          children: [
            FutureBuilder<User?>(
                future: UserPreferences.read(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User? userInfo = snapshot.data;
                    if (userInfo != null) {
                      var userData = userInfo;
                      final String firstLettter = userData.firstName[0];
                      final String firstLettter2 = userData.lastName[0];
                      return InkWell(
                        onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.brown.shade800,
                              child: Text(
                                '${firstLettter.toUpperCase()}${firstLettter2.toUpperCase()}',
                                style: const TextStyle(fontSize: 50.0),
                              ),
                            ),
                            ListTile(
                              hoverColor: Colors.blue.shade700,
                              title: AutoSizeText(
                                "${userData.firstName} ${userData.lastName}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                  style: bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              subtitle: AutoSizeText(
                                userData.role.toUpperCase(),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: bodyText1.copyWith(
                                  fontSize: 12,
                                  color: Colors.blueGrey.shade700,
                                    fontWeight: FontWeight.w400
                                )
                              ),
                              trailing: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return const AutoSizeText(
                    "Pas de données sur l'utilisateur",
                    maxLines: 2,
                  );
                }),
            const SizedBox(
              height: 30.0,
            ),
            DrawerListTile(
              title: 'Dashboard',
              icon: Icons.dashboard,
              active: appProvider.currentPage == DisplayPage.dashboard,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.dashboard);
                locator<NavigationService>().navigateTo(dashboardRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerListTile(
              title: 'Campaigns',
              icon: Icons.campaign,
              active: appProvider.currentPage == DisplayPage.listCampaign,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.listCampaign);
                locator<NavigationService>().navigateTo(listCampaignRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerListTile(
              title: 'Calls',
              icon: Icons.phone,
              active: appProvider.currentPage == DisplayPage.call,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.call);
                locator<NavigationService>().navigateTo(callRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerListTile(
              title: 'Agenda',
              icon: Icons.note_alt,
              active: appProvider.currentPage == DisplayPage.agenda,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.agenda);
                locator<NavigationService>().navigateTo(agendaRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerListTile(
              title: 'Annuiares',
              icon: Icons.contact_phone,
              active: appProvider.currentPage == DisplayPage.annuaire,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.annuaire);
                locator<NavigationService>().navigateTo(annuaireRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerListTile(
              title: 'Reporting',
              icon: Icons.desktop_windows,
              active: appProvider.currentPage == DisplayPage.annuaire,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.annuaire);
                locator<NavigationService>().navigateTo(annuaireRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerListTile(
              title: 'Users',
              icon: Icons.people,
              active: appProvider.currentPage == DisplayPage.users,
              tap: () {
                appProvider.changeCurrentPage(DisplayPage.users);
                locator<NavigationService>().navigateTo(userRoute);
                if (!Responsive.isDesktop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),


            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            // const Divider(
            //   color: Colors.black87,
            // ),
            logoWidget()
          ],
        ),
      ),
    );
  }

  Widget logoWidget() {
    var height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Image.asset(
      "assets/images/spx.png",
      height: Responsive.isDesktop(context) ? 50 : height / 10,
      width: size.width,
    );
  }
}
