import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/global/repository/scripting/scripting_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/models/scripting_model.dart';
import 'package:crm_spx/src/models/user_model.dart';
import 'package:crm_spx/src/pages/compaign_page/list_campaign_page.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/loading.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

enum Condition { oui, non }

class ScriptingClient extends StatefulWidget {
  const ScriptingClient({Key? key, required this.campaignModel})
      : super(key: key);
  final CampaignModel campaignModel;

  @override
  _ScriptingClientState createState() => _ScriptingClientState();
}

class _ScriptingClientState extends State<ScriptingClient> {
  final _form = GlobalKey<FormState>();
  // final ScrollController _controllerTwo = ScrollController();
  bool isloading = false;
  List<CampaignModel> listCampaign = [];
  late List<Map<String, dynamic>> _reponseJson;

  bool showCard = false; // Pour condition Widget
  bool showCard1 = false;
  bool showCard2 = false;
  bool showCard3 = false;

  String? textRespo;
  String? dateTimeRespo;
  String? multiRadioRespo;
  String? dropdownRespo;
  List<String> multiChecked = []; // Multi checkbox
  String conditionResp = "";

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        loadData();
        t.cancel();
      });
    });
    _reponseJson = [];
    userPrefs();
    super.initState();
  }

  void loadData() async {
    final dataList = await CampaignRepository().getAllData();
    setState(() {
      listCampaign = dataList;
    });
  }

  String? userName;
  String? role;
  String? superviseur;

  void userPrefs() async {
    User user = await UserPreferences.read();
    setState(() {
      userName = user.userName;
      role = user.role;
      superviseur = user.superviseur;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    final headline6 = Theme.of(context).textTheme.headline6;
    final size = MediaQuery.of(context).size;

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.campaignModel.campaignName),
        // ),
        body: Form(
          key: _form,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Responsive.isDesktop(context)
                    ? size.width / 1.5
                    : size.width,
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                            border: Border(
                          top: BorderSide(color: Colors.teal, width: 15),
                        )),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 2.0),
                                        child: AutoSizeText(
                                          widget.campaignModel.title,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: headline4!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            // color: ThemeProvider().isDarkMode
                                            //     ? Colors.white
                                            //     : Colors.black
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: AutoSizeText(
                                          widget.campaignModel.subTitle,
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          style: headline6!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Scripting here
                    logicScripting(),

                    const SizedBox(
                      height: 20.0,
                    ),
                    // Save form
                    saveForm(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  logicScripting() {
    final scripting = widget.campaignModel.scripting;
    return Expanded(
      child: ListView.builder(
          itemCount: scripting.length,
          itemBuilder: (BuildContext context, index) {
            final s = scripting[index];
            if (s['value'][2]['condition'][0]['qOui'] == " " &&
                s['value'][2]['condition'][1]['qNon'] == " ") {
            } else {}
            return logicScriptingWidget(s);
          }),
    );
  }

  Widget logicScriptingWidget(s) {
    final headline6 = Theme.of(context).textTheme.headline6;
    // debugPrint('qOui ${s['value'][2]['condition'][0]['qOui']}');
    // debugPrint('qNon ${s['value'][2]['condition'][1]['qNon']}');

    var ouiS = s['value'][2]['condition'][0]['qOui']; // ID ecrit par l"admin
    var nonS = s['value'][2]['condition'][1]['qNon']; // ID ecrit par l"admin

    int idCard = s['id'];
    var widgetCard = s['value'][1]['typeWidget'] == 'Condition';

    print('idCard $idCard');

    bool idCard0 = s['value'][2]['condition'][0]['qOui'] == "" &&
        s['value'][2]['condition'][1]['qNon'] == "";

    print('conditionResp $conditionResp');

    if (idCard0) {
      
    } else if(widgetCard) {
      if (conditionResp == "OUI") {
        
      } else if(conditionResp == "NON") {
        
      }
    } 

    return Column(
      children: [
        if (idCard0)
          Card(
            elevation: 10,
            child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    border: Border(
                  left: BorderSide(color: Colors.teal, width: 15),
                )),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: AutoSizeText(
                            'Q ${s['id'] + 1}.',
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: headline6!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: AutoSizeText(
                            s['value'][0]['question'],
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style:
                                headline6.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    if (s['value'][1]['typeWidget'] == 'Text')
                      textFormFieldWidget(s['id'], s['value'][0]['question']),
                    if (s['value'][1]['typeWidget'] == 'Condition')
                      radioFieldWidget(
                          s['id'],
                          s['value'][0]['question'],
                          s['value'][2]['condition'][0]['qOui'],
                          s['value'][2]['condition'][1]['qNon']),
                    if (s['value'][1]['typeWidget'] == 'MultiRadio')
                      multiRadioFieldWidget(s['id'], s['value'][0]['question'],
                          s['value'][3]['multiChoice']),
                    if (s['value'][1]['typeWidget'] == 'MultiCheckBox')
                      multiCheckboxFieldWidget(
                          s['id'],
                          s['value'][0]['question'],
                          s['value'][3]['multiChoice']),
                    if (s['value'][1]['typeWidget'] == 'Dropdown')
                      dropdownFieldWidget(s['id'], s['value'][0]['question'],
                          s['value'][3]['multiChoice']),
                    if (s['value'][1]['typeWidget'] == 'DateTIme')
                      dateTimeFieldWidget(s['id'], s['value'][0]['question']),
                  ],
                )),
          ),
      ],
    );
  }

  Widget radioFieldWidget(int id, String question, String qOUI, String qNON) {
    final List<String> conditionList = ['OUI', 'NON'];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: conditionList
            .map((condition) => RadioListTile<String>(
                  groupValue: conditionResp,
                  title: Text(condition),
                  value: condition,
                  onChanged: (val) {
                    setState(() {
                      conditionResp = (val == '' || val == null) ? '-' : val;
                      updateValue(id, question, conditionResp);
                      debugPrint('condition $id = $conditionResp');

                      int oui = int.parse(qOUI);
                      int non = int.parse(qNON);
                      print('oui $oui');
                      print('non $non');

                      if (conditionResp == "") {
                        showCard1 = qOUI == "" && qNON == "";
                      } else if (conditionResp == "OUI") {
                        qOUI == "" && qNON == "" && oui == id;
                      } else if (conditionResp == "NON") {
                        qOUI == "" && qNON == "" && non == id;
                      }

                      // switch (conditionResp) {
                      //   case 'OUI':
                      //     {
                      //       showCard = true;
                      //       id;
                      //     }
                      //     break;

                      //   case 'NON':
                      //     {
                      //       //statements;
                      //     }
                      //     break;

                      //   default:
                      //     {
                      //       //statements;
                      //     }
                      //     break;
                      // }
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget textFormFieldWidget(int id, String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Réponse',
            labelStyle: const TextStyle(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (val) {
            setState(() {
              textRespo = (val == '' || val == null) ? '-' : val;
              updateValue(id, question, textRespo);
              debugPrint('textRespo $id $textRespo');
            });
          }),
    );
  }

  Widget multiRadioFieldWidget(int id, String question, List dataList) {
    final List<String> multiChoises = [
      dataList[0]['multiControllerList1'],
      dataList[1]['multiControllerList2'],
      dataList[2]['multiControllerList3'],
      dataList[3]['multiControllerList4'],
      dataList[4]['multiControllerList5']
    ];
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      height: 250,
      child: Column(
        children: multiChoises
            .map((value) => RadioListTile<String>(
                  groupValue: multiRadioRespo,
                  title: Text(value),
                  value: value,
                  onChanged: (val) {
                    setState(() {
                      multiRadioRespo = (val == '' || val == null) ? '-' : val;
                      updateValue(id, question, multiRadioRespo);
                      debugPrint('Radio $id = $multiRadioRespo');
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget multiCheckboxFieldWidget(int id, String question, List dataList) {
    final List<String> multiChoises = [
      dataList[0]['multiControllerList1'],
      dataList[1]['multiControllerList2'],
      dataList[2]['multiControllerList3'],
      dataList[3]['multiControllerList4'],
      dataList[4]['multiControllerList5']
    ];
    return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        height: 250,
        child: ListView.builder(
            itemCount: multiChoises.length,
            itemBuilder: (context, i) {
              return ListTile(
                  title: Text(multiChoises[i]),
                  leading: Checkbox(
                    value: multiChecked.contains(multiChoises[i]),
                    onChanged: (val) {
                      if (val == true) {
                        setState(() {
                          multiChecked.add(multiChoises[i]);
                          updateValue(id, question, multiChecked);
                          debugPrint('multiChecked $id = $multiChecked');
                        });
                      } else {
                        setState(() {
                          multiChecked.remove(multiChoises[i]);
                          updateValue(id, question, multiChecked);
                          debugPrint('multiChecked $id = $multiChecked');
                        });
                      }
                    },
                  ));
            }));
  }

  Widget dropdownFieldWidget(int id, String question, List dataList) {
    final List<String> multiChoises = [
      dataList[0]['multiControllerList1'],
      dataList[1]['multiControllerList2'],
      dataList[2]['multiControllerList3'],
      dataList[3]['multiControllerList4'],
      dataList[4]['multiControllerList5']
    ];

    print('multiChoises $multiChoises');
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Selectionner votre reponse',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: dropdownRespo,
        isExpanded: true,
        items: multiChoises.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            dropdownRespo = (val == '' || val == null) ? '-' : val;
            updateValue(id, question, dropdownRespo);
            debugPrint('Dropdown $id = $dropdownRespo');
          });
        },
      ),
    );
  }

  Widget dateTimeFieldWidget(int id, String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: DateTimePicker(
          initialValue: '',
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          dateLabelText: 'Date',
          onChanged: (val) {
            dateTimeRespo = (val == '') ? '-' : val;
            updateValue(id, question, dateTimeRespo);
            debugPrint('DateTime $id = $dateTimeRespo');
          },
          validator: (val) {
            return null;
          }),
    );
  }

  Widget saveForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 10),
                primary: Colors.teal,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                final form = _form.currentState!;
                if (form.validate()) {
                  setState(() {
                    isloading = true;
                  });
                  form.save();
                  submit();
                  form.reset();
                }
              },
              child: isloading
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

  updateValue(int id, String question, dynamic reponses) {
    Map<String, dynamic> json = {
      'id': id,
      'question': question,
      'reponse': reponses
    };
    _reponseJson.add(json);
    print('_reponseJson $_reponseJson');
  }

  Future<void> submit() async {
    final jsonList = _reponseJson.map((item) => jsonEncode(item)).toList();

    final scriptingModel = ScriptingModel(
      campaignName: widget.campaignModel.campaignName,
      scripting: jsonList,
      date: DateTime.now(),
      role: role.toString(),
      userName: userName.toString(),
      superviseur: superviseur.toString(),
    );

    await ScriptingRepository().insertData(scriptingModel);
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const ListCampaignPage())));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Donnée ajouté!"),
      backgroundColor: Colors.green[700],
    ));
  }
}
