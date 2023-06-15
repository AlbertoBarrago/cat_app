import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

Future<void> downloadImageOnDevice(String imageUrl) async {
  try {
    var imageId = await ImageDownloader.downloadImage(
        imageUrl);
    if (imageId == null) {
      return;
    }

    //Below is a method of obtaining saved image information.
    // var fileName = await ImageDownloader.findName(imageId);
    // var path = await ImageDownloader.findPath(imageId);
    // var size = await ImageDownloader.findByteSize(imageId);
    // var mimeType = await ImageDownloader.findMimeType(imageId);

    // await ImageDownloader.open(imageId);
  } on PlatformException catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
}

getApplicationDocumentsDirectory() {
}
