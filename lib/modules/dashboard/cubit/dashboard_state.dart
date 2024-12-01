part of 'dashboard_cubit.dart';

class DashboardState {
  final List<BottomNavbarItemModel> tabs;

  const DashboardState({required this.tabs});
  factory DashboardState.initial() {
    return DashboardState(tabs: [
      BottomNavbarItemModel(
          label: 'Products', icon: AssetPaths.icProducts, isSelected: false),
      BottomNavbarItemModel(
          label: 'Categories', icon: AssetPaths.icCategory, isSelected: false),
      BottomNavbarItemModel(
          label: 'Favourites', icon: AssetPaths.icFav, isSelected: true),
      BottomNavbarItemModel(
          label: 'Profile', icon: AssetPaths.icPerson, isSelected: false),
    ]);
  }

  DashboardState copyWith({List<BottomNavbarItemModel>? tabs}) {
    return DashboardState(
      tabs: tabs ?? this.tabs,
    );
  }
}
