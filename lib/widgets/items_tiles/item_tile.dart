import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {

  final int tileNumber;
  final String productName;
  final double productPrice;
  final String productDescription;
  final bool isAvailable;
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  const ItemTile({Key key, this.tileNumber, this.productName, this.productPrice, this.productDescription, this.isAvailable, this.image1, this.image2, this.image3, this.image4}) : super(key: key);

  Color getColor(){
    if(tileNumber%4==0) {
      return Colors.red.shade100;
    }
    else if(tileNumber%4==1){
      return Colors.blue.shade100;
    }
    else if(tileNumber%4==2){
      return Colors.green.shade100;
    }
    else{
      return Colors.yellow.shade100;
    }
  }

  String getAvailability(){
    if(isAvailable==true){
      return "Mark out of stock";
    }
    else{
      return "Mark in stock";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h,left: 10.w,right:10.w),
      child: GestureDetector(
        child: Card(
          margin: EdgeInsets.only(bottom: 10.h),
          elevation: 10.w,
          color: getColor(),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 80.w,
                    width: 80.w,
                    child: Image.network(image1,fit: BoxFit.cover,),
                  ),
                  SizedBox(width: 30.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productName,style: TextStyle(fontSize: 16.sp),),
                      SizedBox(height: 5.h,),
                      Text("₹ ${productPrice.toString()}",style: TextStyle(fontSize: 16.sp),),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: isAvailable==true?kPrimary:Colors.red), child:Text(getAvailability()),),
                  ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: kPrimary), child:const Text("Update price"),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
