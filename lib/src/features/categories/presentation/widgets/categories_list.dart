
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../../common/constants/ui_constants.dart';
import '../../../../common/widgets/custom_ink_well.dart';
import '../../domain/entities/category/category_entity.dart';
import '../cubits/categories/category_cubit.dart';
import '../cubits/selected_categories/selected_categories_cubit.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  final int categoryType;

  final Function(CategoryEntity) onCategoryClick;

  final Function(String) onCategoryDoubleClick;

  const CategoriesList({
    super.key,
    required this.categoryType,
    required this.onCategoryClick,
    required this.onCategoryDoubleClick,
  });

  @override
  Widget build(BuildContext context) {
    final selectedCategoryCubit = context.watch<SelectedCategoriesCubit>();
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidth = 56.0;
    const spacing = 40.0;
    int crossAxisCount = (screenWidth / (itemWidth + spacing)).floor();
    crossAxisCount = crossAxisCount.clamp(1, 5);

    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
      return ReorderableGridView.count(
        onReorder: (oldIndex, newIndex) {
          context
              .read<CategoriesCubit>()
              .reorderCategories(oldIndex, newIndex, categoryType);
        },
        dragWidgetBuilderV2: DragWidgetBuilderV2(
            isScreenshotDragWidget: false,
            builder: (index, child, screenshot) {
              return Transform.scale(
                scale: 1.1,
                child: Material(
                  color: Colors.transparent,
                  child: child,
                ),
              );
            }),
        crossAxisCount: crossAxisCount,
        children: state.categories
            .where((category) => category.type == categoryType)
            .map((category) {
          return CustomInkWell(
            disableEffects: true,
            key: ValueKey(category.key),
            onTap: () => onCategoryClick(category),
            onDoubleTap: () => onCategoryDoubleClick(category.key),
            child: AnimatedOpacity(
              duration: UIConstants.fastAnimationDuration,
              opacity: category.isBeingDeleted ? 0.0 : 1.0,
              child: AnimatedScale(
                duration: UIConstants.fastAnimationDuration,
                scale: category.isBeingDeleted ? 0.0 : 1.0,
                child: CategoryItem(
                  key: ValueKey(category.key),
                  categoryEntity: category,
                  isSelected: selectedCategoryCubit.state.selectedCategoriesKeys
                      .contains(category.key),
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
