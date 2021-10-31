import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/edit_items_seller/data/edit_items_repo.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/utils/colorpallets.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:eshop/widgets/items_tiles/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditItems extends StatefulWidget {
  @override
  State<EditItems> createState() => _EditItemsState();
}
class _EditItemsState extends State<EditItems> {

  final EditItemsRepo _repo=EditItemsRepo();

  @override
  void initState() {
    _repo.fetchItems();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            Container(
              width: 240.w,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Search items",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              color: kWhite,
                              height: 350.h,
                              width: 250.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SecondaryButton(
                                    label: "Cancel",
                                    callback: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  PrimaryButton(
                                    label: "Apply",
                                    callback: () {},
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.filter_list_alt,
                    color: kWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            ItemTile(tileNumber: 0,image1: "https://m.media-amazon.com/images/I/81idDmld6hL._SL1500_.jpg",isAvailable: true,productName: "Denver deo",productPrice: 450,),
            ItemTile(tileNumber: 1,image1: "https://www.bigbasket.com/media/uploads/p/l/306926-2_4-amul-homogenised-toned-milk.jpg",isAvailable: false,productName: "Amul milk",productPrice: 50,),
            ItemTile(tileNumber: 2,image1: "https://thumbs.dreamstime.com/b/bread-cut-14027607.jpg",isAvailable: false,productName: "Nirma bread",productPrice: 30,),
            ItemTile(tileNumber: 3,image1: "https://www.simpleskincare.com/sk-eu/content/dam/brands/lifebuoy/specified_clusterscountries/2133643-lifebuoy-innovation-care-soap-wrapper-125g.png",isAvailable: true,productName: "Lifebuoy soap",productPrice: 20,),
            ItemTile(tileNumber: 4,image1: "https://www.bigbasket.com/media/uploads/p/l/251014-2_7-thums-up-soft-drink.jpg",isAvailable: true,productName: "Thumbs up",productPrice: 40,),
          ],
        ),
      ),
    );
  }
}
