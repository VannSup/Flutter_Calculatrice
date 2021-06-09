import 'package:flutter/material.dart';

class CalculButton extends StatelessWidget {
  const CalculButton(
      {required this.content,
      this.isDark = false,
      this.isBig = false,
      required this.onTapFcuntion});

  final String content;
  final bool isDark;
  final bool isBig;
  final Function onTapFcuntion;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isBig ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: InkWell(
            splashColor: Colors.red.withOpacity(0.4),
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () => {onTapFcuntion()},
            child: Ink(
              height: 50,
              child: Center(
                child: Container(
                  child: Text(
                    content,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: isDark == true ? Colors.white : Colors.black),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: isDark == true ? Colors.black : Colors.white,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
