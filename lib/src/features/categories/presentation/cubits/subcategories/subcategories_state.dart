part of 'subcategories_cubit.dart';

@immutable
class SubcategoriesState {
  final List<SubcategoryEntity> subcategories;
  final List<SubcategoryEntity> filteredSubcategories;

  const SubcategoriesState(
      {required this.subcategories, required this.filteredSubcategories});

  SubcategoriesState copyWith(
      {List<SubcategoryEntity>? subcategories,
      List<SubcategoryEntity>? filteredSubcategories}) {
    return SubcategoriesState(
        subcategories: subcategories ?? this.subcategories,
        filteredSubcategories:
            filteredSubcategories ?? this.filteredSubcategories);
  }
}
