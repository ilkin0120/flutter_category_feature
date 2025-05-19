
import '../../entities/category/category_entity.dart';
import '../../repositories/category_repository_base.dart';

class ReorderCategoriesUseCase {
  final CategoryRepositoryBase _repository;

  ReorderCategoriesUseCase(this._repository);

  List<CategoryEntity> call(
    List<CategoryEntity> categories,
    int oldIndex,
    int newIndex,
    int type,
  ) {
    final filtered = categories.where((c) => c.type == type).toList();
    final item = filtered.removeAt(oldIndex);
    filtered.insert(newIndex, item);

    final reordered = <CategoryEntity>[];
    for (int i = 0; i < filtered.length; i++) {
      reordered.add(filtered[i].copyWith(order: i));
    }

    final updated = categories.map((c) {
      if (c.type == type) {
        return reordered.removeAt(0);
      }
      return c;
    }).toList();

    _repository.saveCategories(updated);
    return updated;
  }
}
