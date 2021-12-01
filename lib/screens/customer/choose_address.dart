import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ChooseAddress extends StatelessWidget {
  final List<CustomerOrderClass> orderList;
  final bool isNextButtonVisible;
  final bool isCartToBeEmpty;

  final _name = TextEditingController();
  final _area = TextEditingController();
  final _locality = TextEditingController();
  final _city = TextEditingController();
  final _pinCode = TextEditingController();
  final _mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ChooseAddress({
    Key key,
    this.isNextButtonVisible = true,
    this.orderList,
    this.isCartToBeEmpty,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlack,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return Container(
                height: 800.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.w),
                    topLeft: Radius.circular(10.w),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimaryTextField(
                          controller: _name,
                          label: "Full name",
                          keyboardType: TextInputType.name,
                          textFieldOptions: PrimaryTextFieldOptions.name,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimaryTextField(
                          controller: _mobile,
                          label: "Mobile number",
                          keyboardType: TextInputType.number,
                          textFieldOptions: PrimaryTextFieldOptions.mobile,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimaryTextField(
                          controller: _area,
                          label: "Area",
                          keyboardType: TextInputType.streetAddress,
                          textFieldOptions: PrimaryTextFieldOptions.address,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimaryTextField(
                          controller: _locality,
                          label: "Locality",
                          keyboardType: TextInputType.streetAddress,
                          textFieldOptions: PrimaryTextFieldOptions.address,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimaryTextField(
                          controller: _city,
                          label: "City",
                          keyboardType: TextInputType.streetAddress,
                          textFieldOptions: PrimaryTextFieldOptions.address,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimaryTextField(
                          controller: _pinCode,
                          label: "Pincode",
                          keyboardType: TextInputType.number,
                          textFieldOptions: PrimaryTextFieldOptions.pinCode,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(_);
                              },
                              style: ElevatedButton.styleFrom(primary: kBlack),
                              child: const Text("Cancel"),
                            ),
                            SizedBox(
                              width: 80.w,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    final data = await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .doc(MasterModel.auth.currentUser.email)
                                        .get();
                                    final List<dynamic> addressList =
                                        data.data()['address'] as List<dynamic>;
                                    final String payLoad =
                                        "Name: ${_name.text.trim()}\nMobile: ${_mobile.text.trim()}\nAddress: ${_area.text.trim()}, ${_locality.text.trim()}, ${_city.text.trim()} \nPincode: ${_pinCode.text.trim()}";
                                    addressList.add(payLoad);
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(MasterModel.auth.currentUser.email)
                                        .update({'address': addressList}).then(
                                            (value) {
                                      _name.clear();
                                      _mobile.clear();
                                      _area.clear();
                                      _locality.clear();
                                      _city.clear();
                                      _pinCode.clear();
                                      Navigator.pop(_);
                                    });
                                  } catch (e) {
                                    ErrorHandle.showError("Something wrong");
                                  }
                                }
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: kPrimary),
                              child: const Text("Submit"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: kBlack,
        title: const Text("Shipping address"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 330.w,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(MasterModel.auth.currentUser.email)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final List<dynamic> list =
                      snapshot.data['address'] as List<dynamic>;
                  if (list.isEmpty) {
                    return const Center(
                      child: Text("No address found. Please add address"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        return AddressTile(
                          key: ObjectKey(index),
                          index: index,
                          address: list[index].toString(),
                          orderList: orderList,
                          isNextButtonVisible: isNextButtonVisible,
                          isCartHaveToBeEmpty: isCartToBeEmpty,
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final bool isCartHaveToBeEmpty;
  final int index;
  final String address;
  final bool isNextButtonVisible;
  final List<CustomerOrderClass> orderList;
  const AddressTile({
    Key key,
    this.address,
    this.index,
    this.isCartHaveToBeEmpty,
    this.isNextButtonVisible,
    this.orderList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.h),
      elevation: 40,
      child: Container(
        padding: EdgeInsets.all(8.w),
        height: 80.h,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  address,
                  textAlign: TextAlign.start,
                ),
              ),
              if (isNextButtonVisible == true)
                IconButton(
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: OrderPlace(
                        address: address,
                        orderList: orderList,
                        isCartHaveToEmpty:isCartHaveToBeEmpty,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.forward,
                    size: 35.w,
                    color: Colors.green,
                  ),
                )
              else
                IconButton(
                  onPressed: () async {
                    try {
                      final data = await FirebaseFirestore.instance
                          .collection("users")
                          .doc(MasterModel.auth.currentUser.email)
                          .get();
                      final List<dynamic> addresses =
                          data.data()['address'] as List<dynamic>;
                      addresses.removeAt(index);
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(MasterModel.auth.currentUser.email)
                          .update({"address": addresses});
                    } catch (e) {
                      ErrorHandle.showError("Something wrong");
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
