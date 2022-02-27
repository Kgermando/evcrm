import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DateTimeItemModelWidget extends StatefulWidget {
  const DateTimeItemModelWidget({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  State<DateTimeItemModelWidget> createState() =>
      _DateTimeItemModelWidgetState();
}

class _DateTimeItemModelWidgetState extends State<DateTimeItemModelWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.date_range),
        const SizedBox(width: 10.0,),
        Text('${DateTime.now()}')
      ],
    );
  }
}

class DateTimeItemWidget extends StatefulWidget {
  const DateTimeItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _DateTimeItemWidgetState createState() => _DateTimeItemWidgetState();
}

class _DateTimeItemWidgetState extends State<DateTimeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      initialValue: '',
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      dateLabelText: 'Date',
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );
    
    // DatePickerDialog(
    //   restorationId: 'date_picker_dialog',
    //   initialEntryMode: DatePickerEntryMode.calendarOnly,
    //   initialDate: DateTime(2022),
    //   firstDate: DateTime(2021),
    //   lastDate: DateTime(2022),
    // );
  }
}
