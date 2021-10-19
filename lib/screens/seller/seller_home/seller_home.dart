import 'package:eshop/features/payment_status/bloc/payment_status_bloc.dart';
import 'package:eshop/features/payment_status/data/payment_status.dart';
import 'package:eshop/screens/payment/payment_options.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class SellerHome extends StatefulWidget {
  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getOfferStatus(context));
    super.initState();
  }

  String imageAddress;

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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PaymentStatusError) {
                return const Text("Unable to fetch data");
              } else if (state is PaymentStatusWithOffer) {
                return GestureDetector(
                  child: Image.network(imageAddress,height: 40,width: 40,),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentOptions(),
                      ),
                    );
                  },
                );
              } else {
                return GestureDetector(
                  child: const Text("Pay kro"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentOptions(),
                      ),
                    );
                  },
                );
              }
            },
            listener: (context, state) {
              if (state is PaymentStatusAlreadyValid) {
                Navigator.pop(context);
              } else if (state is PaymentStatusWithOffer) {
                setState(() {
                  imageAddress = state.offerAddress;
                });
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("Seller Home"),),
    );
  }
}
