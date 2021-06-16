import 'package:flutter/material.dart';
import 'dart:io';

class ScanDetailsScreen extends StatelessWidget {
  final String imagePath;
  const ScanDetailsScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, leading: BackButton(color: Colors.black)),
        body: Column(
          children: [
            Text('Ma facture'),
            Image.file(File(imagePath)),
          ],
        ));
  }
}