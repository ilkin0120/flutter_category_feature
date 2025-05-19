import 'package:hive/hive.dart';

import '../models/category/category_model.dart';

abstract class CategoryLocalDataSourceBase {
  Future<void> saveCategories(List<CategoryModel> categories);

  Future<List<CategoryModel>> loadCategories();

  Future<void> deleteCategoriesByIds(List<String> ids);
}

class CategoryLocalDataSource implements CategoryLocalDataSourceBase {
  static const String _boxName = 'categories_box';

  Future<Box<CategoryModel>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<CategoryModel>(_boxName);
    }
    return Hive.box<CategoryModel>(_boxName);
  }

  @override
  Future<void> deleteCategoriesByIds(List<String> ids) async {
    final box = await _box;
    await box.deleteAll(ids);
  }

  @override
  Future<void> saveCategories(List<CategoryModel> categories) async {
    final box = await _box;
    await box.clear();
    for (var category in categories) {
      await box.put(category.key, category);
    }
  }

  @override
  Future<List<CategoryModel>> loadCategories() async {
    final box = await _box;
    final categories = box.values.toList();

    categories.sort((a, b) => a.order.compareTo(b.order));

    return categories;
  }
}
