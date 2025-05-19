import '../../entities/category/category_entity.dart';
import '../../repositories/category_repository_base.dart';

class DeleteCategoryUseCase {
  final CategoryRepositoryBase _repository;

  DeleteCategoryUseCase(this._repository);

  List<CategoryEntity> call(List<String> ids, List<CategoryEntity> categories) {
    final updatedCategories =
        categories.where((c) => !ids.contains(c.key)).toList();

    _repository.saveCategories(updatedCategories);
    return updatedCategories;
  }
}
