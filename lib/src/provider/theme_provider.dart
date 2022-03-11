import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isLightMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.light;
    } else {
      return themeMode == ThemeMode.light;
    }
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.dark(),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     elevation: MaterialStateProperty.all(5.0),
    //     shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    //       return RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(30.0));
    //     }),
    //     textStyle: MaterialStateProperty.all(
    //       const TextStyle(
    //       color: Colors.white,
    //     )),
    //   foregroundColor: MaterialStateProperty.all(Colors.teal),
    // )),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ButtonStyle(
    //     elevation: MaterialStateProperty.all(5.0),
    //     shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    //       return RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(30.0));
    //     }),
    //     textStyle: MaterialStateProperty.all(
    //       const TextStyle(
    //         color: Colors.white,
    //       )
    //     ),
    //     backgroundColor: MaterialStateProperty.all(Colors.teal),
    //   ),
    // ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blue.shade50,
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     elevation: MaterialStateProperty.all(5.0),
    //     shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    //       return RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0));
    //     }),
    //     textStyle: MaterialStateProperty.all(const TextStyle(
    //       color: Colors.white,
    //     )),
    //     foregroundColor: MaterialStateProperty.all(Colors.teal),
    //   )
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ButtonStyle(
    //     elevation: MaterialStateProperty.all(5.0),
    //     shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    //       return RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(30.0));
    //     }),
    //     textStyle: MaterialStateProperty.all(const TextStyle(
    //       color: Colors.white,
    //     )),
    //     backgroundColor: MaterialStateProperty.all(Colors.teal),
    //   ),
    // ),
    primaryColor: Colors.white,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.light(),
    // iconTheme: const IconThemeData(color: Colors.orange, opacity: 0.8),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
