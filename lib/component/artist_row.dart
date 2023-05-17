import 'package:flutter/material.dart';

class ArtistRow extends StatelessWidget {
  const ArtistRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Rabindranath Tagor",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.bookmark_border,
          size: 28,
          color: Colors.white,
        ),
      ],
    );
  }
}
