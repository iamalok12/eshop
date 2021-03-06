import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/choose_city/bloc/choose_city_bloc.dart';
import 'package:eshop/features/fetch_shops/bloc/get_shops_bloc.dart';
import 'package:eshop/features/fetch_shops/domain/fetch_shop_class.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class CustomerHome extends StatefulWidget {
  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  List<FetchShopsClass> shopList = [];
  List<String> cityList = [];
  String chooseCity = "Choose city";

  List<FetchShopsClass> searchListShops = [];
  final _search = TextEditingController();

  Future<void> onSearch(String text) async {
    searchListShops.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (final element in shopList) {
      if (element.shopName.toLowerCase().contains(text.toLowerCase())) {
        searchListShops.add(element);
      }
    }
    setState(() {});
  }

  Widget mainBody() {
    if (searchListShops.isNotEmpty && _search.text.isNotEmpty) {
      return ListView(
        children: searchListShops.map((e) {
          return ShopTiles(
            shopName: e.shopName,
            shopMail: e.shopMail,
            shopOwner: e.name,
            image1: e.image1,
            image2: e.image2,
            image3: e.image3,
            image4: e.image4,
            area: e.area,
            locality: e.locality,
            city: e.city,
            pinCode: e.pinCode,
            category: e.category,
            mobileNumber: e.mobile,
          );
        }).toList(),
      );
    } else if (searchListShops.isEmpty && _search.text.isNotEmpty) {
      return const Center(
        child: Text("No result found"),
      );
    } else {
      return ListView(
        children: shopList.map((e) {
          return ShopTiles(
            shopName: e.shopName,
            shopMail: e.shopMail,
            shopOwner: e.name,
            image1: e.image1,
            image2: e.image2,
            image3: e.image3,
            image4: e.image4,
            area: e.area,
            locality: e.locality,
            city: e.city,
            pinCode: e.pinCode,
            category: e.category,
            mobileNumber: e.mobile,
          );
        }).toList(),
      );
    }
  }
  Future<void>refreshPage()async {
    GetShopsBloc().add(GetShopsTriggerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetShopsBloc()..add(GetShopsTriggerEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlack,
          title: Row(
            children: [
              Container(
                width: 230.w,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: TextFormField(
                  onChanged: onSearch,
                  controller: _search,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    hintText: "Search shop",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).snapshots(),
                        builder: (context,AsyncSnapshot snap){
                          Icon showIcon(){
                            bool isNotificationViewed;
                            if(snap.hasData){
                              final bool isNotificationRead=snap.data['isNotificationSeen'] as bool;
                              isNotificationViewed=isNotificationRead;
                            }
                            if(isNotificationViewed==false){
                              return const Icon(Icons.notification_important,color: Colors.red,);
                            }
                            else{
                              return const Icon(Icons.notifications);
                            }
                          }
                          return IconButton(
                            onPressed: () {
                              pushNewScreen(context, screen: NotificationPage());
                            },
                            icon: showIcon(),
                          );
                        },
                      ),
                      BlocProvider(
                        create: (context) =>
                            ChooseCityBloc()..add(ChooseCityInitialEvent()),
                        child: BlocConsumer<ChooseCityBloc, ChooseCityState>(
                          listener: (context, state) {
                            if (state is ChooseCityLoaded) {
                              setState(() {
                                cityList = state.list;
                              });
                            } else if (state is ChooseCityError) {
                              ErrorHandle.showError("Unable to load cities");
                            }
                          },
                          builder: (context, state) {
                            if (state is ChooseCityLoading) {
                              return const CircularProgressIndicator();
                            } else {
                              return IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: SafeArea(
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10.w,
                                                  bottom: 10.w,
                                                  left: 20.w,
                                                  right: 20.w,),
                                              height: 200.w,
                                              width: 250.w,
                                              color: Colors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            7.w,
                                                          ),
                                                        ),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          iconSize: 30.w,
                                                          hint: Text(
                                                              "  $chooseCity",),
                                                          underline:
                                                              const Text(""),
                                                          items: cityList.map(
                                                            (String value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            },
                                                          ).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              chooseCity =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(_);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: kBlack,
                                                        ),
                                                        child: const Text(
                                                          "Cancel",
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          if (chooseCity !=
                                                              "Choose city") {
                                                            await MasterModel
                                                                .sharedPreferences
                                                                .setString(
                                                                    "city",
                                                                    chooseCity,)
                                                                .then((value) {
                                                              BlocProvider.of<
                                                                          GetShopsBloc>(
                                                                      context,)
                                                                  .add(
                                                                      GetShopsTriggerEvent(),);
                                                              Navigator.pop(_);
                                                            });
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: kPrimary,
                                                        ),
                                                        child: const Text(
                                                          "Submit",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.location_on),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: RefreshIndicator(
              onRefresh: refreshPage,
              child: BlocConsumer<GetShopsBloc, GetShopsState>(
                builder: (context, state) {
                  if (state is GetShopsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetShopsError) {
                    return const Text("Unable to fetch data");
                  } else if (state is GetShopsNotSelected) {
                    return GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: SafeArea(
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 10.w,
                                      bottom: 10.w,
                                      left: 20.w,
                                      right: 20.w,),
                                    height: 200.w,
                                    width: 250.w,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        StatefulBuilder(
                                          builder:
                                              (context, setState) {
                                            return Container(
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                  7.w,
                                                ),
                                              ),
                                              child: DropdownButton<
                                                  String>(
                                                isExpanded: true,
                                                iconSize: 30.w,
                                                hint: Text(
                                                  "  $chooseCity",),
                                                underline:
                                                const Text(""),
                                                items: cityList.map(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child:
                                                      Text(value),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    chooseCity =
                                                        value;
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(_);
                                              },
                                              style: ElevatedButton
                                                  .styleFrom(
                                                primary: kBlack,
                                              ),
                                              child: const Text(
                                                "Cancel",
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (chooseCity !=
                                                    "Choose city") {
                                                  await MasterModel
                                                      .sharedPreferences
                                                      .setString(
                                                    "city",
                                                    chooseCity,)
                                                      .then((value) {
                                                    BlocProvider.of<
                                                        GetShopsBloc>(
                                                      context,)
                                                        .add(
                                                      GetShopsTriggerEvent(),);
                                                    Navigator.pop(_);
                                                  });
                                                }
                                              },
                                              style: ElevatedButton
                                                  .styleFrom(
                                                primary: kPrimary,
                                              ),
                                              child: const Text(
                                                "Submit",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/images/choose_city.json",
                                width: 150.w, height: 150.w,),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Please choose your city",
                              style: TextStyle(fontSize: 20.sp),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state is GetShopsNoShop) {
                    return GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: SafeArea(
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 10.w,
                                      bottom: 10.w,
                                      left: 20.w,
                                      right: 20.w,),
                                    height: 200.w,
                                    width: 250.w,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        StatefulBuilder(
                                          builder:
                                              (context, setState) {
                                            return Container(
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                  7.w,
                                                ),
                                              ),
                                              child: DropdownButton<
                                                  String>(
                                                isExpanded: true,
                                                iconSize: 30.w,
                                                hint: Text(
                                                  "  $chooseCity",),
                                                underline:
                                                const Text(""),
                                                items: cityList.map(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child:
                                                      Text(value),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    chooseCity =
                                                        value;
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(_);
                                              },
                                              style: ElevatedButton
                                                  .styleFrom(
                                                primary: kBlack,
                                              ),
                                              child: const Text(
                                                "Cancel",
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (chooseCity !=
                                                    "Choose city") {
                                                  await MasterModel
                                                      .sharedPreferences
                                                      .setString(
                                                    "city",
                                                    chooseCity,)
                                                      .then((value) {
                                                    BlocProvider.of<
                                                        GetShopsBloc>(
                                                      context,)
                                                        .add(
                                                      GetShopsTriggerEvent(),);
                                                    Navigator.pop(_);
                                                  });
                                                }
                                              },
                                              style: ElevatedButton
                                                  .styleFrom(
                                                primary: kPrimary,
                                              ),
                                              child: const Text(
                                                "Submit",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,size: 60.h,),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Service Unavailable at your location",
                              style: TextStyle(fontSize: 20.sp),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state is GetShopsFound) {
                    return mainBody();
                  } else {
                    return const SizedBox();
                  }
                },
                listener: (context, state) {
                  if (state is GetShopsFound) {
                    setState(() {
                      shopList.clear();
                      shopList = state.list;
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopTiles extends StatelessWidget {
  final String shopName;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String shopOwner;
  final String mobileNumber;
  final String pinCode;
  final String area;
  final String locality;
  final String city;
  final String category;
  final String shopMail;

  const ShopTiles({Key key, this.shopName, this.image1, this.image2, this.image3, this.image4, this.shopOwner, this.mobileNumber, this.pinCode, this.area, this.locality, this.city, this.category, this.shopMail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreen(
          context,
          screen: ShopPanel(
            image1: image1,
            image2: image2,
            image3: image3,
            image4: image4,
            shopName: shopName,
            owner: shopOwner,
            ownerEmail: shopMail,
            mobileNumber: mobileNumber,
            pinCode: pinCode,
            area: area,
            locality: locality,
            city: city,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(10.w),
        elevation: 10.h,
        child: Column(
          children: [
            SizedBox(
              height: 160.h,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: image1,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(shopName,style: TextStyle(fontSize: 16.sp),),
                  Text(category,style: TextStyle(fontSize: 16.sp,color: Colors.green),),
                ],
              ),
            ),
            SizedBox(height: 5.h,)
          ],
        ),
      ),
    );
  }
}
