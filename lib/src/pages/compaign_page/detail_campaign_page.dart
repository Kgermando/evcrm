import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/global/repository/scripting/scripting_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/models/scripting_model.dart';
import 'package:crm_spx/src/pages/compaign_page/edit_camapaign_page.dart';
import 'package:crm_spx/src/pages/compaign_page/scripting_client.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/widgets/search_widget.dart';
import 'package:crm_spx/src/widgets/title_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DetailCampaignPage extends StatefulWidget {
  const DetailCampaignPage({Key? key, required this.campaignModel})
      : super(key: key);
  final CampaignModel campaignModel;

  @override
  _DetailCampaignPageState createState() => _DetailCampaignPageState();
}

class _DetailCampaignPageState extends State<DetailCampaignPage> {
  bool isLoading = false;
  Timer? debouncer;
  String query = '';

  List<ScriptingModel> scriptingList = [];

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 500), ((timer) {
      searchAchat(query);
      getData();
      timer.cancel();
    }));

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
    final scripting = await ScriptingRepository().getAllData();
    setState(() {
      scriptingList = scripting;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scripting = widget.campaignModel.scripting;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.campaignModel.campaignName),
      ),
      floatingActionButton: (scripting.isNotEmpty)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScriptingClient(
                            campaignModel: widget.campaignModel)));
              },
              child: const Icon(Icons.add),
            )
          : Container(),
      body: SingleChildScrollView(
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
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        tooltip: 'Tableau de board',
                        icon: const Icon(Icons.dashboard)),
                    if (scripting.isEmpty)
                      if (role == 'SuperAdmin' || role == 'Admin')
                        editCampaignWidget(),
                    if (role == 'SuperAdmin' || role == 'Admin')
                      deleteCampaign(),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    icon: const Icon(Icons.view_array_outlined),
                    label: const Text('EXCEL')),
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                    ),
                    icon: const Icon(Icons.print),
                    label: const Text('PDF')),
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                    ),
                    icon: const Icon(Icons.list_alt_outlined),
                    label: const Text('JSON')),
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.greenAccent),
                    ),
                    icon: const Icon(Icons.explicit_outlined),
                    label: const Text('CSV')),
                TextButton.icon(
                    onPressed: () {},
                    style: const ButtonStyle(
                        // foregroundColor: MaterialStateProperty.all(Colors.white54),
                        ),
                    icon: const Icon(Icons.text_snippet_outlined),
                    label: const Text('TXT')),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            buildSearch(),
            const SizedBox(
              height: 20.0,
            ),
            (scripting.isEmpty)
                ? const Text("Generer un nouveau scripting")
                : tableScriptingWidget(),
            const SizedBox(
              height: 20.0,
            ),
            // tablee()
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

  tableScriptingWidget() {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final scripting = widget.campaignModel.scripting;
    final reponses = scriptingList
        .where((element) =>
            element.campaignName == widget.campaignModel.campaignName)
        .toList()
        .map((e) => e.scripting)
        .toList();
    // print('reponses $reponses');
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10.0,
        child: DataTable2(
          minWidth: 600,
          border: TableBorder.all(),
          empty: Text('Pas encore de scripting', style: bodyText1),
          columns: [
            DataColumn2(
              size: ColumnSize.S,
              label: AutoSizeText(
                "N°",
                maxLines: 2,
                textAlign: TextAlign.left,
                style: bodyText1!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            for (var s in scripting)
              DataColumn2(
                size: ColumnSize.L,
                label: AutoSizeText(
                  "Q ${s['id'] + 1}. ${s['value'][0]['question']}",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: bodyText1.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
          ],
          rows: List.generate(
            reponses.length,
            (index) => recentFileDataRow(reponses[index]),
          ),
        ),
      ),
    );
  }

  //  Data Table
  DataRow recentFileDataRow(reponse) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    final scriptingCampaign = widget.campaignModel.scripting;
    final reponses = scriptingList
        .where((element) =>
            element.campaignName == widget.campaignModel.campaignName)
        .toList()
        .map((e) => e.scripting)
        .toList();

    int numberQuestion = 0;
    for (var item in scriptingCampaign) {
      numberQuestion = item['id'] + 1;
    }

    int n = 1;

    // print('numberQuestion $numberQuestion');
    return DataRow(
      cells: [
        DataCell(
          Text('${n++}', style: bodyText2),
        ),
        if (reponses.isNotEmpty)
          for (var i = 0; i < numberQuestion; i++)
            DataCell(
              Text(reponse[i]['reponse'], style: bodyText2),
            ),

        if (reponses.isEmpty)
          for (var i = 0; i < numberQuestion; i++)
            DataCell(
              Text('', style: bodyText2),
            ),
        // DataCell(
        //   Text(reponse[2]['reponse'], style: bodyText2),
        // ),
      ],
    );
  }

  Widget tablee() {
    return Center(
      child: Table(
        border: TableBorder.all(),
        children: [
          buildRow(['cell 1', 'cell 2', 'cell 3'], isHeader: true),
          buildRow(['cell 1', 'cell 2', 'cell 3']),
          buildRow(['cell 1', 'cell 2', 'cell 3']),
        ],
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Text(
            cell,
            style: style,
          )),
        );
      }).toList());
}
