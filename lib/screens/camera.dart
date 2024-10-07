import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plant/services/ml_service.dart';
import 'disease.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.high);
    await controller!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Plant Image'),
        backgroundColor:Color.fromARGB(255, 46, 104, 49),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: CameraPreview(controller!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.camera_alt, color: Colors.white), // Icon color set to white
              label: Text('Capture', style: TextStyle(color: Colors.white)), // Text color set to white
              onPressed: () async {
                if (!isDetecting) {
                  setState(() {
                    isDetecting = true;
                  });
                  try {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath = join(directory.path, '${DateTime.now()}.png');
                    final XFile imageFile = await controller!.takePicture();
                    final File file = File(imageFile.path);
                    await file.copy(imagePath);

                    // Predict disease
                    final mlService = MLService();
                    final result = await mlService.predictDisease(imagePath);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiseaseScreen(
                          imagePath: imagePath,
                          disease: result['disease']!,
                          treatment: result['treatment']!,
                        ),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  } finally {
                    setState(() {
                      isDetecting = false;
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
          if (isDetecting) CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
