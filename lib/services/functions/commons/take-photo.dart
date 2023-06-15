import 'dart:async';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

void takePhoto(String albumName) async {
  ImagePicker()
      .pickImage(source: ImageSource.camera)
      .then((PickedFile recordedImage) {
        GallerySaver.saveImage(recordedImage.path, albumName: albumName);
      } as FutureOr Function(XFile? value));

}
