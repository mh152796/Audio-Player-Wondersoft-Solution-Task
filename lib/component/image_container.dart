import 'package:flutter/material.dart';

import '../screen_size.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = ScreenSize.screenSize(context);
    return Container(
      width: double.infinity,
      height: size.width - 32,
      decoration:
          const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset(
          'assets/images/rabindronath.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
