import '../../entities/subcategory/subcategory_entity.dart';
import '../../repositories/subcategory_repository_base.dart';

class DeleteSubcategoryUseCase {
  final SubcategoryRepositoryBase _repository;

  DeleteSubcategoryUseCase(this._repository);

  (List<SubcategoryEntity>, List<SubcategoryEntity>) call(
      List<SubcategoryEntity> subcategories,
      List<SubcategoryEntity> filteredSubcategories,
      String key) {
    _repository.deleteSubcategory(key);
    return (
      subcategories.where((c) => c.key != key).toList(),
      filteredSubcategories.where((c) => c.key != key).toList()
    );
  }
}
