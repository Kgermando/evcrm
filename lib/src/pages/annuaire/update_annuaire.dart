
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/annuaire/annuaire_repository.dart';
import 'package:crm_spx/src/models/annuaire_model.dart';
import 'package:crm_spx/src/pages/annuaire/list_annuaire.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/annuaire_list.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:flutter/material.dart';

class UpdateAnnuaire extends StatefulWidget {
  const UpdateAnnuaire({Key? key, required this.annuaireModel})
      : super(key: key);
  final AnnuaireModel annuaireModel;

  @override
  _UpdateAnnuaireState createState() => _UpdateAnnuaireState();
}

class _UpdateAnnuaireState extends State<UpdateAnnuaire> {
  final _formKey = GlobalKey<FormState>();

  final List<String> roles = AnnuiareListCategorie().roles;

  bool isLoading = false;

  bool connectionStatus = false;

  TextEditingController categorieController = TextEditingController();
  TextEditingController nomPostnomPrenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();
  TextEditingController secteurActiviteController = TextEditingController();
  TextEditingController nomEntrepriseController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController adresseEntrepriseController = TextEditingController();

  String? userName;
  String? superviseur;
  String? campaign;

  @override
  void initState() {
    super.initState();
    userPrefs();
    setState(() {
      categorieController =
          TextEditingController(text: widget.annuaireModel.categorie);
      nomPostnomPrenomController =
          TextEditingController(text: widget.annuaireModel.nomPostnomPrenom);
      emailController = TextEditingController(text: widget.annuaireModel.email);
      mobile1Controller =
          TextEditingController(text: widget.annuaireModel.mobile1);
      mobile2Controller =
          TextEditingController(text: widget.annuaireModel.mobile2);
      secteurActiviteController =
          TextEditingController(text: widget.annuaireModel.secteurActivite);
      nomEntrepriseController =
          TextEditingController(text: widget.annuaireModel.nomEntreprise);
      gradeController = TextEditingController(text: widget.annuaireModel.grade);
      adresseEntrepriseController =
          TextEditingController(text: widget.annuaireModel.adresseEntreprise);
    });
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
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.annuaireModel.nomPostnomPrenom,
            style: Responsive.isDesktop(context)
                ? const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)
                : bodyText1,
          ),
          elevation: 0,
        ),
        body: Scrollbar(
          isAlwaysShown: true,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: Responsive.isDesktop(context)
                  ? const EdgeInsets.all(40.0)
                  : const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Form(
                  key: _formKey,
                  child: Responsive.isDesktop(context)
                      ? Column(children: [
                          categorieField(),
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
                            categorieField(),
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
    );
  }

  Widget categorieField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          // labelText: 'Selectionner',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: categorieController.text,
        isExpanded: true,
        items: roles.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            categorieController.text;
          });
        },
      ),
    );
  }

  Widget nomPostnomPrenomField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: nomPostnomPrenomController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Prénom Nom Post-nom',
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
        onChanged: (value) => nomPostnomPrenomController.text,
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => emailController.text,
      ),
    );
  }

  Widget mobile1Field() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: mobile1Controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Téléphone 1',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => mobile1Controller.text,
      ),
    );
  }

  Widget mobile2Field() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: mobile2Controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Téléphone 2',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => mobile2Controller.text,
      ),
    );
  }

  Widget secteurActiviteField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: secteurActiviteController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Secteur d\'activité',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => secteurActiviteController.text,
      ),
    );
  }

  Widget nomEntrepriseField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: nomEntrepriseController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Entreprise ou business',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => nomEntrepriseController.text,
      ),
    );
  }

  Widget gradeField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: gradeController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Grade ou fonction',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => gradeController.text,
      ),
    );
  }

  Widget adresseEntrepriseField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: adresseEntrepriseController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Adresse',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) => adresseEntrepriseController.text,
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
                if (isLoading) return;
                final form = _formKey.currentState!;
                if (form.validate()) {
                  setState(() => isLoading = true);
                  form.save();
                  updateAnnuaire();
                  form.reset();
                }
              },
              child: isLoading
                  ? loading()
                  : Text(
                      'Modifiez le contact',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ))),
    ]);
  }

  void updateAnnuaire() async {
    final annuaireModel = AnnuaireModel(
        id: widget.annuaireModel.id,
        categorie: categorieController.text,
        nomPostnomPrenom: nomPostnomPrenomController.text,
        email: emailController.text,
        mobile1: mobile1Controller.text,
        mobile2: mobile2Controller.text,
        secteurActivite: secteurActiviteController.text,
        nomEntreprise: nomEntrepriseController.text,
        grade: gradeController.text,
        adresseEntreprise: adresseEntrepriseController.text,
        userName: userName.toString(),
        superviseur: superviseur.toString(),
        campaign: campaign.toString());

    await AnnuaireRepository().updateData(annuaireModel);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListAnnuaire()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${annuaireModel.nomPostnomPrenom} Modifié!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
