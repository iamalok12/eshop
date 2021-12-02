import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoadingWidget{
  final String message="Loading";
  static void showLoading(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return LoadingIndicator();
        },);
  }
  static void removeLoading(BuildContext context){
    Navigator.pop(context);
  }
}
