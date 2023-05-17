import 'package:flutter/material.dart';

import '../screen_size.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = ScreenSize.screenSize(context);
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
          ),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,size: 18,
                color: Colors.grey,
              )),
        ),
        SizedBox(
          width: size.width / 5,
        ),
        const Text(
          'Playing Music',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Colors.white),
        )
      ],
    );
  }
}
