import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:flutter/material.dart';

class ListCallPage extends StatefulWidget {
  const ListCallPage({ Key? key }) : super(key: key);

  @override
  _ListCallPageState createState() => _ListCallPageState();
}

class _ListCallPageState extends State<ListCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [
        CustomAppbar(title: 'Calls'),
        SizedBox(height: 16.0),
      ]),
    );
  }
}