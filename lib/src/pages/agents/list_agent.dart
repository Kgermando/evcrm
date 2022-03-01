import 'dart:async';

import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/users/user_repository.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:crm_spx/src/pages/agents/add_agent.dart';
import 'package:crm_spx/src/pages/agents/detail_agent.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class ListAgent extends StatefulWidget {
  const ListAgent({Key? key}) : super(key: key);

  @override
  _ListAgentState createState() => _ListAgentState();
}

class _ListAgentState extends State<ListAgent> {
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    init();
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

  List<User> list = [];

  Future init() async {
    final data = await UserRepository().getAllDataSearch(query);
    if (!mounted) return;
    setState(() => list = data);
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
      floatingActionButton: (role == 'SuperAdmin' || role == 'Admin')
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddAgent()));
              },
              child: const Icon(Icons.person_add),
            )
          : FloatingActionButton(
              onPressed: () {}, child: const Icon(Icons.no_accounts)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppbar(title: 'Administration'),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {}, 
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.green),
                    ),
                  icon: const Icon(Icons.view_array_outlined), 
                  label: const Text('EXCEL')
                ),
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.redAccent),
                    ),
                    icon: const Icon(Icons.print),
                    label: const Text('PDF')),
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                    ),
                    icon: const Icon(Icons.list_alt_outlined ),
                    label: const Text('JSON')),
                TextButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.greenAccent),
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
                const SizedBox(width: 20.0,),
                Container(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    'Agents: ${list.length}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.orange),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            buildSearch(),
            Expanded(
                child: FutureBuilder<List<User>>(
                    future: UserRepository().getAllDataSearch(query),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User>> snapshot) {
                      if (snapshot.hasData) {
                        List<User>? users = snapshot.data;
                        return users!.isEmpty
                            ? Center(
                                child: Text(
                                  'Pas encore d\'agents.',
                                  style: Responsive.isDesktop(context)
                                      ? const TextStyle(fontSize: 24)
                                      : const TextStyle(fontSize: 16),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: init,
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  child: userItem(users),
                                ),
                              );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Recherche rapide',
        onChanged: searchAchat,
      );

  Future searchAchat(String query) async => debounce(() async {
        final listAchat = await UserRepository().getAllDataSearch(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          list = listAchat;
        });
      });

  Widget userItem(List<User> users) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: DataTable2(
          columnSpacing: 12,
          minWidth: 600,
          // dataRowHeight: 100,
          empty: Text('Pas encore d\'agents', style: bodyText1),
          columns: const [
            DataColumn(
              label: Text("Statut",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn2(
              size: ColumnSize.L,
              label: Text("Prénom",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn2(
              size: ColumnSize.L,
              label: Text("Nom",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn(
              label: Text("UserName",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn(
              label: Text("Telephone",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn(
              label: Text("Sexe",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn(
              label: Text("Role",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            DataColumn2(
              size: ColumnSize.L,
              label: Text("campaign",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
          ],
          rows: List.generate(
            users.length,
            (index) => recentFileDataRow(users[index]),
          ),
        ),
      ),
    );
  }

  //  Data Table
  DataRow recentFileDataRow(User user) {
    return DataRow(
      selected: true,
      cells: [
        DataCell(
          Text(
            (user.isActive) ? 'Active': 'Inactif',
            style: TextStyle(
              color: (user.isActive) ? Colors.green : Colors.red
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.firstName),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.lastName),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.userName),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.telephone),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.sexe),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.role),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailAgent(user: user)));
            },
            child: Text(user.campaign),
          ),
        ),
      ],
    );
  }  
    
   
}
