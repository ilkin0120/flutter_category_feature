import '../../entities/subcategory/subcategory_entity.dart';
import '../../repositories/subcategory_repository_base.dart';

class AddSubcategoryUseCase {
  final SubcategoryRepositoryBase _repository;

  AddSubcategoryUseCase(this._repository);

  (List<SubcategoryEntity>, List<SubcategoryEntity>) call(
      String categoryKey,
      String name,
      List<SubcategoryEntity> subcategories,
      List<SubcategoryEntity> filteredSubcategories) {
    final newSubcategory =
        SubcategoryEntity.create(categoryKey: categoryKey, name: name);
    _repository.addSubcategory(newSubcategory);

    return (
      List.of(subcategories)..add(newSubcategory),
      List.of(filteredSubcategories)..add(newSubcategory)
    );
  }
}
