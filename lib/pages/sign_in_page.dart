import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(fontSize: 36),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.0),
                ),
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.0),
                ),
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              obscureText: true,
            ),
            SizedBox(height: 40.0),
            // Sign in buutton routing to home page after validating credentials
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text.trim();
                String password = _passwordController.text.trim();

                bool isValid = _validateCredentials(username, password);

                if (isValid) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('username', username);
                  prefs.setString('password', password);

                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  setState(() {
                    _errorMessage = 'Invalid username or password';
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey; // Disabled color
                    }
                    return Colors.blue; // Enabled color
                  },
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  // validating credentials function
  bool _validateCredentials(String username, String password) {
    const String correctUsername = 'admin';
    const String correctPassword = 'password';

    return username == correctUsername && password == correctPassword;
  }
}
