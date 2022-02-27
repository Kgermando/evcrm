import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/global/repository/campaigns/campaign_repository.dart';
import 'package:crm_spx/src/models/campaign_model.dart';
import 'package:crm_spx/src/pages/compaign_page/components/title_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/check_box_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/date_time_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/dropdown_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/multi_checkbox_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/multi_radio_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/radio_item_widget.dart';
import 'package:crm_spx/src/scripting_Widget/text_item_widget.dart';
import 'package:crm_spx/src/utils/dropdown.dart';
import 'package:crm_spx/src/widgets/title_page.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { oui, non }

class EditCampaignPage extends StatefulWidget {
  const EditCampaignPage({Key? key, required this.campaignModel})
      : super(key: key);
  final CampaignModel campaignModel;

  @override
  _EditCampaignPageState createState() => _EditCampaignPageState();
}

class _EditCampaignPageState extends State<EditCampaignPage> {
  late int _count;
  late String _result;
  late List<Map<String, dynamic>> _values;

  late int countMulti;
  late String resultMulti;
  late List<Map<String, dynamic>> valuesMulti;

  bool isloading = false;

  final ScrollController _controllerTwo = ScrollController();

  final List<String> typeWidgetList = [];
  final List<TextEditingController> _questionControllers = [];
  final List<TextEditingController> _qOuiControllers = [];
  final List<TextEditingController> _qNonControllers = [];

  // Condition pour afficher les widgets
  final List<bool> textBoolList = [];
  final List<bool> checkBoxBoolList = [];
  final List<bool> radioBoolList = [];
  final List<bool> multiRadioList = [];
  final List<bool> multiCheckboxList = [];
  final List<bool> dropdownBoolList = [];
  final List<bool> dateTImeBoolList = [];
  final List<bool> imageBoolList = [];

  // La gestion des multiples propositions pour une question
  final List<TextEditingController> multiControllerList1 = [];
  final List<TextEditingController> multiControllerList2 = [];
  final List<TextEditingController> multiControllerList3 = [];
  final List<TextEditingController> multiControllerList4 = [];
  final List<TextEditingController> multiControllerList5 = [];

  @override
  void initState() {
    super.initState();
    _count = 0;
    _result = '';
    _values = [];

    countMulti = 1;
    resultMulti = '';
    valuesMulti = [];
  }

