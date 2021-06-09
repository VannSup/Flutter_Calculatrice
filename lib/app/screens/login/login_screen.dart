import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LoginForm(),
      ),
    );
  }
}
