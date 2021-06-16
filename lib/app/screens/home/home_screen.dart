import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/auth/data/repository/auth_repository.dart';
import 'package:flutter_application_1/app/modules/history/data/repository/history_repository.dart';
import 'package:flutter_application_1/app/screens/history/history_screen.dart';
import 'package:flutter_application_1/app/ui_models/button_element_model.dart';
import 'package:flutter_application_1/app/widgets/calcul_button.dart';
import 'package:function_tree/function_tree.dart';
import 'package:flutter_application_1/app_routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HistoryRepository historyRepository = HistoryRepository();
  AuthRepository authRepository = AuthRepository();

  final elements = [
    [
      ButtonElement(content: 'C'),
      ButtonElement(content: '('),
      ButtonElement(content: ')'),
      ButtonElement(content: '/')
    ],
    [
      ButtonElement(content: '7', isDark: true),
      ButtonElement(content: '8', isDark: true),
      ButtonElement(content: '9', isDark: true),
      ButtonElement(content: '*')
    ],
    [
      ButtonElement(content: '4', isDark: true),
      ButtonElement(content: '5', isDark: true),
      ButtonElement(content: '6', isDark: true),
      ButtonElement(content: '-')
    ],
    [
      ButtonElement(content: '1', isDark: true),
      ButtonElement(content: '2', isDark: true),
      ButtonElement(content: '3', isDark: true),
      ButtonElement(content: '+')
    ],
    [
      ButtonElement(content: '0', isDark: true, isBig: true),
      ButtonElement(content: '.', isDark: true),
      ButtonElement(content: '='),
    ],
  ];

  returnBackToSplash(context) {
    Navigator.pop(context);
  }

  String equation = '';
  List<String> equationOperator = [];
  List<String> equationElements = [];
  double result = 0;
  String currentDouble = '';
  String last_stored_result = '0';

  onButtonTap(String element) {
    if (element == 'C') {
      remove();
    } else if (element == '=') {
      interpretEquation();
    } else {
      addToEquation(element);
      if (['X', '-', '+', '/'].contains(element)) {
        print('adding element to operator');
        addOperatorToEquation(element);
      } else {
        addElementToEquation(element);
      }
    }
  }

  interpretEquation() {
    setState(() {
      result = equation.interpret().toDouble();
    });
    saveToCache();
  }

  navigateToHistory(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryScreen()),
    );
  }

  navigateToScanScreen() {
    Navigator.pushNamed(context, kScanRoute);
  }

  addToEquation(String element) {
    setState(() {
      equation += element;
    });
    print(equation);
  }

  addOperatorToEquation(String op) {
    equationOperator.add(op);
  }

  addElementToEquation(String element) {
    equationElements.add(element);
  }

  remove() {
    setState(() {
      equation = '';
      equationOperator = [];
      equationElements = [];
      result = 0;
    });
  }

  saveToCache() async {
    historyRepository.saveResult(result);
    setState(() {
      last_stored_result = result.toString();
    });
  }

  retrieveFromCache() async {
    last_stored_result = (await historyRepository.retrieve()) ?? '0';
    setState(() {});
  }

  //fonction appelée à la création du stateful widget
  @override
  void initState() {
    retrieveFromCache();
    super.initState();
  }

  logout() async {
    await authRepository.logout();
    Navigator.pushNamedAndRemoveUntil(context, kLoginRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Image.asset('assets/images/logo.png')) 
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.save),
              color: Colors.white,
              onPressed: () {
                navigateToHistory(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                logout();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.camera),
              color: Colors.white,
              onPressed: () {
                navigateToScanScreen();
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      'Dernier résultat calculé : ${last_stored_result.toString()}'),
                  Text(
                    equation.toString(),
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text(
                    result.toString(),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Container(
                child: Column(
                    children: elements
                        .map((elementList) => Row(
                              children: elementList
                                  .map((e) => CalculButton(
                                        content: e.content,
                                        isDark: e.isDark,
                                        isBig: e.isBig,
                                        onTapFcuntion: () =>
                                            onButtonTap(e.content),
                                      ))
                                  .toList(),
                            ))
                        .toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
