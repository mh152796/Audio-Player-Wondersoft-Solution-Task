import 'package:flutter/material.dart';

class ScreenSize extends StatelessWidget {
  const ScreenSize({Key? key}) : super(key: key);

  static screenSize(BuildContext context){
    return MediaQuery.of(context).size;
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
