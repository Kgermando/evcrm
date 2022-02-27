import 'package:flutter/material.dart';

class MultiCheckboxItemWidget extends StatefulWidget {
 const MultiCheckboxItemWidget({ Key? key, 
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
  State<MultiCheckboxItemWidget> createState() => _MultiCheckboxItemWidgetState();
}

class _MultiCheckboxItemWidgetState extends State<MultiCheckboxItemWidget> {
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
                            offset: widget.multiControllerList1[widget.index]
                                .text.length));
                  });
                },
              ),
              leading: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              )
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
                            offset: widget.multiControllerList2[widget.index]
                                .text.length));
                  });
                },
              ),
              leading: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                )
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
                            offset: widget.multiControllerList3[widget.index]
                                .text.length));
                  });
                },
              ),
              leading: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                )
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
                            offset: widget.multiControllerList4[widget.index]
                                .text.length));
                  });
                },
              ),
              leading: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                )
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
                            offset: widget.multiControllerList5[widget.index]
                                .text.length));
                  });
                },
              ),
              leading: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              )
            ),
          ],
        ));
  }
}

class MultiCheckboxItem extends StatefulWidget {
  const MultiCheckboxItem({ Key? key, required this.index }) : super(key: key);
  final int index;

  @override
  State<MultiCheckboxItem> createState() => _MultiCheckboxItemState();
}

class _MultiCheckboxItemState extends State<MultiCheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}