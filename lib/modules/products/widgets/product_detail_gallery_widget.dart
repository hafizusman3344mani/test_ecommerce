import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../home/widgets/product_image_widget.dart';

class ProductDetailGalleryWidget extends StatelessWidget {
  final List<String> images;
  const ProductDetailGalleryWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: List.generate(
        images.length + 1,
            (index) => index == 0
            ? const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Product Gallery :',
            style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        )
            : ProductImageWidget(
          width: 154,
          thumbnail: images[index - 1],
        ),
      ),
    );
  }
}
