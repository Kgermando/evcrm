import 'package:crm_spx/src/global/repository/agenda/agenda_repository.dart';
import 'package:crm_spx/src/models/agenda_model.dart';
import 'package:crm_spx/src/pages/agenda/list_agenda.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:flutter/material.dart';

class AddAgenda extends StatefulWidget {
  const AddAgenda({Key? key, this.agendaModel}) : super(key: key);
  final AgendaModel? agendaModel;

  @override
  _AddAgendaState createState() => _AddAgendaState();
}

class _AddAgendaState extends State<AddAgenda> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool connectionStatus = false;

  int? number;
  String? title;
  String? description;
  String? userName;
  String? superviseur;
  String? campaign;

  @override
  void initState() {
    userPrefs();
    super.initState();
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
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, true);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Votre agenda'),
            // actions: [buildButton()],
            elevation: 0,
          ),
          body: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildNumber(),
                        buildTitle(context),
                        const SizedBox(height: 8),
                        buildDescription(context),
                        const SizedBox(height: 16),
                        buildButton(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildNumber() {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: (number ?? 0).toDouble(),
            label: 'Niveau d\'importance',
            min: 0,
            max: 5,
            divisions: 5,
            onChanged: (value) => setState(() {
              number = value.toInt();
            }),
          ),
        )
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: bodyText1,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Titre',
        // hintStyle: TextStyle(color: Colors.black54),
      ),
      validator: (title) => title != null && title.isEmpty
          ? 'Le titre ne peut pâs être vide'
          : null,
      onChanged: (value) => setState(() {
        title = value;
      }),
    );
  }

  Widget buildDescription(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return TextFormField(
      maxLines: 10,
      initialValue: description,
      style: bodyText2,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Ecrivez quelque chose...',
        // hintStyle: TextStyle(color: Colors.black54),
      ),
      validator: (title) => title != null && title.isEmpty
          ? 'La description ne peut pâs être vide'
          : null,
      onChanged: (value) => setState(() {
        description = value;
      }),
    );
  }

  Widget buildButton(BuildContext context) {
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
                final form = _formKey.currentState!;
                if (form.validate()) {
                  setState(() => isLoading = true);
                  form.save();
                  addAgenda();
                  form.reset();
                }
                // setState(() => isLoading = false);
              },
              child: isLoading
                  ? loading()
                  : Text(
                      'Enregistrez',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height / 50,
                      ),
                    ))),
    ]);
  }

  Future addAgenda() async {
    final agendaModel = AgendaModel(
        title: title!,
        number: number ?? 0,
        description: description!,
        date: DateTime.now(),
        userName: userName.toString(),
        superviseur: superviseur.toString(),
        campaign: campaign.toString());

    await AgendaRepository().insertData(agendaModel);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListAgenda()));
  }
}
