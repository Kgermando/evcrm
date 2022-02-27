import 'dart:convert';

import 'package:flutter/material.dart';

enum SingingCharacter { oui, non }


class MulitiItemwidget extends StatefulWidget {
  const MulitiItemwidget({ Key? key, 
  required this.index, 
  required this.multiControllerList1, 
  required this.multiControllerList2, 
  required this.multiControllerList3, 
  required this.multiControllerList4, 
  required this.multiControllerList5 }) : super(key: key);
  
  final int index;
  final List<TextEditingController> multiControllerList1;
  final List<TextEditingController> multiControllerList2;
  final List<TextEditingController> multiControllerList3;
  final List<TextEditingController> multiControllerList4;
  final List<TextEditingController> multiControllerList5;

  @override
  State<MulitiItemwidget> createState() => _MulitiItemwidgetState();
}

class _MulitiItemwidgetState extends State<MulitiItemwidget> {
  @override
  Widget build(BuildContext context) {
    SingingCharacter? _character = SingingCharacter.oui;
    return SizedBox(
      height: 400,
      child: Column(
      children: [
        ListTile(
          title: TextFormField(
            controller: widget.multiControllerList1[widget.index],
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Proposition 1',
              labelStyle: TextStyle(),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
            onChanged: (value) {
              setState(() {
                widget.multiControllerList1[widget.index].text = value;
                widget.multiControllerList1[widget.index].selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: widget
                            .multiControllerList1[widget.index]
                            .text.length));
              });
            },
          ),
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
          title: TextFormField(
            controller: widget.multiControllerList2[widget.index],
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Proposition 2',
              labelStyle: TextStyle(),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
            onChanged: (value) {
              setState(() {
                widget.multiControllerList2[widget.index].text = value;
                widget.multiControllerList2[widget.index].selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: widget
                            .multiControllerList2[widget.index].text.length));
              });
            },
          ),
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
          title: TextFormField(
            controller: widget.multiControllerList3[widget.index],
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Proposition 3',
              labelStyle: TextStyle(),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
            onChanged: (value) {
              setState(() {
                widget.multiControllerList3[widget.index].text = value;
                widget.multiControllerList3[widget.index].selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: widget
                            .multiControllerList3[widget.index].text.length));
              });
            },
          ),
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
          title: TextFormField(
            controller: widget.multiControllerList4[widget.index],
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Proposition 4',
              labelStyle: TextStyle(),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
            onChanged: (value) {
              setState(() {
                widget.multiControllerList4[widget.index].text = value;
                widget.multiControllerList4[widget.index].selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: widget
                            .multiControllerList4[widget.index].text.length));
              });
            },
          ),
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
          title: TextFormField(
            controller: widget.multiControllerList5[widget.index],
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Proposition 5',
              labelStyle: TextStyle(),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
            onChanged: (value) {
              setState(() {
                widget.multiControllerList5[widget.index].text = value;
                widget.multiControllerList5[widget.index].selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: widget
                            .multiControllerList5[widget.index].text.length));
              });
            },
          ),
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
      ],
    )
    );
  }
}
