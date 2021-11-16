import 'package:eshop/features/edit_items_seller/bloc/edit_items_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/screens/seller/item_detail.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/alert/warning_widget.dart';
import 'package:flutter/material.dart';
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
                      child: Image.network(
                        image1,
                        fit: BoxFit.cover,
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
                        BlocProvider.of<EditItemsBloc>(context)
                            .add(EditItemsTrigger());
                      },
                      style: ElevatedButton.styleFrom(
                          primary: isAvailable == true ? kPrimary : Colors.red,),
                      child: Text(getAvailability()),
                    ),
                    ElevatedButton(
                      onPressed: (){},
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
