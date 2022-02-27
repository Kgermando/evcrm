import 'package:crm_spx/src/global/repository/agenda/agenda_repository.dart';
import 'package:crm_spx/src/models/agenda_model.dart';
import 'package:crm_spx/src/pages/agenda/list_agenda.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:flutter/material.dart';

class UpdateAgenda extends StatefulWidget {
  const UpdateAgenda({Key? key, required this.agendaModel}) : super(key: key);
  final AgendaModel agendaModel;

  @override
  _UpdateAgendaState createState() => _UpdateAgendaState();
}

class _UpdateAgendaState extends State<UpdateAgenda> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool connectionStatus = false;

  int? number;
  String? userName;
  String? superviseur;
  String? campaign;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userPrefs();

    number = widget.agendaModel.number;
    titleController = TextEditingController(text: widget.agendaModel.title);
    descriptionController =
        TextEditingController(text: widget.agendaModel.description);
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Votre agenda'),
          elevation: 0,
        ),
        body: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
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
    );
  }

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
      controller: titleController,
      style: bodyText1,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Titre',
        // hintStyle: TextStyle(color: Colors.black54),
      ),
      validator: (title) => title != null && title.isEmpty
          ? 'La title ne peut pâs être vide'
          : null,
      onChanged: (value) => titleController.text,
    );
  }

  Widget buildDescription(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return TextFormField(
      maxLines: 10,
      controller: descriptionController,
      style: bodyText2,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Ecrivez quelque chose...',
        // hintStyle: TextStyle(color: Colors.black54),
      ),
      validator: (title) => title != null && title.isEmpty
          ? 'La description ne peut pâs être vide'
          : null,
      onChanged: (value) => descriptionController.text,
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
                  updateAgenda();
                }
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

  Future updateAgenda() async {
    final agendaModel = AgendaModel(
        id: widget.agendaModel.id,
        title: titleController.text,
        number: number!,
        description: descriptionController.text,
        date: DateTime.now(),
        userName: userName.toString(),
        superviseur: superviseur.toString(),
        campaign: campaign.toString());

     await AgendaRepository().updateData(agendaModel);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListAgenda()));
  }
}
