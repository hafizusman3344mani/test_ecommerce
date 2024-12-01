import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ecommerce/config/routes/nav_router.dart';
import 'package:test_ecommerce/modules/categories/models/categories_model.dart';
import 'package:test_ecommerce/modules/products/pages/product_detail_page.dart';
import '../../../core/di/service_locator.dart';
import '../../favourites/cubit/favourites_cubit.dart';
import '../../home/models/product_model.dart';
import '../../home/widgets/home_product_widget.dart';
import '../cubit/products_cubit.dart';

class ProductsPage extends StatelessWidget {
  final CategoryModel category;
  const ProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(productsRepository: sl())
        ..getProductsByCategory(category.slug),
      child: ProductsPageView(
        category: category,
      ),
    );
  }
}

class ProductsPageView extends StatefulWidget {
  final CategoryModel category;
  const ProductsPageView({super.key, required this.category});

  @override
  State<ProductsPageView> createState() => _ProductsPageViewState();
}

class _ProductsPageViewState extends State<ProductsPageView> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
  }

  _onSearchProduct(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      context
          .read<ProductsCubit>()
          .getProductsByCategory(widget.category.slug, query: query.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            surfaceTintColor: Colors.transparent,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      hintText: 'Search product',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black))),
                  onChanged: _onSearchProduct,
                ),
              ),
              if (state.status == ProductsStatus.success &&
                  state.productsResponse.products.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    " ${state.productsResponse.products.length} results found",
                    style: TextStyle(
                        fontSize: 10,
                        color: const Color(0xFF0C0C0C).withOpacity(.5)),
                  ),
                ),
              ],
              Expanded(
                child: state.status == ProductsStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.status == ProductsStatus.error
                        ? Center(
                            child: Text(state.errorMessage),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            itemCount: state.productsResponse.products.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemBuilder: (context, index) {
                              ProductModel productModel =
                                  state.productsResponse.products[index];
                              return HomeVideoWidget(
                                productModel: productModel,
                                onTap: () {
                                  NavRouter.push(
                                      context,
                                      ProductDetailPage(
                                        onFav: (){
                                          context
                                              .read<ProductsCubit>()
                                              .addFav(productModel.id, !productModel.isFav);
                                          context
                                              .read<FavouritesCubit>()
                                              .addFavourite(productModel);
                                        },
                                          productModel: productModel));
                                },
                              );
                            }),
              ),
            ],
          ),
        );
      },
    );
  }
}
