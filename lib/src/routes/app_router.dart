import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/routes/route_names.dart';
import '../common/di/app_dependencies.dart';
import '../common/screens/all_colors_page.dart';
import '../common/screens/all_icon_page.dart';
import '../features/categories/domain/entities/category/category_entity.dart';
import '../features/categories/presentation/screens/all_categories.dart';
import '../features/categories/presentation/screens/categories.dart';
import '../features/categories/presentation/screens/category_form.dart';
import '../features/splash_screen/presentation/screens/splash_screen.dart';
import 'custom_page_route.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreenRoute:
        return CustomPageRoute(builder: (_) => const SplashScreen());

      case categoriesRoute:
        return CustomPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: AppDependencies.categories),

                  BlocProvider.value(value: AppDependencies.subcategories),
                  BlocProvider(
                    create: (context) => AppDependencies.selectedCategory,
                  ),
                ],
                child: const Categories(),
              ),
        );

      case allColorsRoute:
        final arguments = routeSettings.arguments as Map;
        final defaultColorsCubit =
            AppDependencies.defaultColors
              ..setColor(arguments['previousColor'] as Color);

        return CustomPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => defaultColorsCubit,
                child: AllColorsPage(
                  onClick: arguments['onClick'],
                  isCircle: arguments['isCircle'],
                ),
              ),
        );

      case allIconsRoute:
        final arguments = routeSettings.arguments as Map;
        final defaultIconsCubit =
            AppDependencies.defaultIcons..setIcon(arguments['selectedIcon']);

        return CustomPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [BlocProvider.value(value: defaultIconsCubit)],
                child: AllIconsPage(
                  onClick: arguments['onClick'],
                  selectedColor: arguments['selectedColor'],
                ),
              ),
        );

      case allCategoriesRoute:
        final arguments = routeSettings.arguments as Map;

        return CustomPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: AppDependencies.categories),
                ],
                child: AllCategories(
                  categoryType: arguments['categoryType'] as int,
                  onCategoryClick: arguments['onClick'],
                ),
              ),
        );

      case categoryFormRoute:
        final arguments = routeSettings.arguments as Map;

        return CustomPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AppDependencies.defaultColors,
                  ),
                  BlocProvider(
                    create: (context) => AppDependencies.defaultIcons,
                  ),
                  BlocProvider.value(value: AppDependencies.editCategory),
                  BlocProvider.value(value: AppDependencies.categories),
                ],
                child: CategoryFormPage(
                  categoryType: arguments['tabIndex'] as int,
                  categoryToEdit:
                      arguments['categoryToEdit'] as CategoryEntity?,
                ),
              ),
        );

      default:
        return null;
    }
  }
}
