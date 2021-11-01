import 'package:eshop/features/edit_items_seller/bloc/edit_items_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/seller_items.dart';
import 'package:eshop/utils/colorpallets.dart';
import 'package:eshop/utils/utils.dart';
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

  List<SellerItems> list=[];
  List<SellerItems> searchList=[];
  final _search=TextEditingController();

  Future<void> onSearch(String text)async{
    searchList.clear();
    if(text.isEmpty){
      setState(() {
      });
      return;
    }
    for (final element in list) {
      if(element.productName.contains(text)) {
        searchList.add(element);
      }
    }
    setState(() {
    });
  }

  Widget mainBody(){
    if(searchList.isNotEmpty && _search.text.isNotEmpty){
      return ListView(
        children:searchList.map((e){
          final int index=list.indexOf(e);
          return ItemTile(tileNumber: index,image1: e.image1,isAvailable: e.isAvailable,productName: e.productName,productPrice: e.productPrice,);
        }).toList(),
      );
    }
    else if(searchList.isEmpty && _search.text.isNotEmpty){
      return const Center(
        child: Text("No result found"),
      );
    }
    else{
      return ListView(
        children:list.map((e){
          final int index=list.indexOf(e);
          return ItemTile(tileNumber: index,image1: e.image1,isAvailable: e.isAvailable,productName: e.productName,productPrice: e.productPrice,);
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
                    Icons.filter_list_alt,
                    color: kWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context)=>EditItemsBloc()..add(EditItemsTrigger()),
        child: BlocConsumer<EditItemsBloc,EditItemsState>(
          builder: (context,state){
            if(state is EditItemsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is EditItemsEmpty){
              return const Center(
                child: Text("No data"),
              );
            }
            else if(state is EditItemsLoaded){
              return SafeArea(
                child: mainBody(),
              );
            }
            else{
              return const SizedBox();
            }
          },
          listener: (context,state){
            if(state is EditItemsError){
              ErrorHandle.showError("Something wrong");
            }
            else if(state is EditItemsLoaded){
              setState(() {
                list.clear();
                list=state.list;
              });
            }
          },
        ),
      ),
    );
  }
}
