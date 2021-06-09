import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/history/model/history_model.dart';

class HistoryDetailsScreen extends StatefulWidget {
  const HistoryDetailsScreen({required this.data});
  final History data;

  //dans un stateless on ne change pas d'état
  @override
  _HistoryDetailsScreenState createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.data.isChecked;
    super.initState();
  }

  backToHistory(context, bool result) {
    Navigator.of(context).pop(result);
  }

  changeButton() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(isChecked);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          title: Text(
            'Détails du calcul',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Hero(
                          tag: 'my_image',
                          child: Image.asset('assets/images/logo.png')),
                      Text(widget.data.title),
                      Text(widget.data.dateTime.toString()),
                      Text(widget.data.result.toString()),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        changeButton();
                      },
                      icon: Icon(
                        isChecked ? Icons.cancel : Icons.check,
                        color: isChecked ? Colors.red : Colors.green,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
