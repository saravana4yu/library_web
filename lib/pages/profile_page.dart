import 'package:flutter/material.dart';
import 'package:library_app/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadSelectedLanguage();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final supportedLanguages = languageProvider.supportedLanguages;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.getText('profile'),
          style: TextStyle(fontSize: 36),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 8, right: 14),
            //language menu to switch between languages
            child: PopupMenuButton(
              icon: Icon(
                Icons.language,
                size: 38,
              ),
              itemBuilder: (BuildContext context) {
                return supportedLanguages.map((language) {
                  return PopupMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList();
              },
              onSelected: (selectedLanguage) async {
                languageProvider.changeLanguage(selectedLanguage);
                setState(() {
                  _selectedLanguage = selectedLanguage;
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('selectedLanguage', selectedLanguage);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                languageProvider.getText('name') + ': $_username',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5.0),
              Text(
                languageProvider.getText('language') + ': $_selectedLanguage',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20.0),
              //sign out button routing to sign in page
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();

                  Navigator.pushReplacementNamed(context, '/signin');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  languageProvider.getText('sign_out'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
