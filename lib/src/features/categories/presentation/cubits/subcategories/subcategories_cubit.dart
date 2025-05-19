import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/subcategory/subcategory_entity.dart';
import '../../../domain/usecases/subcategory/add_subcategory_usecase.dart';

import '../../../domain/usecases/subcategory/delete_subcategory_usecase.dart';
import '../../../domain/usecases/subcategory/get_all_subcategories_usecase.dart';
import '../../../domain/usecases/subcategory/get_subcategories_by_category_usecase.dart';
import '../../../domain/usecases/subcategory/update_subcategory_usecase.dart';

part 'subcategories_state.dart';

class SubcategoriesCubit extends Cubit<SubcategoriesState> {
  SubcategoriesCubit(
      {required GetSubcategoriesByCategoryUseCase
          getSubcategoriesByCategoryUseCase,
      required GetAllSubcategoriesUseCase getAllSubcategoriesUseCase,
      required AddSubcategoryUseCase addSubCategoryUseCase,
      required DeleteSubcategoryUseCase deleteSubcategoryUseCase,
      required UpdateSubcategoryUseCase updateSubcategoryUseCase})
      : _addSubCategoryUseCase = addSubCategoryUseCase,
        _deleteSubcategoryUseCase = deleteSubcategoryUseCase,
        _getSubcategoriesByCategoryUseCase = getSubcategoriesByCategoryUseCase,
        _updateSubcategoryUseCase = updateSubcategoryUseCase,
        _getAllSubcategoriesUseCase = getAllSubcategoriesUseCase,
        super(const SubcategoriesState(
            subcategories: [], filteredSubcategories: []));

  final GetSubcategoriesByCategoryUseCase _getSubcategoriesByCategoryUseCase;
  final AddSubcategoryUseCase _addSubCategoryUseCase;
  final DeleteSubcategoryUseCase _deleteSubcategoryUseCase;
  final UpdateSubcategoryUseCase _updateSubcategoryUseCase;
  final GetAllSubcategoriesUseCase _getAllSubcategoriesUseCase;

  Map<String, SubcategoryEntity>? _subcategoryMapCache;

  Map<String, SubcategoryEntity> get subcategoryMap {
    _subcategoryMapCache ??= {
      for (final sub in state.subcategories) sub.key: sub,
    };
    return _subcategoryMapCache!;
  }

  void _clearCache() {
    _subcategoryMapCache = null;
  }

  Future<void> loadAllSubcategories() async {
    final result = await _getAllSubcategoriesUseCase();
    _clearCache();

    emit(state.copyWith(subcategories: result));
  }

  void loadSubcategoriesByCategoryKey(String categoryKey) async {
    final result =
        _getSubcategoriesByCategoryUseCase(categoryKey, state.subcategories);
    _clearCache();

    emit(state.copyWith(filteredSubcategories: result));
  }

  void addSubcategory(String categoryKey, String name) {
    final (subcategories, filteredSubcategories) = _addSubCategoryUseCase(
        categoryKey,
        name.trim(),
        state.subcategories,
        state.filteredSubcategories);
    _clearCache();

    emit(state.copyWith(
        subcategories: subcategories,
        filteredSubcategories: filteredSubcategories));
  }

  void updateSubcategory(String key, String categoryKey, String name) {
    final (subcategories, filteredSubcategories) = _updateSubcategoryUseCase(
        key,
        categoryKey,
        name.trim(),
        state.subcategories,
        state.filteredSubcategories);
    _clearCache();
    emit(state.copyWith(
        subcategories: subcategories,
        filteredSubcategories: filteredSubcategories));
  }

  void removeSubcategory(String key) {
    final (subcategories, filteredSubcategories) = _deleteSubcategoryUseCase(
        state.subcategories, state.filteredSubcategories, key);
    _clearCache();

    emit(state.copyWith(
        subcategories: subcategories,
        filteredSubcategories: filteredSubcategories));
  }

  void setBeingDeleted(SubcategoryEntity subcategory) {
    final index = state.filteredSubcategories.indexOf(subcategory);

    final updated = [...state.filteredSubcategories];
    _clearCache();

    updated[index] = subcategory.copyWith(isBeingDeleted: true);
    emit(state.copyWith(filteredSubcategories: updated));
  }
}
