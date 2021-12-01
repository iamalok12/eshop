import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader{
  final String text="Image";
  static final _picker=ImagePicker();
  static Future<File> addImage()async{
    try{
      final pickedFile=await _picker.pickImage(source: ImageSource.gallery);
      if(pickedFile!=null){
        final File cropped=await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
            backgroundColor: Colors.white,
            activeControlsWidgetColor: Color(0xff0066CC),
            dimmedLayerColor: Colors.black26,
          ),
        );
        return File(cropped.path);
      }
      else{
        return null;
      }
    }
    catch(e){
      return null;
    }
  }
}
