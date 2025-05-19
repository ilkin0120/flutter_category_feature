import '../../repositories/subcategory_repository_base.dart';

class ClearSubcategoriesByCategoryUseCase {
  final SubcategoryRepositoryBase _repository;

  ClearSubcategoriesByCategoryUseCase(this._repository);

  Future<void> call(String categoryKey) async {
    await _repository.clearSubcategoriesByCategory(categoryKey);
  }

  void deleteMultiple(
    List<String> idsToDelete,
  ) async {
    await _repository.clearSubcategoriesByCategories(idsToDelete);
  }
}
