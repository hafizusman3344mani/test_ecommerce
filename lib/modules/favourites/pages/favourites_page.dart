import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_ecommerce/config/routes/nav_router.dart';
import 'package:test_ecommerce/constants/app_colors.dart';
import 'package:test_ecommerce/modules/products/pages/product_detail_page.dart';
import 'package:test_ecommerce/utils/extensions/extended_context.dart';
import '../../home/models/product_model.dart';
import '../cubit/favourites_cubit.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    context.read<FavouritesCubit>().getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.localization.favourites),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
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
                  onChanged: (v) {},
                ),
              ),
              if (state.status == FavouritesStatus.success &&
                  state.favProducts.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    " ${state.favProducts.length} results found",
                    style: TextStyle(
                        fontSize: 10,
                        color: const Color(0xFF0C0C0C).withOpacity(.5)),
                  ),
                ),
              ],
              Expanded(
                child: state.status == FavouritesStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.status == FavouritesStatus.error
                        ? Center(
                            child: Text(state.errorMessage),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            itemCount: state.favProducts.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemBuilder: (context, index) {
                              ProductModel productModel =
                                  state.favProducts[index];
                              return FavouriteProductWidget(
                                onTap: () {
                                  NavRouter.push(
                                      context,
                                      ProductDetailPage(
                                          productModel: productModel,
                                          onFav: () {
                                            context
                                                .read<FavouritesCubit>()
                                                .addFavourite(productModel);
                                          }));
                                },
                                onUnFav: () {
                                  context
                                      .read<FavouritesCubit>()
                                      .removeFavourite(productModel.id);
                                },
                                productModel: productModel,
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

class FavouriteProductWidget extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback onTap;
  final VoidCallback onUnFav;
  const FavouriteProductWidget(
      {super.key,
      required this.productModel,
      required this.onTap,
      required this.onUnFav});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    CachedNetworkImageProvider(productModel.thumbnail),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$${productModel.price}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        "${productModel.rating}",
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
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
                ],
              )),
              const SizedBox(
                width: 12,
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onUnFav,
                  icon: const Icon(
                    Icons.favorite,
                    color: AppColors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
