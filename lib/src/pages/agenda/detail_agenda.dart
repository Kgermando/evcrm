import 'package:crm_spx/src/global/repository/agenda/agenda_repository.dart';
import 'package:crm_spx/src/models/agenda_model.dart';
import 'package:crm_spx/src/pages/agenda/update_agenda.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailAgenda extends StatefulWidget {
  const DetailAgenda({Key? key, required this.agendaModel, required this.color})
      : super(key: key);
  final AgendaModel agendaModel;
  final Color color;

  @override
  _DetailAgendaState createState() => _DetailAgendaState();
}

class _DetailAgendaState extends State<DetailAgenda> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userPrefs();
  }

  String? telephone;

  Future userPrefs() async {
    var result = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      telephone = result.telephone;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.agendaModel.title),
          actions: [
            if (telephone == telephone) editButton(),
            if (telephone == telephone) deleteButton()
          ],
          elevation: 0,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
                isAlwaysShown: true,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    elevation: 10,
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        Text(
                          widget.agendaModel.title,
                          style: headline6,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMd().format(widget.agendaModel.date),
                          style: bodyText1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.agendaModel.description,
                          style: bodyText2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpdateAgenda(agendaModel: widget.agendaModel),
        ));
      });

  Widget deleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etes-vous sûr de supprimé ceci?'),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Annuler'),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                await AgendaRepository().deleteData(widget.agendaModel.id!);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${widget.agendaModel.title} vient d'être supprimé!"),
                  backgroundColor: Colors.red[700],
                ));
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
