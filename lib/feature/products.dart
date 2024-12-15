import 'package:flutter/material.dart';

class Products extends StatelessWidget {
 final VoidCallback popRoute;
  const Products({super.key, required this.popRoute});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GestureDetector(
          onTap: (){
            popRoute();
          },
          child: const Center(child: Text("Products"))),
    );
  }
}
