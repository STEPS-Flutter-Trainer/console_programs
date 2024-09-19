import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CaptchaWidget extends StatefulWidget {
  @override
  _CaptchaWidgetState createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  String _captcha = '';
  final TextEditingController _captchaController = TextEditingController();
  String _validationMessage = '';

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    _captcha = randomAlpha(6);
    _validationMessage = ''; // Clear any previous validation message
    _captchaController.clear(); // Clear the text field
    setState(() {});
  }

  void _validateCaptcha() {
    if (_captchaController.text == _captcha) {
      setState(() {
        _validationMessage = 'CAPTCHA is correct!';
      });
    } else {
      setState(() {
        _validationMessage = 'CAPTCHA is incorrect. Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _captcha,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _captchaController,
          decoration: InputDecoration(
            hintText: 'Enter CAPTCHA',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _validateCaptcha,
          child: Text('Verify CAPTCHA'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _generateCaptcha,
          child: Text('Generate New CAPTCHA'),
        ),
        SizedBox(height: 20),
        Text(
          _validationMessage,
          style: TextStyle(
            fontSize: 16,
            color: _validationMessage.contains('correct') ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
