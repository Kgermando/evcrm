import 'package:flutter/material.dart';

enum SingingCharacter { oui, non }




class RadioItemWidgetReadyOnly extends StatelessWidget {
  const RadioItemWidgetReadyOnly({Key? key, required this.index}) : super(key: key);
  final int index;

  final SingingCharacter? _character = SingingCharacter.oui;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('OUI'),
      leading: Radio<SingingCharacter>(
        value: SingingCharacter.oui,
        groupValue: _character,
        onChanged: (SingingCharacter? value) {},
      ),
    );
  }
}

class RadioItemWidget extends StatefulWidget {
 const RadioItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  
  @override
  _RadioItemWidgetState createState() => _RadioItemWidgetState();
}

class _RadioItemWidgetState extends State<RadioItemWidget> {
  SingingCharacter? _character = SingingCharacter.oui;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('OUI'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.oui,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('NON'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.non,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
