import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';

import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/usecases/category/add_category_usecase.dart';
import '../../../domain/usecases/category/delete_category_usecase.dart';
import '../../../domain/usecases/category/get_categories_usecase.dart';
import '../../../domain/usecases/category/reorder_category_usecase.dart';
import '../../../domain/usecases/category/update_category_usecase.dart';
import '../../../domain/usecases/subcategory/clear_subcategories_by_category_usecase.dart';

part 'category_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required AddCategoryUseCase addCategoryUseCase,
    required ClearSubcategoriesByCategoryUseCase
        clearSubcategoryByCategoryUseCase,
    required DeleteCategoryUseCase deleteCategoryUseCase,
    required ReorderCategoriesUseCase reorderCategoriesUseCase,
    required UpdateCategoryUseCase updateCategoryUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _deleteCategoryUseCase = deleteCategoryUseCase,
        _addCategoryUseCase = addCategoryUseCase,
        _reorderCategoriesUseCase = reorderCategoriesUseCase,
        _clearSubcategoryByCategoryUseCase = clearSubcategoryByCategoryUseCase,
        _updateCategoriesUseCase = updateCategoryUseCase,
        super(const CategoriesState(categories: []));

  final GetCategoriesUseCase _getCategoriesUseCase;
  final ClearSubcategoriesByCategoryUseCase _clearSubcategoryByCategoryUseCase;
  final AddCategoryUseCase _addCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  final ReorderCategoriesUseCase _reorderCategoriesUseCase;
  final UpdateCategoryUseCase _updateCategoriesUseCase;

  Map<String, CategoryEntity>? _categoryMapCache;

  void _emitWithCacheReset(List<CategoryEntity> categories) {
    _categoryMapCache = null;
    emit(CategoriesState(categories: categories));
  }

  Future<void> loadCategories() async {
    final categories = await _getCategoriesUseCase();
    _emitWithCacheReset(categories);
  }

  void addCategory(CategoryEntity category) {
    final updatedCategories = _addCategoryUseCase(state.categories, category);

    _emitWithCacheReset(updatedCategories);
  }

  void reorderCategories(int oldIndex, int newIndex, int type) {
    final updatedCategories =
        _reorderCategoriesUseCase(state.categories, oldIndex, newIndex, type);
    emit(CategoriesState(categories: updatedCategories));
  }

  void removeCategories(List<String> ids) {
    final updatedCategories =
        _deleteCategoryUseCase(ids, state.categories);
    _clearSubcategoryByCategoryUseCase.deleteMultiple(ids);
    _emitWithCacheReset(updatedCategories);
  }

  void updateCategory(CategoryEntity updatedCategory) {
    final updatedCategories =
        _updateCategoriesUseCase(state.categories, updatedCategory);

    _emitWithCacheReset(updatedCategories);
  }

  void setBeingDeleted(String categoryId) {
    final index = state.categories.indexWhere((cat) => cat.key == categoryId);
    if (index == -1) return;

    final updatedCategory =
        state.categories[index].copyWith(isBeingDeleted: true);
    final updatedCategories = [...state.categories];
    updatedCategories[index] = updatedCategory;

    _emitWithCacheReset(updatedCategories);
  }

  Map<String, CategoryEntity> get categoryMap {
    _categoryMapCache ??= {
      for (final cat in state.categories) cat.key: cat,
    };
    return _categoryMapCache!;
  }
}
