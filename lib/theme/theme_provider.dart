import 'package:flutter/material.dart';
import 'package:isar_app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier{
  //Initially theme is light mode
  ThemeData _themeData = lightMode;

  //getter method to access the theme from other parts of the code
  ThemeData get themeData => _themeData;

  //getter method is to see that we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //setter method to set the new theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  //we will use toggle in a switch later
  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}