import 'package:flutter/material.dart';

class ProductDetailDescriptionWidget extends StatelessWidget {
  final String title;
  final String value;
  const ProductDetailDescriptionWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
