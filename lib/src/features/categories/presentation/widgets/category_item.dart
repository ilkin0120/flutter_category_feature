import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import 'category_icon_tile.dart';

import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_gap.dart';
import '../../domain/entities/category/category_entity.dart';

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final CategoryEntity categoryEntity;

  const CategoryItem(
      {super.key, required this.categoryEntity, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CategoryIconTile(
          isSelected: isSelected,
          category: categoryEntity,
        ),
        const VerticalGap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            categoryEntity.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                context.text.bodyMedium.copyWith(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
