import 'package:eshop/features/payment_status/bloc/payment_status_bloc.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/payment/payment_options.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/alert/progress_indicator.dart';
import 'package:eshop/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SellerHome extends StatefulWidget {
  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getOfferStatus(context));
    super.initState();
  }

  Future<void> getOfferStatus(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider(
          create: (context) => PaymentStatusBloc()..add(PaymentStatusTrigger()),
          child: BlocConsumer<PaymentStatusBloc, PaymentStatusState>(
            builder: (context, state) {
              if (state is PaymentStatusLoading) {
                return Center(
                  child: LoadingIndicator(),
                );
              } else if (state is PaymentStatusError) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(
                      child: Text(
                        "Unable to fetch data",
                        style: TextStyle(fontSize: 20.sp, color: kWhite),
                      ),
                    ),
                  ),
                );
              } else if (state is PaymentStatusWithOffer) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(
                      child: Container(
                        color: kWhite,
                        height: 300.h,
                        width: 250.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 200.w,
                              width: 200.w,
                              child: Image.network(
                                state.imageAddress,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 240.w,
                              padding: EdgeInsets.only(
                                left: 5.w,
                                right: 2.w,
                                top: 2.w,
                                bottom: 2.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state.coupon),
                                  IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: state.coupon),
                                      ).then((value) {
                                        ErrorHandle.showError("Copied");
                                      });
                                    },
                                    icon: const Icon(Icons.copy_outlined),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: SecondaryButton(
                                    label: "Logout",
                                    callback: () async {
                                      try {
                                        await MasterModel.signOut()
                                            .then((value) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        });
                                      } catch (e) {
                                        ErrorHandle.showError(
                                          "Something wrong",
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: PrimaryButton(
                                    label: "Pay",
                                    callback: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentOptions(),
                                        ),
                                      );
                                    },
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
              } else {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(
                      child: Container(
                        color: kWhite,
                        height: 300.h,
                        width: 250.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 2.w,
                                right: 2.w,
                              ),
                              child: Text(
                                "Your plan has expired kindly, renew your plan.",
                                style: TextStyle(fontSize: 15.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 200.w,
                              width: 200.w,
                              child: Lottie.asset("assets/images/payment.json"),
                            ), //todo loading builder
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: SecondaryButton(
                                    label: "Logout",
                                    callback: () async {
                                      try {
                                        await MasterModel.signOut()
                                            .then((value) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ),
                                          );
                                        });
                                      } catch (e) {
                                        ErrorHandle.showError(
                                          "Something wrong",
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: PrimaryButton(
                                    label: "Pay",
                                    callback: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentOptions(),
                                        ),
                                      );
                                    },
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
              }
            },
            listener: (context, state) {
              if (state is PaymentStatusAlreadyValid) {
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SecondaryButton(label: 'Logout',callback: ()async{
                try{
                  await MasterModel.signOut().then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
                  });
                }
                catch(e){
                  ErrorHandle.showError("Something wrong");
                }
              },),
              const Text("Seller Home"),
            ],
          ),
        ),
      ),
    );
  }
}
