import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/app/modules/scan/data/repository/scan_repository.dart';
import 'package:flutter_application_1/app_routes.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  //controlleur de la camera ( nous permet d'appeler des méthodes ( takePicture))
  CameraController? controller;

  // liste des cameras dans le device
  List<CameraDescription> cameras = [];

  //type de variable permettant de sauvegarder les données d'un image capturée
  XFile? capturedImage;

  List<XFile> capturedImagesList = [];

  // Repository cache
  ScanRepository scanRepository = ScanRepository();

  // Last scan
  String last_scan_stored_result = '';

  //fonction appelée à la création d'un statefulWidget
  @override
  void initState() {
    super.initState();
    loadCameras();
  }

  saveToCache() async {
    scanRepository.saveScan(last_scan_stored_result);
    setState(() {});
  }

  retrieveFromCache() async {
    last_scan_stored_result = (await scanRepository.retrieveScan()) ?? '';
    setState(() {});
  }

  loadCameras() async {
    cameras = await availableCameras();

    if (cameras.length > 0) {
      print(cameras);

      controller = CameraController(cameras[0], ResolutionPreset.low);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  navigateToDetail(String imagePath) {
    Navigator.pushNamed(context, kScanDetailsRoute, arguments: imagePath);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  capturePicture() async {
    if (!controller!.value.isTakingPicture) {
      capturedImage = await controller!.takePicture();
      print(capturedImage);
      last_scan_stored_result = capturedImage!.path;
      addPictureToList();
      saveToCache();
      setState(() {});
    }
  }

  addPictureToList() {
    //add new captured image to the list (capturedImagesList)
    if (capturedImage != null) {
      capturedImagesList.add(capturedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller == null
          ? Container()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                        Text('Scan factures',
                            style: TextStyle(fontSize: 32),textAlign: TextAlign.center,),
                    Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          CameraPreview(controller!),
                          OutlinedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.black)))),
                            onPressed: () {
                              capturePicture();
                            },
                            child: Text('Capturer',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ]),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('Ma dernière facture',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    last_scan_stored_result == ''
                        ? Container()
                        : Image.file(File(last_scan_stored_result),filterQuality: FilterQuality.low),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('Mes factures',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    capturedImage == null
                        ? Container()
                        : GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: capturedImagesList
                                .map((e) => Container(
                                      child: Image.file(File(e.path),filterQuality: FilterQuality.low),
                                    ))
                                .toList())
                  ],
                ),
              ),
            ),
    );
  }
}
