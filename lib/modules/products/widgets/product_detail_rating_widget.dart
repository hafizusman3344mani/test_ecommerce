import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailRatingWidget extends StatelessWidget {
  final String title;
  final String value;
  const ProductDetailRatingWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            "$title:  ",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(
                width: 4,
              ),
              RatingBarIndicator(
                rating: double.parse(value),
                itemCount: 5,
                itemSize: 14.0,
                unratedColor: Colors.amber.withAlpha(50),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
