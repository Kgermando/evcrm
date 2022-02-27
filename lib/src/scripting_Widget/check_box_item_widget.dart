import 'package:flutter/material.dart';

class CheckBoxItemWidget extends StatefulWidget {
  const CheckBoxItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  
  @override
  State<CheckBoxItemWidget> createState() => _CheckBoxItemWidgetState();
}

class _CheckBoxItemWidgetState extends State<CheckBoxItemWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
