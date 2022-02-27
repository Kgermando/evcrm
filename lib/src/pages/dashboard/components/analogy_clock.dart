import 'package:analog_clock/analog_clock.dart';
import 'package:crm_spx/src/provider/theme_provider.dart';
import 'package:flutter/material.dart';

class AnalogyClock extends StatefulWidget {
  const AnalogyClock({ Key? key }) : super(key: key);

  @override
  _AnalogyClockState createState() => _AnalogyClockState();
}

class _AnalogyClockState extends State<AnalogyClock> {
  @override
  Widget build(BuildContext context) {
    return AnalogClock(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, 
        color: ThemeProvider().isDarkMode ? Colors.teal : Colors.black,
        ),
        color: Colors.transparent,
        shape: BoxShape.circle
      ),
      width: 150.0,
      isLive: true,
      hourHandColor: ThemeProvider().isDarkMode ? Colors.teal : Colors.black,
      minuteHandColor: ThemeProvider().isDarkMode ? Colors.teal : Colors.black,
      showSecondHand: false,
      numberColor: ThemeProvider().isDarkMode ? Colors.teal : Colors.black87,
      showNumbers: true,
      textScaleFactor: 1.4,
      showTicks: false,
      // showDigitalClock: false,
      datetime: DateTime.now(),
      );
  }
}