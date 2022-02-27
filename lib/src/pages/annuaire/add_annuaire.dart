import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/annuaire/annuaire_repository.dart';
import 'package:crm_spx/src/models/annuaire_model.dart';
import 'package:crm_spx/src/pages/annuaire/list_annuaire.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/annuaire_list.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAnnuaire extends StatefulWidget {
  const AddAnnuaire({Key? key}) : super(key: key);

  @override
  _AddAnnuaireState createState() => _AddAnnuaireState();
}

class _AddAnnuaireState extends State<AddAnnuaire> {
  final _formKey = GlobalKey<FormState>();

  final List<String> roles = AnnuiareListCategorie().roles;

  bool isLoading = false;

  bool connectionStatus = false;

  String? categorie;
  String? nomPostnomPrenom;
  String? email;
  String? mobile1;
  String? mobile2;
  String? secteurActivite;
  String? nomEntreprise;
  String? grade;
  String? adresseEntreprise;
  String? userName;
  String? superviseur;
  String? campaign;

  @override
  void initState() {
    super.initState();
    userPrefs();
  }

  Future userPrefs() async {
    var user = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      userName = user.userName;
      superviseur = user.superviseur;
      campaign = user.campaign;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Nouveau contact',
            style: Responsive.isDesktop(context)
                ? const TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0)
                : bodyText1,
          ),
          elevation: 0,
        ),
        body: Scrollbar(
          showTrackOnHover: true,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: Responsive.isDesktop(context)
                  ? const EdgeInsets.all(40.0)
                  : const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Responsive.isDesktop(context)
                        ? Column(children: [
                            // categorieField(),
                            Row(
                              children: [
                                Expanded(
                                  child: nomPostnomPrenomField(),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: emailField(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: mobile1Field()),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(child: mobile2Field()),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: secteurActiviteField()),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(child: nomEntrepriseField()),
                              ],
                            ),
                            gradeField(),
                            adresseEntrepriseField(),
                            const SizedBox(
                              height: 10.0,
                            ),
                            updateForm()
                          ])
                        : Column(
                            children: [
                              // categorieField(),
                              nomPostnomPrenomField(),
                              emailField(),
                              mobile1Field(),
                              mobile2Field(),
                              secteurActiviteField(),
                              nomEntrepriseField(),
                              gradeField(),
                              adresseEntrepriseField(),
                              const SizedBox(
                                height: 10.0,
                              ),
                              updateForm()
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categorieField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Type de contact',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: categorie,
        isExpanded: true,
        items: roles.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            categorie = value;
          });
        },
      ),
    );
  }

  Widget nomPostnomPrenomField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Nom complet',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ce champ est obligatoire';
          }
          return null;
        },
        onChanged: (value) => setState(() {
          nomPostnomPrenom = value;
        }),
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Ce champ est obligatoire';
        //   }
        //   return null;
        // },
        onChanged: (value) => setState(() {
          email = value;
        }),
      ),
    );
  }

  Widget mobile1Field() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Téléphone 1',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ce champ est obligatoire';
          }
          return null;
        },
        onChanged: (value) => setState(() {
          mobile1 = value;
        }),
      ),
    );
  }

  Widget mobile2Field() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Téléphone 2',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Ce champ est obligatoire';
        //   }
        //   return null;
        // },
        onChanged: (value) => setState(() {
          mobile2 = value;
        }),
      ),
    );
  }

  Widget secteurActiviteField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Secteur d\'activité',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Ce champ est obligatoire';
        //   }
        //   return null;
        // },
        onChanged: (value) => setState(() {
          secteurActivite = value;
        }),
      ),
    );
  }

  Widget nomEntrepriseField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Entreprise ou business',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Ce champ est obligatoire';
        //   }
        //   return null;
        // },
        onChanged: (value) => setState(() {
          nomEntreprise = value;
        }),
      ),
    );
  }

  Widget gradeField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Grade ou fonction',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Ce champ est obligatoire';
        //   }
        //   return null;
        // },
        onChanged: (value) => setState(() {
          grade = value;
        }),
      ),
    );
  }

  Widget adresseEntrepriseField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Adresse',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Ce champ est obligatoire';
        //   }
        //   return null;
        // },
        onChanged: (value) => setState(() {
          adresseEntreprise = value;
        }),
      ),
    );
  }

  Widget updateForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 5),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 10),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                final form = _formKey.currentState!;
                if (form.validate()) {
                  setState(() => isLoading = true);
                  form.save();
                  addAnnuaire();
                  form.reset();
                }
              },
              child: isLoading
                  ? loading()
                  : Text(
                      'Nouveau contact',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ))),
    ]);
  }

  void addAnnuaire() async {
    final annuaireModel = AnnuaireModel(
        categorie: 'Victime',
        nomPostnomPrenom: nomPostnomPrenom.toString(),
        email: email.toString(),
        mobile1: mobile1.toString(),
        mobile2: mobile2.toString(),
        secteurActivite: secteurActivite.toString(),
        nomEntreprise: nomEntreprise.toString(),
        grade: grade.toString(),
        adresseEntreprise: adresseEntreprise.toString(),
        userName: userName.toString(),
        superviseur: superviseur.toString(),
        campaign: campaign.toString());


    await AnnuaireRepository().insertData(annuaireModel);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListAnnuaire()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${annuaireModel.nomPostnomPrenom} ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
