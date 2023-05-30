import 'dart:developer';

import 'package:flutter/services.dart';

class NativeCallback {
  static const MethodChannel _platform =
      MethodChannel('com.youtubetutorial.generation/nativeCallBack');

  Future<String> getTheVideoThumbnail({required String videoPath}) async {
    log('Thumbnail Take');

    final String thumbnailPath = await _platform
        .invokeMethod('makeVideoThumbnail', {'videoPath': videoPath});

    log("Thumbnail Path is: $thumbnailPath");

    return thumbnailPath;
  }
}
