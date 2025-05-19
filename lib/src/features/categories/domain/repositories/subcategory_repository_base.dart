import '../entities/subcategory/subcategory_entity.dart';

abstract class SubcategoryRepositoryBase {
  Future<List<SubcategoryEntity>> getAllSubcategories();

  Future<void> clearSubcategoriesByCategory(String categoryKey);

  Future<void> addSubcategory(SubcategoryEntity subcategory);

  Future<void> deleteSubcategory(String key);

  Future<void> updateSubcategory(SubcategoryEntity subcategory);

  Future<void> clearSubcategoriesByCategories(List<String> categoryKeys);
}
