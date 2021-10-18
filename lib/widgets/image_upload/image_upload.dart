import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UploadImageWidget extends StatelessWidget {
  final VoidCallback callback;
  final File image;
  const UploadImageWidget({Key key, this.callback, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 140.w,
        width: 140.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 4),
        ),
        child: image==null?Icon(Icons.add_photo_alternate,color: const Color(0xff0066CC),size: 40.w,):Image.file(image,fit: BoxFit.cover,),
      ),
    );
  }
}
