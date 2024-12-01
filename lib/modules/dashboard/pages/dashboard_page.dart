import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../categories/pages/categories_page.dart';
import '../../favourites/pages/favourites_page.dart';
import '../../home/pages/home_page.dart';
import '../../splash/profile_page.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    context.read<DashboardCubit>().changeNavSelection(0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Scaffold(
            extendBody: true,
            bottomNavigationBar: Navbar(
              tabs: state.tabs,
              onChanged: (index) {
                int selectedIndex = state.tabs.indexOf(state.tabs
                    .firstWhere((element) => element.isSelected == true));

                if (index == selectedIndex + 1 || index == selectedIndex - 1) {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                } else {
                  _pageController.jumpToPage(index);
                }
                context.read<DashboardCubit>().changeNavSelection(index);
              },
            ),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal, // or Axis.vertical
              children: const [
                HomePage(),
                CategoriesPage(),
                FavouritesPage(
                ),
                ProfilePage(
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
