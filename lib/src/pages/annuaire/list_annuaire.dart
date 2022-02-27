import 'dart:async';

import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/annuaire/annuaire_repository.dart';
import 'package:crm_spx/src/models/annuaire_model.dart';
import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:crm_spx/src/pages/annuaire/add_annuaire.dart';
import 'package:crm_spx/src/pages/annuaire/detail_annuaire.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/widgets/search_widget.dart';
import 'package:flutter/material.dart';

final _lightColors = [
  Colors.pinkAccent.shade700,
  Colors.tealAccent.shade700,
  Colors.amber.shade700,
  Colors.lightGreen.shade700,
  Colors.lightBlue.shade700,
  Colors.orange.shade700,
];

class ListAnnuaire extends StatefulWidget {
  const ListAnnuaire({Key? key}) : super(key: key);

  @override
  _ListAnnuaireState createState() => _ListAnnuaireState();
}

class _ListAnnuaireState extends State<ListAnnuaire> {
  String query = '';
  Timer? debouncer;

  bool connectionStatus = false;

  bool isLoading = false;

  // Search
  List<AnnuaireModel> annuaireList = [];
  // Cloud
  List<AnnuaireModel> annuaireListCloud = [];
  List<AnnuaireModel> annuaireListCloudEmpty = [];
  // Local
  List<AnnuaireModel> annuaireListLocal = [];

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddAnnuaire()));
        },
        child: const Icon(Icons.person_add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppbar(title: 'Annuaires'),
          buildSearch(),
          Expanded(
              child: FutureBuilder<List<AnnuaireModel>>(
                  future: AnnuaireRepository().getAllDataSearchClient(query),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AnnuaireModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<AnnuaireModel>? annuaireModels = snapshot.data;
                      return annuaireModels!.isEmpty
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 5),
                                Center(
                                  child: Text(
                                    'Ajoutez un contact.',
                                    style: Responsive.isDesktop(context)
                                        ? const TextStyle(fontSize: 24)
                                        : const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            )
                          : Scrollbar(
                            showTrackOnHover: true,
                            child: ListView.builder(
                                itemCount: annuaireModels.length,
                                itemBuilder: (context, index) {
                                  final annuaireModel =
                                      annuaireModels[index];
                                  return buildAnnuaire(
                                      annuaireModel, index);
                                }),
                          );
                    } else if (snapshot.hasError) {
                      return Scrollbar(
                        showTrackOnHover: true,
                        child: ListView.builder(
                            itemCount: annuaireListLocal.length,
                            itemBuilder: (context, index) {
                              final annuaireModel = annuaireListLocal[index];
                              return buildAnnuaire(annuaireModel, index);
                            }),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Recherche rapide',
        onChanged: searchAchat,
      );

  Future searchAchat(String query) async => debounce(() async {
        final list = await AnnuaireRepository().getAllDataSearchClient(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          annuaireList = list;
        });
      });

  Widget buildAnnuaire(AnnuaireModel annuaireModel, int index) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    final color = _lightColors[index % _lightColors.length];

    return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailAnnuaire(annuaireModel: annuaireModel, color: color),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: ListTile(
              visualDensity: VisualDensity.comfortable,
              dense: true,
              leading: Icon(Icons.perm_contact_cal_sharp, color: color, size: 50),
              title: Text(
                annuaireModel.nomPostnomPrenom,
                style: bodyText1,
              ),
              subtitle: Text(
                annuaireModel.mobile1,
                style: bodyText2,
              ),
            ),
          ),
        ));
  }
}
