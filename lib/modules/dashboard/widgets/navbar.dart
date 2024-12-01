import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_ecommerce/utils/extensions/extended_context.dart';

import '../../../constants/app_colors.dart';
import '../models/bottom_navbar_item_model.dart';

class Navbar extends StatelessWidget {
  final List<BottomNavbarItemModel> tabs;
  final Function(int) onChanged;
  const Navbar({super.key, required this.tabs, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 12)+const EdgeInsets.only(bottom: 12),
          decoration: const BoxDecoration(
            color: AppColors.dark,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                tabs.length,
                (index) => IconButton(
                    onPressed: () => onChanged(index),
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          tabs[index].icon,
                          colorFilter: ColorFilter.mode(
                              tabs[index].isSelected
                                  ? AppColors.light
                                  : AppColors.grey,
                              BlendMode.srcIn),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            getLocalizedLabel(context, index),
                            style: TextStyle(
                              fontSize: 10,
                              height: 1.0,
                              color: tabs[index].isSelected
                                  ? AppColors.light
                                  : AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  String getLocalizedLabel(BuildContext context, int index) {
    String label = context.localization.products;
    switch (index) {
      case 0:
        label = context.localization.products;
        break;
      case 1:
        label = context.localization.categories;
        break;
      case 2:
        label = context.localization.favourites;
        break;
      case 3:
        label = context.localization.products;
        break;
    }
    return label;
  }
}
