import 'package:eshop/features/fetch_items_shop/bloc/fetch_products_bloc.dart';
import 'package:eshop/features/fetch_items_shop/domain/seller_item_class.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/customer/product_details.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ShopPanel extends StatefulWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String shopName;
  final String owner;
  final String mobileNumber;
  final String area;
  final String locality;
  final String city;
  final String pinCode;
  final String ownerEmail;
  const ShopPanel({Key key, this.image1, this.image2, this.image3, this.image4, this.shopName, this.owner, this.mobileNumber, this.area, this.locality, this.city, this.pinCode, this.ownerEmail}) : super(key: key);
  @override
  _ShopPanelState createState() => _ShopPanelState();
}

class _ShopPanelState extends State<ShopPanel> {
  List<SellerItemsClass> list=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50.h,bottom: 5.h),
                height: 200.h,
                width: double.infinity,
                color: kBlack,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            widget.shopName,
                            style: TextStyle(fontSize: 18.sp, color: kWhite),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 320.w,child: const Divider(thickness: 3,color: Colors.white70),),
                          Text(
                            "${widget.area}, ${widget.locality}, ${widget.city}\n Pincode: ${widget.pinCode}\n Mobile: ${widget.mobileNumber}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 240.w,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: "Search products",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.sort,
                            color: kWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 80.w,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  height: 320.w,
                  width: 320.w,
                  child: ImageSlideshow(
                    children: [
                      widget.image1,
                      widget.image2,
                      widget.image3,
                      widget.image4,
                    ].map((e) => Image.network(e)).toList(),
                  ),
                ),
              ),
              // SizedBox(height: 10.h,),
              SizedBox(
                width: 320.w,
                child: BlocProvider(
                  create: (context) => FetchProductsBloc()..add(FetchProductTrigger(widget.ownerEmail)),
                  child: BlocConsumer<FetchProductsBloc,FetchProductsState>(
                    listener: (context,state){
                      if(state is FetchProductsLoaded){
                        setState(() {
                          list.clear();
                          list=state.list;
                        });
                      }
                    },
                    builder: (context,state){
                      if(state is FetchProductsLoading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if(state is FetchProductsEmpty){
                        return const Center(child: Text("Shop is yet to add products"),);
                      }
                      else if(state is FetchProductsLoaded){
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: list.map((e) => ItemTiles(
                            image1: e.image1,
                            image2: e.image2,
                            image3: e.image3,
                            image4: e.image4,
                            productName: e.productName,
                            productPrice: e.productPrice,
                            productDescription: e.productDescription,
                            seller: e.seller,
                            productID: e.productID,
                            isAvailable: e.isAvailable,
                          ),).toList(),
                        );
                      }
                      else if(state is FetchProductsError){
                        return const Center(child: Text("Unable to fetch Items"),);
                      }
                      else{
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemTiles extends StatelessWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String productName;
  final double productPrice;
  final String productDescription;
  final bool isAvailable;
  final String seller;
  final String productID;

  const ItemTiles({Key key,this.productID, this.image1, this.image2, this.image3, this.image4, this.productName, this.productPrice, this.productDescription, this.isAvailable, this.seller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreen(
          context,
          screen: ProductDetail(
            productID: productID,
            productName: productName,
            productPrice: productPrice,
            productDescription: productDescription,
            image1: image1,
            image2: image2,
            image3: image3,
            image4: image4,
            isAvailable: isAvailable,
            seller: seller,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Card(
          elevation: 30,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: 320.w,
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  image1,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "₹ $productPrice",
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.green,
                    size: 30.w,
                  ),
                  onPressed: () async{
                    try{
                      final data=await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get();
                      final List<dynamic> list=data.data()['cart'] as List<dynamic>;
                      list.add(productID);
                      await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
                        "cart":list
                      }).then((value){
                        ErrorHandle.showError("Added to cart");
                      });
                    }
                    catch(e){
                      ErrorHandle.showError("Something wrong");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
