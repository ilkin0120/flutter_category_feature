import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'selected_categories_state.dart';

class SelectedCategoriesCubit extends Cubit<SelectedCategoriesState> {
  SelectedCategoriesCubit()
      : super(const SelectedCategoriesState(selectedCategoriesKeys: []));

  void select(String id) {
    final updated = [...state.selectedCategoriesKeys];
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }

    emit(SelectedCategoriesState(selectedCategoriesKeys: updated));
  }

  void removeAll() {
    emit(const SelectedCategoriesState(selectedCategoriesKeys: []));
  }
}
