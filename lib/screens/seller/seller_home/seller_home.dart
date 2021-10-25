import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Row(
          children: [
            SizedBox(width: 2.w,),
            Container(
              height: 25.h,
              width: 240.w,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child:TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.black54,),
                ),
              ),
            ),
            IconButton(onPressed: (){}, icon:const Icon(Icons.notifications,color: kWhite,),),
            IconButton(onPressed: (){
              showDialog(context: context,barrierDismissible: false, builder: (context){
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Container(
                      color: kWhite,
                      height: 350.h,
                      width: 250.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SecondaryButton(label: "Cancel",callback: (){
                            Navigator.pop(context);
                          },),
                          PrimaryButton(label: "Apply",callback: (){},)
                        ],
                      ),
                    ),
                  ),
                );
              },);
            }, icon:const Icon(Icons.filter_list_alt,color: kWhite,),),
          ],
        ),
      ),
      body: const SafeArea(
        child: Text("Seller home"),
      ),
    );
  }
}
