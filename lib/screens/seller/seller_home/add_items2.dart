import 'dart:io';

import 'package:eshop/models/models.dart';
import 'package:eshop/screens/seller/seller_home/seller_root.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class AddItems2 extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productDescription;
  const AddItems2({Key key, this.productName, this.productPrice, this.productDescription}) : super(key: key);
  @override
  _AddItems2State createState() => _AddItems2State();
}
class _AddItems2State extends State<AddItems2> {


  File _image1;
  File _image2;
  File _image3;
  File _image4;

  String url1;
  String url2;
  String url3;
  String url4;

  Future<String> uploadImageAndGetUrl(File image)async{
    final Reference itemPicRef=FirebaseStorage.instance.ref().child("Items pic");
    final String nameForPicture=DateTime.now().microsecondsSinceEpoch.toString();
    final UploadTask uploadTask=itemPicRef.child("$nameForPicture.jpg").putFile(image);
    final TaskSnapshot taskSnapshot =await uploadTask;
    final String downloadUrl=await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }//for uploading image and fetching url
  Future<void> uploadImage1()async{
    await Future.delayed(const Duration(microseconds: 1));
    url1=await uploadImageAndGetUrl(_image1);
  }
  Future<void> uploadImage2()async{
    await Future.delayed(const Duration(microseconds: 2));
    url2=await uploadImageAndGetUrl(_image2);
  }
  Future<void> uploadImage3()async{
    await Future.delayed(const Duration(microseconds: 3));
    url3=await uploadImageAndGetUrl(_image3);
  }
  Future<void> uploadImage4()async{
    await Future.delayed(const Duration(microseconds: 4));
    url4=await uploadImageAndGetUrl(_image4);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25.h,),
            Text("Add product images",style: kPageHeading),
            SizedBox(height: 55.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UploadImageWidget(image: _image1,callback: ()async{
                  final File temp=await ImageUploader.addImage();
                  setState((){
                    _image1=temp;
                  });
                  // print(image.path);
                },),
                UploadImageWidget(image: _image2,callback: ()async{
                  final File temp=await ImageUploader.addImage();
                  setState((){
                    _image2=temp;
                  });
                  // print(image.path);
                },),
              ],
            ),
            SizedBox(height: 25.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UploadImageWidget(image: _image3,callback: ()async{
                  final File temp=await ImageUploader.addImage();
                  setState((){
                    _image3=temp;
                  });
                },),
                UploadImageWidget(image: _image4,callback: ()async{
                  final File temp=await ImageUploader.addImage();
                  setState((){
                    _image4=temp;
                  });
                  // print(image.path);
                },),
              ],
            ),
            SizedBox(height: 160.h,),
            PrimaryButton(label: "Submit",callback: (){
              if(_image1!=null&&_image2!=null&&_image3!=null&&_image4!=null){
                  LoadingWidget.showLoading(context);
                  Future.wait([   //calling all 4 function at the same time to avoid delay
                    uploadImage1(),
                    uploadImage2(),
                    uploadImage3(),
                    uploadImage4(),
                  ]).then((value) async {
                    await FirebaseFirestore.instance.collection("Items").doc().set({
                      "productName":widget.productName,
                      "productPrice":widget.productPrice,
                      "productDescription":widget.productDescription,
                      "seller":MasterModel.auth.currentUser.email,
                      "isAvailable":true,
                      "image1":url1,
                      "image2":url2,
                      "image3":url3,
                      "image4":url4,
                    }).then((value) {
                      LoadingWidget.removeLoading(context);
                      ErrorHandle.showError("Successfully added");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerRoot(),),);
                    }).onError((error, stackTrace) {
                      LoadingWidget.removeLoading(context);
                      ErrorHandle.showError("Something wrong");
                    });
                  });
              }
              else{
                ErrorHandle.showError("Please add images");
              }
            },),
          ],
        ),
      ),
    );
  }
}
