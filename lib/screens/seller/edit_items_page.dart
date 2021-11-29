import 'package:eshop/features/edit_items_seller/bloc/edit_items_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/seller_items.dart';
import 'package:eshop/utils/colorpallets.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/items_tiles/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditItems extends StatefulWidget {
  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  List<SellerItems> list = [];
  List<SellerItems> searchList = [];
  final _search = TextEditingController();

  Future<void> onSearch(String text) async {
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (final element in list) {
      if (element.productName.toLowerCase().contains(text.toLowerCase())) {
        searchList.add(element);
      }
    }
    setState(() {});
  }

  Widget mainBody() {
    if (searchList.isNotEmpty && _search.text.isNotEmpty) {
      return ListView(
        children: searchList.map((e) {
          final int index = list.indexOf(e);
          return ItemTile(
            tileNumber: index,
            image1: e.image1,
            isAvailable: e.isAvailable,
            productName: e.productName,
            productPrice: e.productPrice,
            productDescription: e.productDescription,
            itemID: e.id,
            image2: e.image2,
            image3: e.image3,
            image4: e.image4,
          );
        }).toList(),
      );
    } else if (searchList.isEmpty && _search.text.isNotEmpty) {
      return const Center(
        child: Text("No result found"),
      );
    } else {
      return ListView(
        children: list.map((e) {
          final int index = list.indexOf(e);
          return ItemTile(
            tileNumber: index,
            image1: e.image1,
            isAvailable: e.isAvailable,
            productName: e.productName,
            productDescription: e.productDescription,
            productPrice: e.productPrice,
            itemID: e.id,
            image2: e.image2,
            image3: e.image3,
            image4: e.image4,
          );
        }).toList(),
      );
    }
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
                controller: _search,
                onChanged: onSearch,
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
                      builder: (context) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Container(
                              color: kWhite,
                              height: 250.h,
                              width: 250.w,
                              padding: EdgeInsets.all(15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sort by",
                                        style: TextStyle(fontSize: 25.sp),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.cancel),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 3.h,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            list.sort((a, b) {
                                              return a.productName.toLowerCase().compareTo(b.productName.toLowerCase());
                                            });
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: kPrimary,),
                                        child: const Text("A"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            list.sort((b, a) {
                                              return a.productName.toLowerCase().compareTo(b.productName.toLowerCase());
                                            });
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: kBlack,),
                                        child: const Text("Z"),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 3.h,
                                    color: kPrimary,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Price",
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            list.sort((a, b) {
                                              return a.productPrice.compareTo(b.productPrice);
                                            });
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: kPrimary,),
                                        child: const Text("Low"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            list.sort((b, a) {
                                              return a.productPrice.compareTo(b.productPrice);
                                            });
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: kBlack,),
                                        child: const Text("High"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.sort,
                    color: kWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => EditItemsBloc()..add(EditItemsTrigger()),
        child: BlocConsumer<EditItemsBloc, EditItemsState>(
          builder: (context, state) {
            if (state is EditItemsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EditItemsEmpty) {
              return const Center(
                child: Text("No data"),
              );
            } else if (state is EditItemsLoaded) {
              return SafeArea(
                child: mainBody(),
              );
            } else {
              return const SizedBox();
            }
          },
          listener: (context, state) {
            if (state is EditItemsError) {
              ErrorHandle.showError("Something wrong");
            } else if (state is EditItemsLoaded) {
              setState(() {
                list.clear();
                list = state.list;
              });
            }
          },
        ),
      ),
    );
  }
}
