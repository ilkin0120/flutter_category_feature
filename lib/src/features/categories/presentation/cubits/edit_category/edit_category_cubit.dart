import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import '../../../../../common/constants/transaction_types.dart';
import '../../../domain/entities/category/category_entity.dart';

part 'edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  static const IconData defaultIcon = Icons.add;

  static const Color defaultColor = Colors.orange;

  EditCategoryCubit()
    : super(
        EditCategoryState(
          entity: CategoryEntity.create(
            name: '',
            iconData: defaultIcon,
            color: defaultColor,
            type: TransactionType.expense,
            order: 0,
          ),
        ),
      );

  void resetState() {
    setName('');
    setColor(Colors.orange);
    setIcon(Icons.add);
  }

  void setName(String value) {
    emit(EditCategoryState(entity: state.entity.copyWith(name: value)));
  }

  void setColor(Color value) {
    emit(EditCategoryState(entity: state.entity.copyWith(color: value)));
  }

  void setCategoryType(int value) {
    emit(EditCategoryState(entity: state.entity.copyWith(type: value)));
  }

  void setIcon(IconData value) {
    emit(EditCategoryState(entity: state.entity.copyWith(iconData: value)));
  }

  void setEditData(CategoryEntity categoryToEdit) {
    setName(categoryToEdit.name);
    setIcon(categoryToEdit.iconData);
    setColor(categoryToEdit.color);
    setCategoryType(categoryToEdit.type);
  }

  bool isFormValid() {
    return state.entity.name.trim().isNotEmpty;
  }

  CategoryEntity buildCategoryEntity({String? key}) {
    return CategoryEntity.create(
      key: key,
      name: state.entity.name.trim(),
      iconData: state.entity.iconData,
      color: state.entity.color,
      type: state.entity.type,
      order: state.entity.order,
    );
  }
}
