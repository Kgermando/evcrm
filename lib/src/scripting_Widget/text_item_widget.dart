import 'package:flutter/material.dart';

class TextItemWidgetReadOnly extends StatelessWidget {
  const TextItemWidgetReadOnly({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Réponse',
        labelStyle: TextStyle(),
      ),
    );
  }
}

class TextItemWidget extends StatefulWidget {
   const TextItemWidget(
      {Key? key, required this.index, required this.textControllerList})
      : super(key: key);
  final List<TextEditingController> textControllerList;
  final int index;

  @override
  State<TextItemWidget> createState() => _TextItemWidgetState();
}

class _TextItemWidgetState extends State<TextItemWidget> {

  @override
  void initState() {
    setState(() {
      final question = TextEditingController();
      widget.textControllerList.add(question);
    });
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in widget.textControllerList) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textControllerList[widget.index],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Réponse',
        labelStyle: const TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChanged: (value) {
        setState(() {
          widget.textControllerList[widget.index].text = value;
          widget.textControllerList[widget.index].selection = TextSelection.fromPosition(
              TextPosition(offset: widget.textControllerList[widget.index].text.length));
        });
      },
    );
  }
}
