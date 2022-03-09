import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/global/repository/superviseur/superviseur_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/models/superviseur_model.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:crm_spx/src/pages/compaign_page/detail_campaign_page.dart';
import 'package:crm_spx/src/widgets/title_page.dart';
import 'package:flutter/material.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.red,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent,
  Colors.tealAccent,
  Colors.orange,
  Colors.green,
  Colors.purple,
  Colors.brown,
  Colors.blue,
  Colors.grey,
  Colors.blueGrey,
  Colors.deepOrange,
];

class ListCampaignPage extends StatefulWidget {
  const ListCampaignPage({Key? key}) : super(key: key);

  @override
  _ListCampaignPageState createState() => _ListCampaignPageState();
}

class _ListCampaignPageState extends State<ListCampaignPage> {
  final _form = GlobalKey<FormState>();
  final _formSuperviseur = GlobalKey<FormState>();

  bool isLoading = false;
  bool isLoadingSuperviseur = false;

  String query = '';
  Timer? debouncer;

  final ScrollController _controllerTwo = ScrollController();

  List<SuperviseurModel> superviseurList = [];

  int nombreCampaign = 0;

  final nameController = TextEditingController();
  String? superviseur;

  // SuperViseur
  String? nameSuperviseur;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        loadData();
      });
    });
    userPrefs();
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

  Future loadData() async {
    final dataList = await CampaignRepository().getAllDataSearch(query);
    final superviseur = await SuperviseurRepository().getAllData();
    setState(() {
      nombreCampaign = dataList.length;
      superviseurList = superviseur;
    });
  }

  String? role;

  Future userPrefs() async {
    var user = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      role = user.role;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
        floatingActionButton: (role == 'SuperAdmin' || role == 'Admin') ? FloatingActionButton(
          // backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          tooltip: 'Ajoutez une nouvelle campaign',
          onPressed: () {
            showModalBottomSheet(
                // enableDrag: false,
                // isDismissible: false,
                context: context,
                builder: (context) => Container(
                    margin: const EdgeInsets.all(20.0), child: buildSheet()));
          },
          child: Row(
            children: const [
              Icon(Icons.add),
              Icon(Icons.campaign),
            ],
          ),
        ) : Container(),
        body: Column(
          children: [
            const CustomAppbar(title: 'Campaigns'),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
                  child: AutoSizeText(
                    'Vous avez $nombreCampaign campaigns',
                    style: headline6!.copyWith(color: Colors.teal),
                  ),
                )
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder<List<CampaignModel>>(
                        future: CampaignRepository().getAllDataSearch(query),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CampaignModel>> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.hasData) {
                            List<CampaignModel>? campaigns = snapshot.data;
                            return campaigns!.isEmpty
                                ? const Center(
                                    child: Text('Pas encore de campaign'),
                                  )
                                : Scrollbar(
                                    controller: _controllerTwo,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        children: List.generate(
                                          campaigns.length,
                                          (index) {
                                            final campaign = campaigns[index];
                                            final color = _lightColors[
                                                index % _lightColors.length];
                                            return campaignCard(
                                                campaign, color);
                                          },
                                        ),
                                      ),
                                    ));
                          }
                          return loading();
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget campaignCard(CampaignModel campaignModel, Color color) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Column(
      children: [
        Card(
          elevation: 10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailCampaignPage(campaignModel: campaignModel)));
            },
            child: Container(
              width: 150,
              height: 150,
              color: color,
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.campaign,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
            width: 150,
            child: Text(
              campaignModel.campaignName,
              textAlign: TextAlign.center,
              style: headline6!.copyWith(fontSize: 14.0),
              overflow: TextOverflow.visible,
            ))
      ],
    );
  }

  Widget buildSheet() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: Responsive.isDesktop(context) ? size.width / 4 : size.width,
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.teal, width: 15),
      )),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _form,
        child: ListView(
          children: [
            titleField(context, 'New campaign'),
            TextFormField(
              controller: nameController,
              maxLength: 150,
              decoration: InputDecoration(
                labelText: 'Campaign name',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) => value != null && value.isEmpty
                  ? 'Ce champ ne peut pâs être vide'
                  : null,
              onChanged: (value) {
                setState(() {
                  nameController.text = value;
                  nameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: nameController.text.length));
                });
              },
            ),
            superviseurField(),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.teal),
                ),
                onPressed: () {
                  var form = _form.currentState!;
                  if (form.validate()) {
                    setState(() => isLoading = true);
                    submitData();
                    form.reset();
                  }
                },
                child: isLoading
                    ? loading()
                    : Text(
                        'Soumettre',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      )),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget superviseurField() {
    var s = superviseurList.map((e) => e.name);
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Superviseur',
                labelStyle: const TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                contentPadding: const EdgeInsets.only(left: 5.0),
              ),
              value: superviseur,
              isExpanded: true,
              items: s.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) => value != null && value.isEmpty
                  ? 'Le superviseur est obligatoire'
                  : null,
              onChanged: (value) {
                setState(() {
                  superviseur = value;
                });
              },
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () => _showMyDialog(), icon: const Icon(Icons.add)))
      ],
    );
  }

  Future<void> submitData() async {
    final campaignModel = CampaignModel(
        campaignName: nameController.text,
        scripting: [],
        title: '',
        subTitle: '',
        date: DateTime.now(),
        userName: '',
        superviseur: '');

    await CampaignRepository().insertData(campaignModel);
    Navigator.of(context).pop();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${campaignModel.campaignName} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }

  //  Add superviseur
  _showMyDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Ajout Superviseur'),
        content: Form(key: _formSuperviseur, child: nameSuperviseurField()),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final form = _formSuperviseur.currentState!;
              if (form.validate()) {
                setState(() => isLoadingSuperviseur = true);
                form.save();
                submitSuperviseur();
                form.reset();
                Navigator.pop(context, 'OK');
                setState(() => isLoadingSuperviseur = false);
              }
            },
            child:
                isLoadingSuperviseur ? loadingMini() : const Text('Soumettre'),
          ),
        ],
      ),
    );
  }

  Widget nameSuperviseurField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Nom du superviseur',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) => setState(() => nameSuperviseur = value.trim()),
      ),
    );
  }

  Future submitSuperviseur() async {
    final superviseurModel = SuperviseurModel(
        name: nameSuperviseur.toString(), date: DateTime.now());
    await SuperviseurRepository().insertData(superviseurModel);
  }
}
