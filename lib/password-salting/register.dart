import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _salt;
  String? _hashedPassword;

  String generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64.encode(values);
  }

  String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _register() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      // Generate salt and hash password
      _salt = generateSalt();
      _hashedPassword = hashPassword(password, _salt!);

      // Display results
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
            SizedBox(height: 20),
            if (_salt != null && _hashedPassword != null) ...[
              Text('Generated Salt: $_salt'),
              SizedBox(height: 10),
              Text('Hashed Password: $_hashedPassword'),
            ],
          ],
        ),
      ),
    );
  }
}
