import 'package:eshop/blocs/choose_city/choose_city_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellerRegister2 extends StatefulWidget {
  @override
  State<SellerRegister2> createState() => _SellerRegister2State();
}

class _SellerRegister2State extends State<SellerRegister2> {
  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocProvider(
              create: (context) =>
                  ChooseCityBloc()..add(ChooseCityInitialEvent()),
              child: BlocConsumer<ChooseCityBloc, ChooseCityState>(
                listener: (context, state) {
                  if (state is ChooseCityLoaded) {
                    list.clear();
                    list = state.list;
                  } else if (state is ChooseCityError) {
                    Fluttertoast.showToast(
                        msg: "Something wrong",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white54,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  }
                },
                builder: (context, state) {
                  if (state is ChooseCityLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ChooseCityLoaded) {
                    return Text(state.list.first.toString() +
                        state.list.last.toString());
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Locality"),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Area/Street"),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Pin Code"),
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
