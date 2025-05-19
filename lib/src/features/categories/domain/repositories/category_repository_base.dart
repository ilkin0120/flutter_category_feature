import '../entities/category/category_entity.dart';

abstract class CategoryRepositoryBase {
  Future<List<CategoryEntity>> getCategories();

  Future<void> saveCategories(List<CategoryEntity> categories);

  Future<void> deleteMultipleCategories(List<String> idsToDelete);
}
