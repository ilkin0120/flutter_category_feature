import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../../../../common/constants/assets.dart';

import '../../../../common/constants/transaction_types.dart';
import '../../../../common/constants/ui_constants.dart';
import '../../../../common/widgets/custom_alert_dialog.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_close_button.dart';
import '../../../../common/widgets/custom_gap.dart';
import '../../../../common/widgets/custom_svg.dart';
import '../../../../common/widgets/default_app_bar.dart';
import '../../../../common/widgets/delete_button.dart';
import '../../../../common/widgets/tab_bar_with_view.dart';
import '../../../../routes/route_names.dart';
import '../cubits/categories/category_cubit.dart';
import '../cubits/selected_categories/selected_categories_cubit.dart';
import '../cubits/subcategories/subcategories_cubit.dart';
import '../widgets/categories_list.dart';
import '../widgets/subcategory_bottom_sheet.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void removeAll() {
    context.read<SelectedCategoriesCubit>().removeAll();
  }

  String appBarText(List<String> selectedCategories) {
    if (selectedCategories.isEmpty) {
      return 'Категории';
    } else if (selectedCategories.length > 1) {
      return 'Выбрано: ${selectedCategories.length}';
    } else {
      final categoryMap = context.read<CategoriesCubit>().categoryMap;
      return categoryMap[selectedCategories.first]?.name ?? 'Категория';
    }
  }

  void _showDeleteConfirmationDialog(List<String> selectedCategories) {
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return CustomAlertDialog(
          title:
              'Удалить ${selectedCategories.length > 1 ? "категории" : "категорию"}?',
          content: 'Все связанные транзакции останутся без категории.',
          confirmText: 'Удалить',
          onConfirm: () {
            final categoryCubit = context.read<CategoriesCubit>();
            if (selectedCategories.length == 1) {
              categoryCubit.setBeingDeleted(selectedCategories.first);
            }
            Future.delayed(UIConstants.fastAnimationDuration, () {
              if (mounted) {
                categoryCubit.removeCategories(selectedCategories);
                removeAll();
              }
            });
            Navigator.of(context).pop();
          },
          isConfirmDestructive: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryMap = context.read<CategoriesCubit>().categoryMap;
    final selectedCategoryCubit = context.watch<SelectedCategoriesCubit>();
    final selectedCategories =
        selectedCategoryCubit.state.selectedCategoriesKeys;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        final navigator = Navigator.of(context);
        if (didPop) {
          return;
        }
        if (selectedCategories.isNotEmpty) {
          removeAll();
        } else {
          return navigator.pop();
        }
      },
      child: Scaffold(
        appBar: DefaultAppBar(
          customLeading:
              selectedCategories.isNotEmpty
                  ? CustomCloseButton(onClick: removeAll)
                  : null,
          showBackButton: false,
          height: 56,
          titleWidget: Text(
            appBarText(selectedCategories),
            style: context.text.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            Row(
              children: [
                if (selectedCategories.length == 1)
                  CustomButton(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          categoryFormRoute,
                          arguments: {
                            "categoryToEdit":
                                categoryMap[selectedCategories.first],
                            "tabIndex": _tabController.index,
                          },
                        ).then((value) {
                          removeAll();
                        }),
                    svgIcon: CustomSvg(
                      asset: Assets.icons.edit,
                      color: context.color.secondaryTextColor,
                    ),
                  ),
                if (selectedCategories.isNotEmpty) ...[
                  const HorizontalGap(24),
                  DeleteButton(
                    onClick:
                        () => _showDeleteConfirmationDialog(selectedCategories),
                  ),
                ],
              ],
            ),
            if (selectedCategories.isEmpty)
              CustomButton(
                onPressed:
                    () => Navigator.pushNamed(
                      context,
                      categoryFormRoute,
                      arguments: {"tabIndex": _tabController.index},
                    ),
                //,
                icon: Icon(Icons.add, color: context.color.primaryColor),
              ),
          ],
        ),
        body: TabBarWithView(
          tabTitles: const ['Расходы', 'Доходы'],
          tabViews:
              TransactionType.allTypes.map((categoryType) {
                return CategoriesList(
                  onCategoryClick:
                      (category) => context
                          .read<SelectedCategoriesCubit>()
                          .select(category.key),
                  onCategoryDoubleClick: (categoryKey) {
                    context
                        .read<SubcategoriesCubit>()
                        .loadSubcategoriesByCategoryKey(categoryKey);
                    _showSubcategoryBottomSheet(context);
                    context.read<SelectedCategoriesCubit>()
                      ..removeAll()
                      ..select(categoryKey);
                  },
                  categoryType: categoryType,
                );
              }).toList(),
        ),
      ),
    );
  }

  void _showSubcategoryBottomSheet(BuildContext context) {
    final categoryKey =
        context
            .read<SelectedCategoriesCubit>()
            .state
            .selectedCategoriesKeys
            .first;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SubcategoriesCubit>(),
          child: SubcategoryBottomSheet(categoryKey: categoryKey),
        );
      },
    );
  }
}
