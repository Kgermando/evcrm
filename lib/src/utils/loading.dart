import 'package:flutter/material.dart';

Widget loading() => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    CircularProgressIndicator(
      // color: ThemeProvider().isDarkMode ? Colors.white : Colors.teal
    ),
    SizedBox(width: 20.0,),
    Text('Patientez svp...', style: TextStyle(
      // color: ThemeProvider().isDarkMode ? Colors.white : Colors.teal
      )
    )
  ],
);


Widget loadingMini() => const CircularProgressIndicator(
  // color: ThemeProvider().isDarkMode ? Colors.white : Colors.teal, strokeWidth: 2.0,
);