  @override
  void dispose() {
    _controllerTwo.dispose();
    for (final controller in _questionControllers) {
      controller.dispose();
    }
    for (final controller in _qOuiControllers) {
      controller.dispose();
    }
    for (final controller in _qNonControllers) {
      controller.dispose();
    }
    for (final controller in multiControllerList1) {
      controller.dispose();
    }
    for (final controller in multiControllerList2) {
      controller.dispose();
    }
    for (final controller in multiControllerList3) {
      controller.dispose();
    }
    for (final controller in multiControllerList4) {
      controller.dispose();
    }
    for (final controller in multiControllerList5) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.of(context).pushNamed('listCampaign');
          },
        ),
        title: Text(widget.campaignModel.campaignName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                final question = TextEditingController();
                final qOui = TextEditingController();
                final qNon = TextEditingController();
                final multiController1 = TextEditingController();
                final multiController2 = TextEditingController();
                final multiController3 = TextEditingController();
                final multiController4 = TextEditingController();
                final multiController5 = TextEditingController();
                String typeWidget = '';

                bool textBool = false;
                bool checkBoxBool = false;
                bool radioBool = false;
                bool multiRadio = false;
                bool multiCheckbox = false;
                bool dropdownBool = false;
                bool dateTImeBool = false;
                bool imageBool = false;

                _count++;

                _questionControllers.add(question);
                typeWidgetList.add(typeWidget);
                _qOuiControllers.add(qOui);
                _qNonControllers.add(qNon);

                multiControllerList1.add(multiController1);
                multiControllerList2.add(multiController2);
                multiControllerList3.add(multiController3);
                multiControllerList4.add(multiController4);
                multiControllerList5.add(multiController5);

                textBoolList.add(textBool);
                checkBoxBoolList.add(checkBoxBool);
                radioBoolList.add(radioBool);
                multiRadioList.add(multiRadio);
                multiCheckboxList.add(multiCheckbox);
                dropdownBoolList.add(dropdownBool);
                dateTImeBoolList.add(dateTImeBool);
                imageBoolList.add(imageBool);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _count = 0;
                _result = '';
                _values = [];
              });
            },
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Responsive.isDesktop(context) ? size.width / 1.5 : size.width,
            child: ListView(
              children: [
                titleField(context,
                    'Generate scripting ${widget.campaignModel.campaignName}'),
                Card(
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Colors.teal, width: 15),
                    )),
                    child: TitleItemWidget(campaignModel: widget.campaignModel),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Scrollbar(
                  controller: _controllerTwo,
                  child: ListView.builder(
                      controller: _controllerTwo,
                      shrinkWrap: true,
                      itemCount: _count,
                      itemBuilder: (context, index) {
                        return itemWidget(index);
                      }),
                ),
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemWidget(int key) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Card(
      elevation: 10,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          left: BorderSide(color: Colors.teal, width: 10),
        )),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: AutoSizeText(
                    'Q ${key + 1}.',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: headline6!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (radioBoolList[key])
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          controller: _qNonControllers[key],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'NON Q?',
                            labelStyle: TextStyle(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _qNonControllers[key].text = value;
                              _qNonControllers[key].selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          _qNonControllers[key].text.length));
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          controller: _qOuiControllers[key],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'OUI Q?',
                            labelStyle: TextStyle(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _qOuiControllers[key].text = value;
                              _qOuiControllers[key].selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          _qOuiControllers[key].text.length));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        setState(() {
                          onUpdate(
                            key,
                            _questionControllers[key].text,
                            typeWidgetList[key],
                            _qOuiControllers[key].text,
                            _qNonControllers[key].text,
                            multiControllerList1[key].text,
                            multiControllerList2[key].text,
                            multiControllerList3[key].text,
                            multiControllerList4[key].text,
                            multiControllerList5[key].text,
                          );
                          updateCampaign();
                        });
                      },
                    ),
                    // if (radioBool) const SwitchItemWidget(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          final question = TextEditingController();
                          final qOui = TextEditingController();
                          final qNon = TextEditingController();
                          final multiController1 = TextEditingController();
                          final multiController2 = TextEditingController();
                          final multiController3 = TextEditingController();
                          final multiController4 = TextEditingController();
                          final multiController5 = TextEditingController();
                          String typeWidget = '';

                          bool textBool = false;
                          bool checkBoxBool = false;
                          bool radioBool = false;
                          bool multiRadio = false;
                          bool multiCheckbox = false;
                          bool dropdownBool = false;
                          bool dateTImeBool = false;
                          bool imageBool = false;

                          _count++;

                          _questionControllers.add(question);
                          typeWidgetList.add(typeWidget);
                          _qOuiControllers.add(qOui);
                          _qNonControllers.add(qNon);

                          multiControllerList1.add(multiController1);
                          multiControllerList2.add(multiController2);
                          multiControllerList3.add(multiController3);
                          multiControllerList4.add(multiController4);
                          multiControllerList5.add(multiController5);

                          textBoolList.add(textBool);
                          checkBoxBoolList.add(checkBoxBool);
                          radioBoolList.add(radioBool);
                          multiRadioList.add(multiRadio);
                          multiCheckboxList.add(multiCheckbox);
                          dropdownBoolList.add(dropdownBool);
                          dateTImeBoolList.add(dateTImeBool);
                          imageBoolList.add(imageBool);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          final question = TextEditingController();
                          final qOui = TextEditingController();
                          final qNon = TextEditingController();
                          final multiController1 = TextEditingController();
                          final multiController2 = TextEditingController();
                          final multiController3 = TextEditingController();
                          final multiController4 = TextEditingController();
                          final multiController5 = TextEditingController();
                          String typeWidget = '';
                          bool textBool = false;
                          bool checkBoxBool = false;
                          bool radioBool = false;
                          bool multiRadio = false;
                          bool multiCheckbox = false;
                          bool dropdownBool = false;
                          bool dateTImeBool = false;
                          bool imageBool = false;

                          _count--;

                          _questionControllers.remove(question);
                          typeWidgetList.remove(typeWidget);
                          _qOuiControllers.remove(qOui);
                          _qNonControllers.remove(qNon);

                          multiControllerList1.remove(multiController1);
                          multiControllerList2.remove(multiController2);
                          multiControllerList3.remove(multiController3);
                          multiControllerList4.remove(multiController4);
                          multiControllerList5.remove(multiController5);

                          textBoolList.remove(textBool);
                          checkBoxBoolList.remove(checkBoxBool);
                          radioBoolList.remove(radioBool);
                          multiRadioList.remove(multiRadio);
                          multiCheckboxList.remove(multiCheckbox);
                          dropdownBoolList.remove(dropdownBool);
                          dateTImeBoolList.remove(dateTImeBool);
                          imageBoolList.remove(imageBool);
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: _questionControllers[key],
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Question',
                      labelStyle: const TextStyle(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _questionControllers[key].text = value;
                        _questionControllers[key].selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _questionControllers[key].text.length));
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButtonFormField<DropdownModel>(
                    decoration: InputDecoration(
                      hintText: 'Select widget',
                      labelStyle: const TextStyle(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      contentPadding: const EdgeInsets.only(left: 5.0),
                    ),
                    hint: const Text('Select widget'),
                    value: dropdownList.first,
                    isExpanded: true,
                    items: dropdownList.map((DropdownModel value) {
                      return DropdownMenuItem<DropdownModel>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(value.icon),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Text(value.title),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        typeWidgetList[key] = value!.title;

                        if (typeWidgetList[key] == 'Text') {
                          textBoolList[key] = true;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = false;
                          multiRadioList[key] = false;
                          multiCheckboxList[key] = false;
                          dropdownBoolList[key] = false;
                          dateTImeBoolList[key] = false;
                          imageBoolList[key] = false;
                        } else if (typeWidgetList[key] == 'Condition') {
                          textBoolList[key] = false;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = true;
                          multiRadioList[key] = false;
                          multiCheckboxList[key] = false;
                          dropdownBoolList[key] = false;
                          dateTImeBoolList[key] = false;
                          imageBoolList[key] = false;
                        } else if (typeWidgetList[key] == 'MultiRadio') {
                          textBoolList[key] = false;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = false;
                          multiRadioList[key] = true;
                          multiCheckboxList[key] = false;
                          dropdownBoolList[key] = false;
                          dateTImeBoolList[key] = false;
                          imageBoolList[key] = false;
                        } else if (typeWidgetList[key] == 'MultiCheckBox') {
                          textBoolList[key] = false;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = false;
                          multiRadioList[key] = false;
                          multiCheckboxList[key] = true;
                          dropdownBoolList[key] = false;
                          dateTImeBoolList[key] = false;
                          imageBoolList[key] = false;
                        } else if (typeWidgetList[key] == 'Dropdown') {
                          textBoolList[key] = false;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = false;
                          multiRadioList[key] = false;
                          multiCheckboxList[key] = false;
                          dropdownBoolList[key] = true;
                          dateTImeBoolList[key] = false;
                          imageBoolList[key] = false;
                        } else if (typeWidgetList[key] == 'DateTIme') {
                          textBoolList[key] = false;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = false;
                          multiRadioList[key] = false;
                          multiCheckboxList[key] = false;
                          dropdownBoolList[key] = false;
                          dateTImeBoolList[key] = true;
                          imageBoolList[key] = false;
                        }
                        // else if (typeWidgetList[key] == 'Image') {
                        //   textBoolList[key] = false;
                        //   checkBoxBoolList[key] = false;
                        //   radioBoolList[key] = false;
                        //   multiRadioList[key] = false;
                        //   multiCheckboxList[key] = false;
                        //   dropdownBoolList[key] = false;
                        //   dateTImeBoolList[key] = false;
                        //   imageBoolList[key] = true;
                        // }
                        else if (typeWidgetList[key] == 'Select widget') {
                          textBoolList[key] = false;
                          checkBoxBoolList[key] = false;
                          radioBoolList[key] = false;
                          multiRadioList[key] = false;
                          multiCheckboxList[key] = false;
                          dropdownBoolList[key] = false;
                          dateTImeBoolList[key] = false;
                          imageBoolList[key] = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            selectWidget(key) // Widget display if select name equivalent
          ],
        ),
      ),
    );
  }

  Widget selectWidget(int key) {
    if (textBoolList[key]) {
      return TextItemWidgetReadOnly(index: key);
    } else if (radioBoolList[key]) {
      return RadioItemWidget(index: key);
    } else if (multiRadioList[key]) {
      return MulitiItemwidget(
          index: key,
          multiControllerList1: multiControllerList1,
          multiControllerList2: multiControllerList2,
          multiControllerList3: multiControllerList3,
          multiControllerList4: multiControllerList4,
          multiControllerList5: multiControllerList5);
    } else if (multiCheckboxList[key]) {
      return MultiCheckboxItemWidget(
          index: key,
          multiControllerList1: multiControllerList1,
          multiControllerList2: multiControllerList2,
          multiControllerList3: multiControllerList3,
          multiControllerList4: multiControllerList4,
          multiControllerList5: multiControllerList5);
    } else if (dropdownBoolList[key]) {
      return DropDownWidget(
          index: key,
          multiControllerList1: multiControllerList1,
          multiControllerList2: multiControllerList2,
          multiControllerList3: multiControllerList3,
          multiControllerList4: multiControllerList4,
          multiControllerList5: multiControllerList5);
    } else if (dateTImeBoolList[key]) {
      return DateTimeItemModelWidget(index: key);
    }
    // else if (imageBoolList[key]) {
    //   return DateTimeItemModelWidget(index: key);
    // }
    else {
      return Container();
    }
  }

  onUpdate(
      int key,
      String question,
      String typeWidget,
      String qOui,
      String qNon,
      String multiController1,
      String multiController2,
      String multiController3,
      String multiController4,
      String multiController5) {
    int foundKey = -1;
    for (var map in _values) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }

    if (-1 != foundKey) {
      _values.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      'id': key,
      'value': [
        {'question': question},
        {'typeWidget': typeWidget},
        {'condition': [
            {'qOui': qOui},
            {'qNon': qNon},
          ]
        },
        {'multiChoice': [
            {'multiControllerList1': multiController1},
            {'multiControllerList2': multiController2},
            {'multiControllerList3': multiController3},
            {'multiControllerList4': multiController4},
            {'multiControllerList5': multiController5}
          ]
        }
      ]
    };
    _values.add(json);
    setState(() {
      //_result = _values.toString();
      _result = _prettyPrint(_values);
      print('_values1 $_values');
      print('_result $_result');
    });
  }

  String _prettyPrint(jsonObject) {
    var encoder = const JsonEncoder.withIndent('  ');
    return encoder.convert(jsonObject);
  }

  Future<void> updateCampaign() async {
    final jsonList = _values.map((item) => jsonEncode(item)).toList();
    print('_values2 $_values');
    print('jsonList $jsonList');

    final campaignModel = CampaignModel(
        id: widget.campaignModel.id,
        campaignName: widget.campaignModel.campaignName,
        scripting: jsonList,
        title: widget.campaignModel.title,
        subTitle: widget.campaignModel.subTitle,
        date: widget.campaignModel.date,
        userName: 'Admin',
        superviseur: '');

    await CampaignRepository().updateData(campaignModel);
    // Navigator.of(context).pop();
    // if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("${campaignModel.campaignName} ajouté!"),
    //   backgroundColor: Colors.green[700],
    // ));
  }
}
