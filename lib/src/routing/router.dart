import 'package:crm_spx/src/navigation/layouts/layouts.dart';
import 'package:crm_spx/src/pages/agenda/list_agenda.dart';
import 'package:crm_spx/src/pages/agents/list_agent.dart';
import 'package:crm_spx/src/pages/annuaire/list_annuaire.dart';
import 'package:crm_spx/src/pages/call_page/list_call_page.dart';
import 'package:crm_spx/src/pages/compaign_page/list_campaign_page.dart';
import 'package:crm_spx/src/pages/dashboard/dashboard_page.dart';
import 'package:crm_spx/src/routing/route_names.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case layoutRoute:
      return _getPageRoute(const Layouts());
    
    case dashboardRoute:
      return _getPageRoute(const DashboardPage());

    case listCampaignRoute:
      return _getPageRoute(const ListCampaignPage());

    case callRoute:
      return _getPageRoute(const ListCallPage());

    case agendaRoute:
      return _getPageRoute(const ListAgenda());

    case annuaireRoute:
      return _getPageRoute(const ListAnnuaire());

    case userRoute:
      return _getPageRoute(const ListAgent());
      

    default:
      return _getPageRoute(const Layouts());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
