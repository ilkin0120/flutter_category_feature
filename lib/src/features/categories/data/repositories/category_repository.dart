import '../../domain/entities/category/category_entity.dart';
import '../../domain/repositories/category_repository_base.dart';
import '../datasources/category_local_datasource.dart';
import '../models/category/category_model.dart';

class CategoryRepository extends CategoryRepositoryBase {
  final CategoryLocalDataSourceBase _localDataSource;

  CategoryRepository(this._localDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final categoryModels = await _localDataSource.loadCategories();
    return categoryModels.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> saveCategories(List<CategoryEntity> categories) async {
    final categoriesModels =
        categories.map((e) => CategoryModel.fromEntity(e)).toList();
    await _localDataSource.saveCategories(categoriesModels);
  }

  @override
  Future<void> deleteMultipleCategories(List<String> idsToDelete) async {
    await _localDataSource.deleteCategoriesByIds(idsToDelete);
  }
}
