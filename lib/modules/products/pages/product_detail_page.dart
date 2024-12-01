import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ecommerce/constants/app_colors.dart';
import 'package:test_ecommerce/modules/favourites/cubit/favourites_cubit.dart';
import 'package:test_ecommerce/modules/home/models/product_model.dart';
import 'package:test_ecommerce/modules/products/cubit/products_cubit.dart';

import '../../home/widgets/product_image_widget.dart';
import '../widgets/product_detail_description_model.dart';
import '../widgets/product_detail_gallery_widget.dart';
import '../widgets/product_detail_property_widget.dart';
import '../widgets/product_detail_rating_widget.dart';

class ProductDetailPage extends StatefulWidget {
  ProductModel productModel;
  final VoidCallback onFav;
  ProductDetailPage({
    super.key,
    required this.productModel,
    required this.onFav,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ProductDetailPage oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(
              height: 210,
              thumbnail: widget.productModel.thumbnail,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Product Details:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.productModel.isFav ==
                              !widget.productModel.isFav;
                          widget.onFav();
                          setState(() {});
                        },
                        icon: Icon(
                          widget.productModel.isFav
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: widget.productModel.isFav
                              ? AppColors.red
                              : AppColors.lightGrey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ProductDetailPropertyWidget(
                    title: 'Name',
                    value: widget.productModel.title,
                  ),
                  ProductDetailPropertyWidget(
                    title: 'Price',
                    value: widget.productModel.price.toString(),
                  ),
                  ProductDetailPropertyWidget(
                    title: 'Category',
                    value: widget.productModel.category,
                  ),
                  ProductDetailPropertyWidget(
                    title: 'Brand',
                    value: widget.productModel.brand,
                  ),
                  ProductDetailRatingWidget(
                    title: 'Rating',
                    value: widget.productModel.rating.toString(),
                  ),
                  ProductDetailPropertyWidget(
                    title: 'Stock',
                    value: widget.productModel.stock.toString(),
                  ),
                  ProductDetailDescriptionWidget(
                    title: 'Description',
                    value: widget.productModel.description,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ProductDetailGalleryWidget(
                    images: widget.productModel.images,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
