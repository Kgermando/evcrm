import 'package:crm_spx/src/routing/enum.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  DisplayPage? currentPage;

  AppProvider.init() { 
    changeCurrentPage(DisplayPage.dashboard);
  }

  changeCurrentPage(DisplayPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }

}
