import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/models.dart';
import 'package:eshop/screens/screens.dart';
import 'package:eshop/utils/utils.dart';
import 'package:eshop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    updateNotification();
    super.initState();
  }
  Future<void> updateNotification()async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).update({
        "isNotificationSeen":true
      });
    }
    catch(e){
      ErrorHandle.showError("Error fetching notifications");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("users").doc(MasterModel.auth.currentUser.email).get(),
          builder: (context,AsyncSnapshot<DocumentSnapshot> snap){
            if(!snap.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snap.hasError){
              return const Center(
                child: Text("Unable to fetch data"),
              );
            }
            else{
              final Map<String, dynamic> temp =
              snap.data['notification'] as Map<String, dynamic>;
              final Map<String, dynamic> map = Map.fromEntries(
                temp.entries.toList()
                  ..sort(
                        (e1, e2) => e1.key.compareTo(e2.key),
                  ),
              );
              if(map.isEmpty){
                return const Center(
                  child: Text("No notifications"),
                );
              }
              else{
                return ListView.builder(
                  itemCount: map.length,
                  itemBuilder: (_,index){
                    return Card(
                      child: SizedBox(
                        width: 300.w,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("orders").doc(map.entries.toList()[index].value.toString()).snapshots(),
                          builder: (context,AsyncSnapshot snap){
                            if(!snap.hasData){
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            else if(snap.hasError){
                              return const Center(
                                child: Text("Unable to fetch data"),
                              );
                            }
                            else{
                              final DateTime orderTime=(snap.data['orderTime'] as Timestamp).toDate();
                              return Padding(
                                padding: EdgeInsets.all(5.w),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    pushNewScreen(context, screen: OrderDetails(orderID:map.entries.toList()[index].value.toString(),));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Order received: ${snap.data['productName']}"),
                                      Text(snap.data['address'] as String),
                                      Text("${orderTime.day}/${orderTime.month}/${orderTime.year}  ${orderTime.hour}:${orderTime.minute}"),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
