import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/edit_items_seller/bloc/edit_items_bloc.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ItemTile extends StatelessWidget {
  final int tileNumber;
  final String itemID;
  final String productName;
  final double productPrice;
  final String productDescription;
  final bool isAvailable;
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  const ItemTile(
      {Key key,
      this.tileNumber,
      this.itemID,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.isAvailable,
      this.image1,
      this.image2,
      this.image3,
      this.image4,})
      : super(key: key);

  Color getColor() {
    if (tileNumber % 4 == 0) {
      return Colors.red.shade100;
    } else if (tileNumber % 4 == 1) {
      return Colors.blue.shade100;
    } else if (tileNumber % 4 == 2) {
      return Colors.green.shade100;
    } else {
      return Colors.yellow.shade100;
    }
  }

  String getAvailability() {
    if (isAvailable == true) {
      return "Mark out of stock";
    } else {
      return "Mark in stock";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreen(
          context,
          screen: ItemDetail(image1: image1,image2: image2,image3: image3,image4: image4,productName: productName,productPrice: productPrice,productDescription: productDescription,),
          withNavBar: false,
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 4.h, left: 10.w, right: 10.w),
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
                      child: CachedNetworkImage(
                        imageUrl: image1,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    SizedBox(
                      width: 180.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "₹ ${productPrice.toString()}",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 80.w,
                        width: 80.w,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: (){
                              showDialog(context: context,
                                  barrierDismissible: false,
                                  builder:(_){
                                return WarningWidget(msg: "Delete item?",callback: ()async{
                                  await FirebaseFirestore.instance.collection("Items").doc(itemID).delete().then((value){
                                    Navigator.pop(_);
                                    BlocProvider.of<EditItemsBloc>(context)
                                        .add(EditItemsTrigger());
                                  }).onError((error, stackTrace){
                                    Navigator.pop(_);
                                    ErrorHandle.showError("Something wrong");
                                  });
                                },
                                );
                              },);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: kBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: ()async{
                        try{
                          await FirebaseFirestore.instance.collection("Items").doc(itemID).update({
                            "isAvailable":!isAvailable
                          }).then((value){
                            BlocProvider.of<EditItemsBloc>(context)
                                .add(EditItemsTrigger());
                          });
                        }
                        catch(e){
                          ErrorHandle.showError("Couldn't update availability");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: isAvailable == true ? kPrimary : Colors.red,),
                      child: Text(getAvailability()),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (__) {
                            final _updatedPrice=TextEditingController();
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Center(
                                child: Container(
                                  color: kWhite,
                                  height: 230.h,
                                  width: 250.w,
                                  padding: EdgeInsets.all(15.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:100.w,
                                            child: Text(
                                              "Update price for $productName",
                                              style: TextStyle(fontSize: 15.sp,),
                                              maxLines: 2,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(__);
                                            },
                                            icon: const Icon(Icons.cancel),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 3.h,
                                      ),
                                      SizedBox(height: 5.h,),
                                      PrimaryTextField(
                                        controller: _updatedPrice,
                                        label: "New price",
                                        keyboardType: TextInputType.number,
                                        textFieldOptions: PrimaryTextFieldOptions.price,
                                      ),
                                      SizedBox(height: 20.h,),
                                      Center(
                                        child: PrimaryButton(
                                          label: "Submit",
                                          callback: ()async{
                                            try{
                                              await FirebaseFirestore.instance.collection("Items").doc(itemID).update({
                                                "productPrice":double.parse(_updatedPrice.text.trim())
                                              }).then((value){
                                                Navigator.pop(__);
                                                BlocProvider.of<EditItemsBloc>(context)
                                                    .add(EditItemsTrigger());
                                              });
                                            }
                                            catch(e){
                                              ErrorHandle.showError("Couldn't update price");
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: kPrimary),
                      child: const Text("Update price"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
