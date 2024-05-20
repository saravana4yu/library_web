import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light()
        .textTheme
        .apply(fontFamily: 'Poppins', bodyColor: Colors.black),
    primaryColor: Color.fromARGB(255, 255, 255, 255),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 255, 255, 255),
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 255, 255, 255),
      onSecondary: Color.fromARGB(255, 0, 0, 0),
      error: Colors.red,
      onError: Color.fromARGB(255, 255, 255, 255),
      surface: Color.fromARGB(255, 255, 255, 255),
      onSurface: Color.fromARGB(255, 0, 0, 0),
      tertiary: Color.fromARGB(255, 244, 244, 244),
    ),
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
  );

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark()
        .textTheme
        .apply(fontFamily: 'Poppins', bodyColor: Colors.white),
    primaryColor: Color.fromARGB(255, 0, 0, 0),
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 0, 0, 0),
        onPrimary: Color.fromARGB(255, 255, 255, 255),
        secondary: Color.fromARGB(255, 0, 0, 0),
        onSecondary: Color.fromARGB(255, 255, 255, 255),
        error: Colors.red,
        onError: Colors.white,
        surface: Color.fromARGB(255, 0, 0, 0),
        onSurface: Color.fromARGB(255, 255, 255, 255),
        tertiary: Color.fromARGB(255, 25, 25, 27)),
    scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
  );

  late SharedPreferences _prefs;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  ThemeData getTheme() => _lightTheme;
  ThemeData getDarkTheme() => _darkTheme;

  ThemeMode getThemeMode() {
    bool isDarkMode = _prefs.getBool('is_dark_mode') ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode => getThemeMode() == ThemeMode.dark;

  void toggleTheme() {
    bool isDarkMode = _prefs.getBool('is_dark_mode') ?? false;
    _prefs.setBool('is_dark_mode', !isDarkMode);
    notifyListeners();
  }
}
