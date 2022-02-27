import 'dart:async';

import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/global/repository/scripting/fake_db.dart';
import 'package:crm_spx/src/global/repository/scripting/scripting_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/models/fake_model.dart';
import 'package:crm_spx/src/models/scripting_model.dart';
import 'package:crm_spx/src/pages/compaign_page/edit_camapaign_page.dart';
import 'package:crm_spx/src/pages/compaign_page/scripting_client.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/widgets/search_widget.dart';
import 'package:crm_spx/src/widgets/title_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailCampaignPage extends StatefulWidget {
  const DetailCampaignPage({Key? key, required this.campaignModel})
      : super(key: key);
  final CampaignModel campaignModel;

  @override
  _DetailCampaignPageState createState() => _DetailCampaignPageState();
}

class _DetailCampaignPageState extends State<DetailCampaignPage> {
  bool loading = false;
  Timer? debouncer;
  String query = '';

  List<ScriptingModel> scriptingList = [];

  @override
  void initState() {
    searchAchat(query);
    userPrefs();
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  String? role;

  Future userPrefs() async {
    var user = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      role = user.role;
    });
  }

  Future getData() async {
    final scripting = await ScriptingRepository().getAllDataSearch(query);
    setState(() {
      scriptingList = scripting
          .where((element) =>
              element.campaignName == widget.campaignModel.campaignName)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.campaignModel.campaignName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ScriptingClient(campaignModel: widget.campaignModel)));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleField(context, widget.campaignModel.campaignName),
                if (role == 'SuperAdmin' || role == 'Admin')
                  Row(
                    children: [
                      if (widget.campaignModel.scripting.isEmpty)
                        editCampaignWidget(),
                      deleteCampaign()
                    ],
                  )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            buildSearch(),
            const SizedBox(
              height: 20.0,
            ),
            // campaignListWidget()
          ],
        ),
      ),
    );
  }

  Widget editCampaignWidget() {
    return IconButton(
      tooltip: 'New scripting',
      icon: const Icon(Icons.edit),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Ëtes-vous sûr de créer un nouveau scripting ?'),
          content: const Text(
              'Cette actiion permet de créer un nouveau dans cette campaign'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'ok');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditCampaignPage(
                            campaignModel: widget.campaignModel)));
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteCampaign() {
    return IconButton(
        tooltip: 'Supprimer campaign',
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Ëtes-vous sûr de vouloir supprimer ceci ?'),
                content: const Text(
                    'Cette actiion supprimera toute la campaign y compris les données existantes'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await CampaignRepository()
                          .deleteData(widget.campaignModel.id!);
                      Navigator.pop(context, 'OK');
                      // Navigator.pushReplacement(context, MaterialPageRoute(
                      //   builder: ((context) => const ListCampaignPage())));
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          "${widget.campaignModel.campaignName} a été supprimé!",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
        icon: const Icon(Icons.delete));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Recherche rapide',
        onChanged: searchAchat,
      );

  Future searchAchat(String query) async => debounce(() async {
        final data = await ScriptingRepository().getAllDataSearch(query);

        if (!mounted) return;

        setState(() {
          scriptingList = data;
        });
      });

  campaignListWidget() {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final scripting = widget.campaignModel.scripting;
    scriptingList.map((e) {
        return SizedBox(
        width: double.infinity,
        child: Card(
          child: DataTable2(
            columnSpacing: 12,
            minWidth: 600,
            dataRowHeight: 100,
            empty: Text('Pas encore de reporting', style: bodyText1),
            columns: const [
              DataColumn(
                label: Text("DATE",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              // DataColumn2(
              //   size: ColumnSize.L,
              //   label: Text("Q ${s['id'] + 1}.",
              //       style: const TextStyle(
              //           fontWeight: FontWeight.w600, fontSize: 16)),
              // ),
              // DataColumn(
              //   label: Text(s['value'][0]['question'],
              //       style: const TextStyle(
              //           fontWeight: FontWeight.w600, fontSize: 16)),
              // ),
            ],
            rows: List.generate(
              e.scripting.length,
              (index) => recentFileDataRow(e.scripting[index]),
            ),
          ),
        ),
      );
    });
  }

  //  Data Table
  DataRow recentFileDataRow(s) {
    return DataRow(
      cells: [
        DataCell(
          Text(DateFormat("dd.MM.yy").format(s['date'])),
        ),
        // DataCell(
        //   Text(scriptingModel.shift),
        // ),
        // DataCell(
        //   Text(fakeModel.telephone),
        // ),
        // DataCell(
        //   Text(fakeModel.statut),
        // ),
        // DataCell(
        //   Text(DateFormat("HH:mm").format(fakeModel.heure)),
        // ),
        // DataCell(
        //   Text(fakeModel.reseau),
        // ),
        // DataCell(
        //   Text(fakeModel.agents),
        // ),
      ],
    );
  }
}
