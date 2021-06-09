import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/app/modules/auth/data/repository/auth_repository.dart';
import 'package:flutter_application_1/app_routes.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthRepository _authRepo = AuthRepository();
  navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, kLoginRoute, (route) => false);
  }

  navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(context, kHomeRoute, (route) => false);
  }

  @override
  void initState() {
    // verifier que l'utilisateur est connecté ( verifier la clé 'is_connected') du cache
    verifyLoggedInUser();
    super.initState();
  }

  verifyLoggedInUser() async {
    var result = await _authRepo.retrieve();
    print('résultat du cache $result');

    if (result == 'true') {
      print("le user est bien connecté");
      navigateToHome();
    } else {
      navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 130,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Ma calculatrice',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 48, height: 1),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    ));
  }
}