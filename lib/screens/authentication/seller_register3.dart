import 'package:flutter/material.dart';

class SellerRegister3 extends StatefulWidget {
  @override
  _SellerRegister3State createState() => _SellerRegister3State();
}

class _SellerRegister3State extends State<SellerRegister3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: (){},
                  iconSize: 60,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: (){},
                  iconSize: 60,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: (){},
                  iconSize: 60,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: (){},
                  iconSize: 60,
                ),
              ],
            ),
            ElevatedButton(onPressed: (){}, child: const Text("Submit"),),
          ],
        ),
      ),
    );
  }
}
