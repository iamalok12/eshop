import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseCity{
  Future<List<String>> getCityList()async{
    final data = await FirebaseFirestore.instance.collection("admin").doc("categories").get();
    final List<String> cityList= List.from(data.data()['shopCities'] as Iterable<dynamic>);
    return cityList;
  }
}
