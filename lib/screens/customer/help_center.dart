import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Contact us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 20,),
                        Text("ialok@outlook.com",style: TextStyle(color: Colors.grey, fontSize: 18),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 20,),
                        Text("aaronchellaya25@gmail.com",style: TextStyle(color: Colors.grey, fontSize: 18),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 20,),
                        Text("Acharya Doctor Sarvepalli \n Radhakrishnan Rd,\n Soladevanahalli, Karnataka 560107",style: TextStyle(color: Colors.grey, fontSize: 18),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
