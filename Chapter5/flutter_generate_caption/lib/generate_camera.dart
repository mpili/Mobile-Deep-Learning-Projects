
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SquareCropCam extends StatefulWidget {
  @override
  _SquareCropCamState createState() => _SquareCropCamState();
}

class _SquareCropCamState extends State<SquareCropCam> {
  CameraController _controller;
  Future<void> _initCamFuture;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  _initApp() async {
    final cameras = await availableCameras();
    final firstCam = cameras.first;

    _controller = CameraController(
      firstCam,
      ResolutionPreset.medium,
    );

    _initCamFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Square Crop Camera Preview")),
      body: FutureBuilder<void>(
        future: _initCamFuture,
        builder: (context, snapshot) {
          
            return Container(
              width: size,
              height: size,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      width: size,
                      height: size / _controller.value.aspectRatio,
                      child: CameraPreview(
                          _controller), // this is my CameraPreview
                    ),
                  ),
                ),
              ),
            );
          
        },
      ),
    );
  }
}

