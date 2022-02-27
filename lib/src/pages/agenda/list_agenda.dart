import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/agenda/agenda_repository.dart';
import 'package:crm_spx/src/models/agenda_model.dart';
import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:crm_spx/src/pages/agenda/add_agenda_.dart';
import 'package:crm_spx/src/pages/agenda/agenda_card_widget.dart';
import 'package:crm_spx/src/pages/agenda/detail_agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class ListAgenda extends StatefulWidget {
  const ListAgenda({Key? key}) : super(key: key);

  @override
  _ListAgendaState createState() => _ListAgendaState();
}

class _ListAgendaState extends State<ListAgenda> {
  bool isLoading = false;

  bool connectionStatus = false;

  List<AgendaModel> agendaList = [];

  @override
  void initState() {
    refreshAgenda();
    super.initState();
  }

  //   @override
  // void dispose() {
  //   NotesDatabase.instance.close();

  //   super.dispose();
  // }


  Future refreshAgenda() async {
    setState(() => isLoading = true);

    agendaList = await AgendaRepository().getAllData();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddAgenda()));

              refreshAgenda();
            },
            child: const Icon(Icons.note_add_sharp),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppbar(title: 'Votre Agenda'),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : agendaList.isEmpty
                        ? Center(
                            child: Text(
                              'Ajoutez une note',
                              style: Responsive.isDesktop(context)
                                  ? const TextStyle(fontSize: 24)
                                  : const TextStyle(fontSize: 16),
                            ),
                          )
                        : Scrollbar(isAlwaysShown: true, child: buildAgenda()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAgenda() {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      itemCount: agendaList.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      crossAxisCount: 6,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      itemBuilder: (context, index) {
        final agenda = agendaList[index];
        final color = _lightColors[index % _lightColors.length];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailAgenda(agendaModel: agenda, color: color),
            ));

            refreshAgenda();
          },
          child:
              AgendaCardWidget(agendaModel: agenda, index: index, color: color),
        );
      },
    );
  }
}
