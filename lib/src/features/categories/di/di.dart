import 'package:get_it/get_it.dart';

import '../data/datasources/category_local_datasource.dart';
import '../data/datasources/subcategory_local_datasource.dart';
import '../data/repositories/category_repository.dart';
import '../data/repositories/subcategory_repository.dart';
import '../domain/repositories/category_repository_base.dart';
import '../domain/repositories/subcategory_repository_base.dart';
import '../domain/usecases/category/add_category_usecase.dart';
import '../domain/usecases/category/delete_category_usecase.dart';
import '../domain/usecases/category/get_categories_usecase.dart';
import '../domain/usecases/category/reorder_category_usecase.dart';
import '../domain/usecases/category/update_category_usecase.dart';
import '../domain/usecases/subcategory/add_subcategory_usecase.dart';
import '../domain/usecases/subcategory/clear_subcategories_by_category_usecase.dart';
import '../domain/usecases/subcategory/delete_subcategory_usecase.dart';
import '../domain/usecases/subcategory/get_all_subcategories_usecase.dart';
import '../domain/usecases/subcategory/get_subcategories_by_category_usecase.dart';
import '../domain/usecases/subcategory/update_subcategory_usecase.dart';
import '../presentation/cubits/categories/category_cubit.dart';
import '../presentation/cubits/edit_category/edit_category_cubit.dart';
import '../presentation/cubits/selected_categories/selected_categories_cubit.dart';
import '../presentation/cubits/subcategories/subcategories_cubit.dart';

final getItCategory = GetIt.instance;

Future<void> setupCategoryDependencies() async {
  getItCategory.registerLazySingleton<CategoryLocalDataSourceBase>(
    () => CategoryLocalDataSource(),
  );

  getItCategory.registerLazySingleton<SubcategoryLocalDataSourceBase>(
    () => SubcategoryLocalDataSource(),
  );

// Repository
  getItCategory.registerLazySingleton<CategoryRepositoryBase>(
    () => CategoryRepository(getItCategory<CategoryLocalDataSourceBase>()),
  );
  getItCategory.registerLazySingleton<SubcategoryRepositoryBase>(
    () =>
        SubcategoryRepository(getItCategory<SubcategoryLocalDataSourceBase>()),
  );

  // UseCases
  getItCategory.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getItCategory<CategoryRepositoryBase>()),
  );

  getItCategory.registerFactory<GetSubcategoriesByCategoryUseCase>(
    () => GetSubcategoriesByCategoryUseCase(),
  );
  getItCategory.registerLazySingleton<GetAllSubcategoriesUseCase>(
    () =>
        GetAllSubcategoriesUseCase(getItCategory<SubcategoryRepositoryBase>()),
  );

  getItCategory.registerLazySingleton<AddCategoryUseCase>(
    () => AddCategoryUseCase(getItCategory<CategoryRepositoryBase>()),
  );

  getItCategory.registerLazySingleton<AddSubcategoryUseCase>(
    () => AddSubcategoryUseCase(getItCategory<SubcategoryRepositoryBase>()),
  );

  getItCategory.registerLazySingleton<ReorderCategoriesUseCase>(
    () => ReorderCategoriesUseCase(getItCategory<CategoryRepositoryBase>()),
  );
  getItCategory.registerLazySingleton<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(getItCategory<CategoryRepositoryBase>()),
  );
  getItCategory.registerLazySingleton<DeleteSubcategoryUseCase>(
    () => DeleteSubcategoryUseCase(getItCategory<SubcategoryRepositoryBase>()),
  );
  getItCategory.registerLazySingleton<ClearSubcategoriesByCategoryUseCase>(
    () => ClearSubcategoriesByCategoryUseCase(
        getItCategory<SubcategoryRepositoryBase>()),
  );
  getItCategory.registerLazySingleton<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(getItCategory<CategoryRepositoryBase>()),
  );
  getItCategory.registerLazySingleton<UpdateSubcategoryUseCase>(
    () => UpdateSubcategoryUseCase(getItCategory<SubcategoryRepositoryBase>()),
  );
  getItCategory.registerLazySingleton<CategoriesCubit>(
    () => CategoriesCubit(
        getCategoriesUseCase: getItCategory<GetCategoriesUseCase>(),
        addCategoryUseCase: getItCategory<AddCategoryUseCase>(),
        reorderCategoriesUseCase: getItCategory<ReorderCategoriesUseCase>(),
        deleteCategoryUseCase: getItCategory<DeleteCategoryUseCase>(),
        updateCategoryUseCase: getItCategory<UpdateCategoryUseCase>(),
        clearSubcategoryByCategoryUseCase:
            getItCategory<ClearSubcategoriesByCategoryUseCase>()),
  );

  getItCategory.registerLazySingleton<SubcategoriesCubit>(
    () => SubcategoriesCubit(
        addSubCategoryUseCase: getItCategory<AddSubcategoryUseCase>(),
        deleteSubcategoryUseCase: getItCategory<DeleteSubcategoryUseCase>(),
        getAllSubcategoriesUseCase: getItCategory<GetAllSubcategoriesUseCase>(),
        getSubcategoriesByCategoryUseCase:
            getItCategory<GetSubcategoriesByCategoryUseCase>(),
        updateSubcategoryUseCase: getItCategory<UpdateSubcategoryUseCase>()),
  );
  getItCategory.registerFactory<SelectedCategoriesCubit>(
    () => SelectedCategoriesCubit(),
  );
  getItCategory.registerLazySingleton<EditCategoryCubit>(
    () => EditCategoryCubit(),
  );
}
