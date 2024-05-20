import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'English';

  List<String> _supportedLanguages = ['English', 'Spanish'];

  final Map<String, Map<String, String>> _localizedStrings = {
    'English': {
      'home_title': 'Home',
      'profile': 'Profile',
      'search_books': 'Search Books',
      'author': 'Author',
      'availability': 'Availability',
      'available': 'Available',
      'not_available': 'Not Available',
      'sign_out': 'Sign Out',
      'language': 'Language',
      'name': 'Username'
    },
    'Spanish': {
      'home_title': 'Inicio',
      'profile': 'Perfil',
      'search_books': 'Buscar Libros',
      'author': 'Autor',
      'availability': 'Disponibilidad',
      'available': 'Disponible',
      'not_available': 'No Disponible',
      'sign_out': 'Cerrar Sesión',
      'language': 'Idiomas',
      'name': 'Nombre de usuario'
    },
  };

  List<String> get supportedLanguages => _supportedLanguages;

  String getText(String key) {
    return _localizedStrings[_currentLanguage]?[key] ?? '';
  }

  String get currentLanguage => _currentLanguage;

  void changeLanguage(String newLanguage) {
    _currentLanguage = newLanguage;
    notifyListeners();
  }
}
