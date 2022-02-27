import 'dart:io';

import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/models/annuaire_model.dart';
import 'package:crm_spx/src/pages/annuaire/update_annuaire.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailAnnuaire extends StatefulWidget {
  const DetailAnnuaire(
      {Key? key, required this.annuaireModel, required this.color})
      : super(key: key);
  final AnnuaireModel annuaireModel;
  final Color color;

  @override
  _DetailAnnuaireState createState() => _DetailAnnuaireState();
}

class _DetailAnnuaireState extends State<DetailAnnuaire> {
  bool isLoading = false;

  bool _hasCallSupport = false;
  Future<void>? _launched;

  // final _form = GlobalKey<FormState>();

  // String? subject;
  // String? emailAdress;
  // String? message;
  String? sendDate;

  @override
  void initState() {
    super.initState();
    userPrefs();
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  String? role;

  Future userPrefs() async {
    var user = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      role = user.role;
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    // final headline4 = Theme.of(context).textTheme.headline4;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    final _size = MediaQuery.of(context).size;
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
          actions: [
            if (role != 'Agent') editButton(),
            if (role != 'Agent') deleteButton()
          ],
          elevation: 0,
          // backgroundColor: widget.color,
          // foregroundColor: Colors.white,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
                isAlwaysShown: true,
                child: ListView(
                  padding: Responsive.isDesktop(context)
                      ? const EdgeInsets.all(20.0)
                      : const EdgeInsets.all(8.0),
                  children: [
                    if (widget.annuaireModel.nomPostnomPrenom.isNotEmpty)
                      Container(
                        height: _size.height / 4,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(color: widget.color),
                        child: Responsive.isDesktop(context)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.perm_contact_cal_sharp,
                                    size: 40.0,
                                    // color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: _size.width / 2,
                                    child: Text(
                                      widget.annuaireModel.nomPostnomPrenom,
                                      // style: headline4,
                                      style: const TextStyle(fontSize: 30.0),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: _hasCallSupport
                                              ? () => setState(() {
                                                  _launched =
                                                      _makePhoneCall(widget.annuaireModel.mobile1);
                                                })
                                            : null,
                                          icon: const Icon(
                                            Icons.call,
                                            size: 40.0,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            if (Platform.isAndroid) { }
                                          },
                                          icon: const Icon(
                                            Icons.sms,
                                            size: 40.0,
                                            color: Colors.green,
                                        )
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () => {},
                                        icon: const Icon(
                                          Icons.email_sharp,
                                          size: 40.0,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.perm_contact_cal_sharp,
                                        size: 40.0,
                                        // color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: _size.width / 2,
                                        child: Text(
                                          widget.annuaireModel.nomPostnomPrenom,
                                          // style: headline4,
                                          style: Responsive.isDesktop(context)
                                              ? const TextStyle(fontSize: 30.0)
                                              : const TextStyle(
                                                  // color: Colors.white,
                                                  fontSize: 16.0),
                                        ), 
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: _hasCallSupport
                                              ? () => setState(() {
                                                  _launched =
                                                      _makePhoneCall(widget.annuaireModel.mobile1);
                                                })
                                            : null,
                                          icon: const Icon(
                                            Icons.call,
                                            size: 40.0,
                                            color: Colors.green,
                                          )),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () => {},
                                        icon: const Icon(
                                          Icons.email_sharp,
                                          size: 40.0,
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    const SizedBox(height: 16.0),
                    if (!widget.annuaireModel.email.contains('null'))
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Icon(Icons.email_sharp, color: widget.color),
                          title: Text(
                            widget.annuaireModel.email,
                            style: bodyText2,
                          ),
                        ),
                      ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(Icons.call, color: widget.color, size: 40,),
                        title: Text(
                          widget.annuaireModel.mobile1,
                          style: bodyText2,
                        ),
                        subtitle: (!widget.annuaireModel.mobile2.contains('null')) ? Text(
                          widget.annuaireModel.mobile2,
                          style: bodyText2,
                        ) : Container(),
                      ),
                    ),
                    if (!widget.annuaireModel.secteurActivite.contains('null'))
                    Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Icon(Icons.local_activity, color: widget.color),
                        title: Text(
                          widget.annuaireModel.secteurActivite,
                          style: bodyText2,
                        ),
                      ),
                    ),
                    if (!widget.annuaireModel.nomEntreprise.contains('null'))
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Icon(Icons.business, color: widget.color),
                          title: Text(
                            widget.annuaireModel.nomEntreprise,
                            style: bodyText2,
                          ),
                        ),
                      ),
                    
                    if (!widget.annuaireModel.grade.contains('null'))
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Icon(Icons.grade, color: widget.color),
                          title: Text(
                            widget.annuaireModel.grade,
                            style: bodyText2,
                          ),
                        ),
                      ),
                    if (!widget.annuaireModel.adresseEntreprise.contains('null'))
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Icon(Icons.place_sharp, color: widget.color),
                          title: Text(
                            widget.annuaireModel.adresseEntreprise,
                            style: bodyText2,
                          ),
                        ),
                      ),
                  ],
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
          builder: (context) =>
              UpdateAnnuaire(annuaireModel: widget.annuaireModel),
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
                // await AnnuaireRepository().deleteData(widget.annuaireModel.id!);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${widget.annuaireModel.nomPostnomPrenom} vient d'être supprimé!"),
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

  // Future<void> send() async {
  //   final Email email = Email(
  //     body: '',
  //     subject: '',
  //     recipients: [widget.annuaireModel.email],
  //     // attachmentPaths: attachments,
  //     isHTML: false,
  //   );

  //   String platformResponse;

  //   try {
  //     await FlutterEmailSender.send(email);
  //     platformResponse = 'success';
  //   } catch (error) {
  //     platformResponse = error.toString();
  //   }

  //   if (!mounted) return;

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(platformResponse),
  //     ),
  //   );
  // }
}
