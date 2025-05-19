import '../../entities/subcategory/subcategory_entity.dart';

import '../../repositories/subcategory_repository_base.dart';

class UpdateSubcategoryUseCase {
  final SubcategoryRepositoryBase _repository;

  UpdateSubcategoryUseCase(this._repository);

  (List<SubcategoryEntity>, List<SubcategoryEntity>) call(
      String key,
      String categoryKey,
      String updatedName,
      List<SubcategoryEntity> subcategories,
      List<SubcategoryEntity> filteredSubcategories) {
    SubcategoryEntity newSubcategory = SubcategoryEntity(
        key: key, categoryKey: categoryKey, name: updatedName);
    _repository.updateSubcategory(newSubcategory);

    List<SubcategoryEntity> updatedSubcategories =
        subcategories.map((subcategory) {
      return subcategory.key == key ? newSubcategory : subcategory;
    }).toList();

    List<SubcategoryEntity> updatedFilteredSubcategories = updatedSubcategories
        .where((subcategory) => subcategory.categoryKey == categoryKey)
        .toList();

    return (updatedSubcategories, updatedFilteredSubcategories);
  }
}
