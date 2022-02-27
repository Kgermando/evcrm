import 'package:flutter/material.dart';

class Dropdown {
  List<String> langues = [
    'Français',
    'English',
  ];
}

class DropdownModel {
  final String title;
  final IconData icon;

  DropdownModel(this.title, this.icon);
}

List<DropdownModel> dropdownList = [
  DropdownModel('Select widget', Icons.widgets),
  DropdownModel('Condition', Icons.radio_button_checked),
  DropdownModel('Text', Icons.short_text),
  DropdownModel('MultiRadio', Icons.radio_button_off),
  DropdownModel('MultiCheckBox', Icons.check_box_outline_blank),
  DropdownModel('Dropdown', Icons.arrow_drop_down_circle),
  DropdownModel('DateTIme', Icons.date_range),
  // DropdownModel('Image', Icons.image),
];
