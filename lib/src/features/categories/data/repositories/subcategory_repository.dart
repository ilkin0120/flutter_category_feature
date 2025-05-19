import '../../domain/entities/subcategory/subcategory_entity.dart';
import '../../domain/repositories/subcategory_repository_base.dart';
import '../datasources/subcategory_local_datasource.dart';
import '../models/subcategory/subcategory_model.dart';

class SubcategoryRepository implements SubcategoryRepositoryBase {
  final SubcategoryLocalDataSourceBase _localDataSource;

  SubcategoryRepository(this._localDataSource);

  @override
  Future<void> addSubcategory(SubcategoryEntity subcategory) async {
    await _localDataSource
        .addSubcategory(SubcategoryModel.fromEntity(subcategory));
  }

  @override
  Future<void> deleteSubcategory(String key) async {
    await _localDataSource.deleteSubcategory(key);
  }

  @override
  Future<void> updateSubcategory(SubcategoryEntity subcategory) async {
    await _localDataSource
        .updateSubcategory(SubcategoryModel.fromEntity(subcategory));
  }

  @override
  Future<List<SubcategoryEntity>> getAllSubcategories() async {
    final models = await _localDataSource.loadSubcategories();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> clearSubcategoriesByCategory(String categoryKey) async {
    await _localDataSource.clearSubcategoriesByCategory(categoryKey);
  }

  @override
  Future<void> clearSubcategoriesByCategories(List<String> categoryKeys) async {
    await _localDataSource.clearSubcategoriesByCategories(categoryKeys);
  }
}
