import 'dart:async';

import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/global/repository/superviseur/superviseur_repository.dart';
import 'package:crm_spx/src/global/repository/users/user_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/models/superviseur_model.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/pages/agents/list_agent.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:crm_spx/src/utils/roles.dart';
import 'package:crm_spx/src/utils/sexe.dart';
import 'package:flutter/material.dart';

class AddAgent extends StatefulWidget {
  const AddAgent({Key? key}) : super(key: key);

  @override
  _AddAgentState createState() => _AddAgentState();
}

class _AddAgentState extends State<AddAgent> {
  final _form = GlobalKey<FormState>();
  final _formSuperviseur = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingSuperviseur = false;

  List<String> roles = Role().roles;
  List<String> sexes = Sexe().sexe;
  List<CampaignModel> campaignList = [];
  List<SuperviseurModel> superviseurList = [];
  List<User> userListExcel = [];

  String? firstName;
  String? lastName;
  // String? userName;
  String? email;
  String? telephone;
  String? adresse;
  String? sexe;
  String? role;
  String? campaign;
  String? superviseur;
  bool isOnline = false;
  // String? password;
  // String? passwordConfirm;

  TextEditingController userName = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  // SuperViseur
  String? nameSuperviseur;

  @override
  void initState() {
    super.initState();
    loadDataCount();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        loadData();
      });
    });
  }

  Future loadData() async {
    final campaign = await CampaignRepository().getAllData();
    final superviseur = await SuperviseurRepository().getAllData();
    final user = await UserRepository().getAllData();
    if (!mounted) return;
    setState(() {
      userListExcel = user;
      campaignList = campaign;
      superviseurList = superviseur;
    });
  }

  Future loadDataCount() async {
    final userCount = await UserRepository().getCountUser();
    if (!mounted) return;
    setState(() {
      userName = TextEditingController(text: 'agent-${userCount.count + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvel Agent"),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Responsive.isDesktop(context)
              ? const EdgeInsets.all(40.0)
              : const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _form,
                  child: Responsive.isDesktop(context)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            textField(),
                            Row(
                              children: [
                                Expanded(
                                  child: firstNameField(),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: lastNameField(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: userNameField(),
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
                                Expanded(
                                  child: telephoneField(),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: sexeField(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: campaignField(),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: superviseurField(),
                                )
                              ],
                            ),
                            roleField(),
                            Row(
                              children: [
                                Expanded(
                                  child: passwordField(),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: passwordConfirmField(),
                                )
                              ],
                            ),
                            addresseField(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                submitField(),
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            textField(),
                            firstNameField(),
                            lastNameField(),
                            userNameField(),
                            emailField(),
                            telephoneField(),
                            sexeField(),
                            campaignField(),
                            superviseurField(),
                            roleField(),
                            passwordField(),
                            passwordConfirmField(),
                            addresseField(),
                            submitField(),
                          ],
                        )),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Ajout d'un nouvel agent",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget firstNameField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Prénom',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) => setState(() => firstName = value.trim()),
      ),
    );
  }

  Widget lastNameField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Nom',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) => setState(() => lastName = value.trim()),
      ),
    );
  }

  Widget userNameField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: userName,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'user name',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) {
          setState(() {
            userName.text = value.trim();
            userName.selection = TextSelection.fromPosition(
                TextPosition(offset: userName.text.length));
          });
        },
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
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) => setState(() => email = value.trim()),
      ),
    );
  }

  Widget telephoneField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Téléphone',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) => setState(() => telephone = value.trim()),
      ),
    );
  }

  Widget sexeField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Sexe',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: sexe,
        isExpanded: true,
        items: sexes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ce champs est obligatoire' : null,
        onChanged: (value) {
          setState(() {
            sexe = value;
          });
        },
      ),
    );
  }

  Widget campaignField() {
    var c = campaignList.map((e) => e.campaignName);
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Campaign',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: campaign,
        isExpanded: true,
        items: c.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value != null && value.isEmpty
            ? 'Le campaign est obligatoire'
            : null,
        onChanged: (value) {
          setState(() {
            campaign = value;
          });
        },
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

  Widget roleField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Role',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: role,
        isExpanded: true,
        items: roles.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) =>
            value != null && value.isEmpty ? 'Le role est obligatoire' : null,
        onChanged: (value) {
          setState(() {
            role = value;
          });
        },
      ),
    );
  }

  Widget passwordField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: password,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: 'Mot de passe',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) => value != null && value.isEmpty
            ? 'Mot de passe total est obligatoire'
            : null,
        onChanged: (value) {
          setState(() {
            password.text = value.trim();
            password.selection = TextSelection.fromPosition(
                TextPosition(offset: password.text.length));
          });
        },
      ),
    );
  }

  Widget passwordConfirmField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: passwordConfirm,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: 'Confirmez le mot de passe',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Mot de passe total est obligatoire';
          } else if (password.text != passwordConfirm.text) {
            return 'Le mot doit être le même';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            passwordConfirm.text = value.trim();
            passwordConfirm.selection = TextSelection.fromPosition(
                TextPosition(offset: passwordConfirm.text.length));
          });
        },
      ),
    );
  }

  Widget addresseField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: 'Adresse',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) => value != null && value.isEmpty
            ? 'L\'adresse est obligatoire'
            : null,
        onChanged: (value) => setState(() => adresse = value.trim()),
      ),
    );
  }

  Widget submitField() {
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
                final form = _form.currentState!;
                if (form.validate()) {
                  setState(() => isLoading = true);
                  form.save();
                  onSubmit();
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
                    ))),
    ]);
  }

  onSubmit() async {
    final user = User(
        firstName: firstName.toString(),
        lastName: lastName.toString(),
        userName: userName.text,
        email: email.toString(),
        telephone: telephone.toString(),
        adresse: adresse.toString(),
        sexe: sexe.toString(),
        role: role.toString(),
        campaign: campaign.toString(),
        superviseur: superviseur.toString(),
        isOnline: false,
        isActive: true,
        createdAt: DateTime.now(),
        password: password.text);
    await UserRepository().register(user);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListAgent()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Compte agent crée avec succées!"),
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
              }
            },
            child: isLoadingSuperviseur ? loading() : const Text('Soumettre'),
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
