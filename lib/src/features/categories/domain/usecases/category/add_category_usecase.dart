
import '../../entities/category/category_entity.dart';
import '../../repositories/category_repository_base.dart';

class AddCategoryUseCase {
  final CategoryRepositoryBase _repository;

  AddCategoryUseCase(this._repository);

  List<CategoryEntity> call(
      List<CategoryEntity> categories, CategoryEntity newCategory) {
    final minOrder = categories
        .where((c) => c.type == newCategory.type)
        .map((c) => c.order)
        .fold<int>(0, (prev, next) => next < prev ? next : prev);

    final categoryWithOrder = newCategory.copyWith(order: minOrder - 1);

    final updated = [categoryWithOrder, ...categories];
    _repository.saveCategories(updated);
    return updated;
  }
}
