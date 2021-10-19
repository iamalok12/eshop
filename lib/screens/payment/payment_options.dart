import 'package:eshop/features/choose_plan/bloc/choose_plan_bloc.dart';
import 'package:eshop/key/razor_pay_key.dart';
import 'package:eshop/models/error_handler.dart';
import 'package:eshop/models/master_model.dart';
import 'package:eshop/screens/seller/seller_home/seller_home.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/buttons/payment_button.dart';
import 'package:eshop/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentOptions extends StatefulWidget {
  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  List<int> priceList=[];
  Razorpay _razorpay;
  int month;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future<void> doCheckout({int amount,String mobile, String email,int months}) async {
    print("Mobile $mobile");
    month=months;
    final options = {
      'key': razorPayKey,
      'amount': amount*100,
      'name': 'E-Shop',
      'description': 'Membership',
      'prefill': {'contact': mobile, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response)async {
    final DateTime validity = Jiffy().add(months: month).dateTime;
    await FirebaseFirestore.instance.collection('users').doc("alok.kvbrp@gmail.com").set({
      "validity":validity
    }).then((value){
      Fluttertoast.showToast(
        msg: "Payment successful, id: ${response.paymentId}", toastLength: Toast.LENGTH_SHORT,);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SellerHome(),),);
    });
    
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.message}",
        toastLength: Toast.LENGTH_SHORT,);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}", toastLength: Toast.LENGTH_SHORT,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 60.h,),
                Text("Choose plan",style: TextStyle(fontSize: 30.sp,fontFamily: "Orbitron",),),
                SizedBox(height: 25.h,),
                BlocProvider(
                  create: (context) =>
                  ChoosePlanBloc()..add(ChoosePlanInitialEvent()),
                  child: BlocConsumer<ChoosePlanBloc, ChoosePlanState>(
                    listener: (context, state) {
                      if (state is ChoosePlanLoaded) {
                        setState(() {
                          priceList.clear();
                          priceList = state.list;
                        });
                      }
                      else if(state is ChoosePlanError){
                        ErrorHandle.showError("Something wrong");
                      }
                    },
                    builder: (context, state) {
                      if (state is ChoosePlanLoading) {
                        return const Center(child: CircularProgressIndicator(),);
                      } else if (state is ChoosePlanLoaded) {
                        return Column(
                          children: [
                            PaymentBox(month: "1 month",amount: priceList[0],callback: (){
                              doCheckout(amount: priceList[0],mobile: state.mobile,email: MasterModel.auth.currentUser.email,months: 1);
                            },),
                            SizedBox(height: 25.h,),
                            PaymentBox(month: "6 months",amount: priceList[1],callback: (){
                              doCheckout(amount: priceList[1],mobile: state.mobile,email: "alok.kvbrp@gmail.com",months: 6);//todo
                            },),
                            SizedBox(height: 25.h,),
                            PaymentBox(month: "12 months",amount: priceList[2],callback: (){
                              doCheckout(amount: priceList[2],mobile: state.mobile,email: MasterModel.auth.currentUser.email,months: 12);
                            },),
                          ],
                        );
                      } else {
                        return const Center(child: Text("Unable to fetch data"),);
                      }
                    },
                  ),
                ),
                SizedBox(height: 25.h,),
                SizedBox(
                  width: 280.w,
                  child: Stack(
                    children: [
                      const Center(
                        child: Divider(
                          color: Colors.black26,
                          thickness: 3,
                        ),
                      ),
                      Center(child: Container(height: 15.w,width: 30.w,color: Colors.white,child: const Center(child: Text("OR",style: TextStyle(fontSize: 15),),),),)
                    ],
                  ),
                ),
                SizedBox(height: 25.h,),
                Container(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  height: 40.h,
                  width: 280.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Have coupon?",
                    ),
                  ),
                ),
                SizedBox(height: 50.h,),
                PrimaryButton(label: "Submit",callback: (){},)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
