import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class VideoC extends StatefulWidget {
  const VideoC({super.key});

  @override
  State<VideoC> createState() => _VideoCState();
}

class _VideoCState extends State<VideoC> {
  List<CameraDescription>? cameras;
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void startVideoRecording() async {
    if (!controller!.value.isInitialized) {
      return;
    }
    final Directory? appDirectory = await getExternalStorageDirectory();
    final String videoDirectory = '${appDirectory!.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/$timestamp.mp4';

    try {
      await controller!.startVideoRecording(
        onAvailable: (image) {},
      );
    } on CameraException catch (e) {
      print(e);
      return;
    }
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.high);
    await controller!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: CameraPreview(controller!),
    );
  }
}
