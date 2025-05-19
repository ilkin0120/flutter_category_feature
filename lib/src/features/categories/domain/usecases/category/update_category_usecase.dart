
import '../../entities/category/category_entity.dart';
import '../../repositories/category_repository_base.dart';

class UpdateCategoryUseCase {
  final CategoryRepositoryBase _repository;

  UpdateCategoryUseCase(this._repository);

  List<CategoryEntity> call(
      List<CategoryEntity> categories, CategoryEntity updatedCategory) {
    final updatedCategories = categories.map((category) {
      if (category.key == updatedCategory.key) {
        return updatedCategory;
      }
      return category;
    }).toList();
    _repository.saveCategories(updatedCategories);
    return updatedCategories;
  }
}
