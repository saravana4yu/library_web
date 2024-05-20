import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/profile_page.dart';
import 'package:library_app/pages/sign_in_page.dart';
import 'package:library_app/theme_provider.dart';
import 'package:library_app/language_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Library App',
          theme: themeProvider.getTheme(),
          darkTheme: themeProvider.getDarkTheme(),
          themeMode: themeProvider.getThemeMode(),
          initialRoute: '/signin',
          routes: {
            '/signin': (context) => SignInPage(),
            '/home': (context) => HomePage(),
            '/profile': (context) => ProfilePage(),
          },
        );
      },
    );
  }
}
