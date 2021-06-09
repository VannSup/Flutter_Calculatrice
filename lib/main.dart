import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: kMainRoute,
      routes: kRoutes,
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}
