import 'package:hive/hive.dart';
import '../models/subcategory/subcategory_model.dart';

abstract class SubcategoryLocalDataSourceBase {
  Future<void> addSubcategory(SubcategoryModel subcategory);

  Future<void> deleteSubcategory(String key);

  Future<void> clearSubcategoriesByCategory(String categoryKey);

  Future<void> updateSubcategory(SubcategoryModel subcategory);

  Future<List<SubcategoryModel>> loadSubcategories();

  Future<void> clearSubcategoriesByCategories(List<String> categoryKeys);
}

class SubcategoryLocalDataSource implements SubcategoryLocalDataSourceBase {
  static const String _boxName = 'subcategories_box';

  Future<Box<SubcategoryModel>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<SubcategoryModel>(_boxName);
    }
    return Hive.box<SubcategoryModel>(_boxName);
  }

  @override
  Future<void> addSubcategory(SubcategoryModel subcategory) async {
    final box = await _box;
    await box.put(subcategory.key, subcategory);
  }

  @override
  Future<void> deleteSubcategory(String key) async {
    final box = await _box;
    await box.delete(key);
  }

  @override
  Future<void> updateSubcategory(SubcategoryModel subcategory) async {
    final box = await _box;
    if (box.containsKey(subcategory.key)) {
      await box.put(subcategory.key, subcategory);
    }
  }

  @override
  Future<void> clearSubcategoriesByCategories(List<String> categoryKeys) async {
    final box = await _box;

    final keysToDelete = box.values
        .where((subcat) => categoryKeys.contains(subcat.categoryKey))
        .map((subcat) => subcat.key)
        .toList();

    await box.deleteAll(keysToDelete);
  }

  @override
  Future<List<SubcategoryModel>> loadSubcategories() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> clearSubcategoriesByCategory(String categoryKey) async {
    final box = await _box;
    final keysToDelete = box.values
        .where((s) => s.categoryKey == categoryKey)
        .map((s) => s.key)
        .toList();
    await box.deleteAll(keysToDelete);
  }
}
