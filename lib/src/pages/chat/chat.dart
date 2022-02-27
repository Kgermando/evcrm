import 'package:crm_spx/src/navigation/header/custom_appbar.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({ Key? key }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  
  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      body: Column(
        children: [
         const CustomAppbar(title: 'Messenger'),
         SizedBox(height: MediaQuery.of(context).size.height / 3),
         Image.asset('assets/images/chat.png', height: 200),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headline2!,
            textAlign: TextAlign.center,
            child: Text('Bientôt disponible.', style: headline6)
          )
        ],
      ),
    );
  }
}