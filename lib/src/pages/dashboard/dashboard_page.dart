import 'dart:async';

import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/agenda/agenda_repository.dart';
import 'package:crm_spx/src/global/repository/annuaire/annuaire_repository.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/global/repository/users/user_repository.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:crm_spx/src/pages/dashboard/components/barre_chart.dart';
import 'package:crm_spx/src/pages/dashboard/components/card_dashboard.dart';
import 'package:crm_spx/src/pages/dashboard/components/pie_chart.dart';
import 'package:crm_spx/src/pages/dashboard/components/time_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int nombreCampaign = 0;
  int userCount = 0;
  int agendaCount = 0;
  int annuaireCount = 0;
  int agentActifCount = 0;
  int agentInActifCount = 0;
  int agentOnlineCount = 0;

  List<User> userListOnline = [];
  List<User> userListActive = [];
  List<User> userListInActive = [];

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        loadData();
      });
    });
    super.initState();
  }

  void loadData() async {
    final dataList = await CampaignRepository().getAllData();
    final user = await UserRepository().getCountUser();
    final agenda = await AgendaRepository().getAllData();
    final annuaire = await AnnuaireRepository().getAllData();
    final agentActive = await UserRepository().getAllData();
    final agentInActive = await UserRepository().getAllData();
    final agentOnline = await UserRepository().getAllData();
    setState(() {
      nombreCampaign = dataList.length;
      userCount = user.count;
      agendaCount = agenda.length;
      annuaireCount = annuaire.length;
      userListActive =
          agentActive.where((element) => element.isActive == true).toList();
      agentActifCount = userListActive.length;
      userListInActive =
          agentInActive.where((element) => element.isActive == false).toList();
      agentInActifCount = userListInActive.length;
      userListOnline =
          agentInActive.where((element) => element.isOnline == true).toList();
      agentOnlineCount = userListOnline.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        const CustomAppbar(title: 'Tableau de bord'),
        const SizedBox(height: 16.0),
        Expanded(
            child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: const [
                          CardDashboard(
                            typeCall: 'Réçus',
                            nbreCall: 610,
                            icon: Icons.phone_callback,
                            color: Colors.green,
                          ),
                          CardDashboard(
                            typeCall: 'Emis',
                            nbreCall: 226,
                            icon: Icons.phone_in_talk,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          CardDashboard(
                            typeCall: 'Rejetés',
                            nbreCall: 30,
                            icon: Icons.phone_missed,
                            color: Colors.red,
                          ),
                          CardDashboard(
                            typeCall: 'Congestions',
                            nbreCall: 21,
                            icon: Icons.settings_phone,
                            color: Colors.purple,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Responsive.isDesktop(context) ? 30.0 : 10.0,
                  ),
                  Column(
                    children: [
                      CardDashboard1(
                        typeCall: 'Campaigns',
                        nbreCall: nombreCampaign,
                        icon: Icons.campaign,
                        color: Colors.orange,
                      ),
                      Row(
                        children: [
                          CardDashboard(
                            typeCall: 'Agenda',
                            nbreCall: agendaCount,
                            icon: Icons.note_alt,
                            color: Colors.cyan,
                          ),
                          CardDashboard(
                            typeCall: 'Annuaire',
                            nbreCall: annuaireCount,
                            icon: Icons.contact_mail,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Responsive.isDesktop(context) ? 30.0 : 10.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          CardDashboard(
                            typeCall: 'Agents',
                            nbreCall: userCount,
                            icon: Icons.people_alt,
                            color: Colors.purple,
                          ),
                          CardDashboard(
                            typeCall: 'Agents online',
                            nbreCall: agentOnlineCount,
                            icon: Icons.support_agent,
                            color: Colors.green,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CardDashboard(
                            typeCall: 'Agents actifs',
                            nbreCall: agentActifCount,
                            icon: Icons.person_add,
                            color: Colors.blue,
                          ),
                          CardDashboard(
                            typeCall: 'Agents inactifs',
                            nbreCall: agentInActifCount,
                            icon: Icons.person_remove_alt_1,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Responsive.isDesktop(context) ? 30.0 : 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width / 4,
                        height: 220,
                        child: const Card(
                          elevation: 10,
                          child: TimeChart(),
                        ),
                      ),
                      // SizedBox(
                      //   width: Responsive.isDesktop(context) ? 30.0 : 10.0,
                      // ),
                      // const SizedBox(
                      //   width: 220,
                      //   height: 220,
                      //   child: Card(
                      //     elevation: 10,
                      //     child: AnalogyClock(),
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 420,
              child: Row(
                children: const [
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 10,
                      child: BarreChart(),
                    ),
                  ),
                  Expanded(
                    child: Card(elevation: 10, child: PieChart()),
                  )
                ],
              ),
            )
          ],
        ))
      ]),
    );
  }
}
