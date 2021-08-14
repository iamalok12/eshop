import 'package:flutter/material.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}
class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Customer"),
      ),
    );
  }
}
