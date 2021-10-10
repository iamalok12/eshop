import 'package:eshop/blocs/shop_category/shop_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerRegister1 extends StatefulWidget {
  @override
  State<SellerRegister1> createState() => _SellerRegister1State();
}

class _SellerRegister1State extends State<SellerRegister1> {
  List<String> shopCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(),
            TextFormField(),
            BlocProvider(
              create: (context) =>
                  ShopCategoryBloc()..add(ShopCategoryInitial()),
              child: BlocConsumer<ShopCategoryBloc, ShopCategoryState>(
                listener: (context, state) {
                  if (state is ShopCategoryLoaded) {
                    shopCategories.clear();
                    shopCategories = state.list;
                  }
                  else if(state is ShopCategoryError){
                    Fluttertoast.showToast(
                        msg: "Something wrong",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white54,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ShopCategoryLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ShopCategoryLoaded) {
                    return Text(state.list.first.toString() +
                        state.list.last.toString());
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
