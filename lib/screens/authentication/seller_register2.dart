import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/features/choose_city/bloc/choose_city_bloc.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerRegister2 extends StatefulWidget {
  @override
  State<SellerRegister2> createState() => _SellerRegister2State();
}

class _SellerRegister2State extends State<SellerRegister2> {
  List<String> cityList = [];
  String chooseCity = "Choose city";
  final locality = TextEditingController();
  final area = TextEditingController();
  final pinCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    locality.dispose();
    area.dispose();
    pinCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Add details",
                    style: kPageHeading,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(2.w),
                    width: 260.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.w),
                        borderRadius: BorderRadius.circular(5.w),),
                    child: BlocProvider(
                      create: (context) =>
                          ChooseCityBloc()..add(ChooseCityInitialEvent()),
                      child: BlocConsumer<ChooseCityBloc, ChooseCityState>(
                        listener: (context, state) {
                          if (state is ChooseCityLoaded) {
                            setState(() {
                              cityList.clear();
                              cityList = state.list;
                            });
                          } else if (state is ChooseCityError) {
                            ErrorHandle.showError("Something wrong");
                          }
                        },
                        builder: (context, state) {
                          if (state is ChooseCityLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ChooseCityLoaded) {
                            return DropdownButton<String>(
                              isExpanded: true,
                              iconSize: 30.w,
                              hint: Text("  $chooseCity"),
                              underline: const Text(""),
                              items: cityList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  chooseCity = value;
                                });
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("Unable to fetch data"),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                      controller: locality,
                      label: "Locality",
                      keyboardType: TextInputType.name,
                      textFieldOptions: PrimaryTextFieldOptions.name,),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                      controller: area,
                      label: "Area",
                      keyboardType: TextInputType.streetAddress,
                      textFieldOptions: PrimaryTextFieldOptions.name,),
                  SizedBox(
                    height: 25.h,
                  ),
                  PrimaryTextField(
                      controller: pinCode,
                      label: "Pin code",
                      keyboardType: TextInputType.number,
                      textFieldOptions: PrimaryTextFieldOptions.pinCode,),
                  SizedBox(
                    height: 160.h,
                  ),
                  PrimaryButton(
                    label: "Next",
                    callback: () async {
                      if (_formKey.currentState.validate() && chooseCity != "Category") {
                        try {
                          LoadingWidget.showLoading(context);
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(MasterModel.auth.currentUser.email)
                              .update({
                            "city": chooseCity,
                            "locality": locality.text.trim(),
                            "area": area.text.trim(),
                            "pinCode": pinCode.text.trim()
                          }).then((value) {
                            LoadingWidget.removeLoading(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SellerRegister3(),
                              ),
                            );
                          });
                        } catch (e) {
                          ErrorHandle.showError("Something wrong");
                        }
                      } else {
                        ErrorHandle.showError("Please input all details");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
