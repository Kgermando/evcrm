import 'package:flutter/material.dart';

class SwitchItemWidget extends StatefulWidget {
  const SwitchItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  _SwitchItemWidgetState createState() => _SwitchItemWidgetState();
}

class _SwitchItemWidgetState extends State<SwitchItemWidget> {
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
    );
  }
}
