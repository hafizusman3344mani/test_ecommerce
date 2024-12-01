import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redacted/redacted.dart';
import 'package:test_ecommerce/config/routes/nav_router.dart';
import 'package:test_ecommerce/modules/categories/models/categories_model.dart';
import 'package:test_ecommerce/modules/products/pages/products_page.dart';

import '../../../core/di/service_locator.dart';
import '../cubit/categories_cubit.dart';
import '../widgets/category_widget.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoriesCubit(categoriesRepository: sl())..getCategories(),
      child: const CategoriesPageView(),
    );
  }
}

class CategoriesPageView extends StatefulWidget {
  const CategoriesPageView({super.key});

  @override
  State<CategoriesPageView> createState() => _CategoriesPageViewState();
}

class _CategoriesPageViewState extends State<CategoriesPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
          ),
          body: state.status == CategoriesStatus.loading
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 4 / 3.4,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    CategoryModel categoryModel = CategoryModel.empty();
                    return CategoryWidget(
                      onTap: () {},
                      categoryModel: categoryModel,
                    ).redacted(
                      context: context,
                      redact: true,
                      configuration: RedactedConfiguration(
                        autoFillTexts: true,
                        autoFillText: 'Auto fill text',
                        animationDuration: const Duration(milliseconds: 800),
                        redactedColor: Colors.grey,
                      ),
                    );
                  },
                )
              : state.status == CategoriesStatus.error
                  ? Center(
                      child: Text(state.errorMessage),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 4 / 3.4,
                      ),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        CategoryModel categoryModel = state.categories[index];
                        return CategoryWidget(
                          onTap: () {
                            NavRouter.push(
                                context, ProductsPage(category: categoryModel));
                          },
                          categoryModel: categoryModel,
                        );
                      },
                    ),
        );
      },
    );
  }
}
