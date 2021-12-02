import 'package:cloud_firestore/cloud_firestore.dart';
class ChoosePlan{
  Future<List<int>> fetchPlan() async{
    final data=await FirebaseFirestore.instance.collection("admin").doc("plans").get();
    final List<int> planList= List.from(data.data()['month'] as Iterable<dynamic>);
    return planList;
  }
}
