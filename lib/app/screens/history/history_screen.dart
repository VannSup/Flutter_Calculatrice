import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> historyList = [
    {'title': 'Total achats', 'date': '3 mars 2O21', 'result': '299'},
    {'title': 'Mes dépenses', 'date': '1 mars 2O21', 'result': '1990.90'},
    {'title': 'Mes dépenses', 'date': '1 mars 2O21', 'result': '1990.90'},
    {'title': 'Mes dépenses', 'date': '1 mars 2O21', 'result': '1990.90'},
    {'title': 'Mes dépenses', 'date': '1 mars 2O21', 'result': '1990.90'},
    {'title': 'Mes dépenses', 'date': '1 mars 2O21', 'result': '1990.90'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Calcul récents',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        //elevation : effet ombre
        elevation: 0,
        //boutons d'action à droite de l'AppBar
        actions: [
          IconButton(
              icon: Icon(
                Icons.format_list_numbered,
                color: Colors.black,
              ),
              onPressed: null)
        ],
      ),
      body: ListView(
          children: historyList
              .map(
                (Map<String, String> element) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            element['title']!,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            element['date']!,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Text(
                            element['result']!,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w900),
                          )
                        ]),
                  ),
                ),
              )
              .toList()),
    );
  }
}
