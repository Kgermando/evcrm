import 'package:flutter/material.dart';


class PressBackButton {
  
   Future<bool> onWillPop(BuildContext context) async {
    final pop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Tem certeza'),
              content: const Text('Quer sair do app?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Non')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('OUi')),
              ],
            ));
    return pop ?? false;
  }
}