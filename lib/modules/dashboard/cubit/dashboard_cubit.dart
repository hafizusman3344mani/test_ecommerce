import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/asset_paths.dart';
import '../models/bottom_navbar_item_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  changeNavSelection(int index) {
    var tabs = state.tabs;
    tabs.firstWhere((element) => element.isSelected == true).isSelected = false;
    tabs[index].isSelected = true;
    emit(state.copyWith(tabs: tabs));
  }
}
