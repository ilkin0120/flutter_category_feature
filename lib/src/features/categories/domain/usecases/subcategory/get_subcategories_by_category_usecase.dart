import '../../entities/subcategory/subcategory_entity.dart';

class GetSubcategoriesByCategoryUseCase {
  GetSubcategoriesByCategoryUseCase();

  List<SubcategoryEntity> call(
      String categoryKey, List<SubcategoryEntity> subcategories) {
    return subcategories
        .where((model) => model.categoryKey == categoryKey)
        .toList();
  }
}
