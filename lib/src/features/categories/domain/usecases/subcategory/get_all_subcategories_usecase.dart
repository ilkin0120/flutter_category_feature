import '../../entities/subcategory/subcategory_entity.dart';

import '../../repositories/subcategory_repository_base.dart';

class GetAllSubcategoriesUseCase {
  final SubcategoryRepositoryBase _repository;

  GetAllSubcategoriesUseCase(this._repository);

  Future<List<SubcategoryEntity>> call() async {
    return await _repository.getAllSubcategories();
  }
}
