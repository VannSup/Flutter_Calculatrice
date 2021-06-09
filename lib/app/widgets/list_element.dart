import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/history/model/history_model.dart';

class ListElement extends StatelessWidget {
  const ListElement({required this.element});

  final History element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  element.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                    '${element.dateTime.day}/${element.dateTime.month + 1}/${element.dateTime.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(
                  element.result.toString(),
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Icon(
                element.isChecked ? Icons.check : Icons.cancel,
                color: element.isChecked ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
