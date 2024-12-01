import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_ecommerce/modules/home/models/product_model.dart';
import 'package:test_ecommerce/modules/home/widgets/product_image_widget.dart';

class HomeVideoWidget extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback onTap;
  const HomeVideoWidget({
    super.key,
    required this.onTap,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              thumbnail: productModel.thumbnail,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  productModel.title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "\$${productModel.price}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  productModel.rating.toString(),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 4,
                ),
                RatingBarIndicator(
                  rating: productModel.rating,
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
            if (productModel.brand != null) ...[
              const SizedBox(
                height: 6,
              ),
              Text(
                "By ${productModel.brand}",
                style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF0C0C0C).withOpacity(.5)),
              ),
            ],
            if (productModel.category.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              Text(
                'In ${productModel.category}',
                style: const TextStyle(fontSize: 10, color: Color(0xff0C0C0C)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
