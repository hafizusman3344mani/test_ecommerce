import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:test_ecommerce/modules/home/widgets/home_product_widget.dart';
import 'package:test_ecommerce/utils/extensions/extended_context.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../favourites/cubit/favourites_cubit.dart';
import '../../products/pages/product_detail_page.dart';
import '../models/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeRepository: sl())..getProducts(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (_debounce?.isActive ?? false) _debounce?.cancel();
  }

  _onSearchProduct(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      context.read<HomeCubit>().getProducts(query: query.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.localization.products),
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
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      hintText: 'Search product',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black))),
                  onChanged: _onSearchProduct,
                ),
              ),
              if (state.status == HomeStatus.success &&
                  state.response.products.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    " ${state.response.products.length} results found",
                    style: TextStyle(
                        fontSize: 10,
                        color: const Color(0xFF0C0C0C).withOpacity(.5)),
                  ),
                ),
              ],
              Expanded(
                child: state.status == HomeStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.status == HomeStatus.error
                        ? Center(
                            child: Text(state.errorMessage),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            itemCount: state.response.products.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemBuilder: (context, index) {
                              ProductModel productModel =
                                  state.response.products[index];
                              return HomeVideoWidget(
                                productModel: productModel,
                                onTap: () {
                                  NavRouter.push(
                                      context,
                                      ProductDetailPage(
                                        onFav: (){
                                          context
                                              .read<HomeCubit>()
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
