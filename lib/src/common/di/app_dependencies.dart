import '../../features/categories/di/di.dart';
import '../../features/categories/presentation/cubits/categories/category_cubit.dart';
import '../../features/categories/presentation/cubits/edit_category/edit_category_cubit.dart';
import '../../features/categories/presentation/cubits/selected_categories/selected_categories_cubit.dart';
import '../../features/categories/presentation/cubits/subcategories/subcategories_cubit.dart';
import '../cubits/default_colors/default_colors_cubit.dart';
import '../cubits/default_icons/default_icons_cubit.dart';
import 'di.dart';

/// Single class for accessing dependencies
class AppDependencies {
  static final _globalDi = getItGlobal;

  static final _categoryDi = getItCategory;

  static Future<void> init() async {
    await setupGlobalDependencies();

    await setupCategoryDependencies();

    await _globalDi.allReady();
    await _categoryDi.allReady();
  }

  /// Category cubits
  static CategoriesCubit get categories => _categoryDi<CategoriesCubit>();

  static EditCategoryCubit get editCategory => _categoryDi<EditCategoryCubit>();

  static SelectedCategoriesCubit get selectedCategory =>
      _categoryDi<SelectedCategoriesCubit>();

  static SubcategoriesCubit get subcategories =>
      _categoryDi<SubcategoriesCubit>();

  static DefaultColorsCubit get defaultColors =>
      _categoryDi<DefaultColorsCubit>();

  static DefaultIconsCubit get defaultIcons => _categoryDi<DefaultIconsCubit>();
}
