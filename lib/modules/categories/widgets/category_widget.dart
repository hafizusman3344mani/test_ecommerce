import 'package:flutter/material.dart';
import 'package:test_ecommerce/modules/categories/models/categories_model.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback onTap;
  const CategoryWidget({
    super.key,
    required this.categoryModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // image: DecorationImage(
              //   image: CachedNetworkImageProvider(categoryModel.url),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(.3)),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    categoryModel.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
