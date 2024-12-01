import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  final String thumbnail;
  final double height;
  final double? width;
  const ProductImageWidget({
    super.key,
    required this.thumbnail,
    this.height = 174,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: CachedNetworkImageProvider(thumbnail),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
