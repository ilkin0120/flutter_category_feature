import 'package:flutter_category_feature/src/features/categories/domain/entities/category/category_entity.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/icon_tile.dart';

class CategoryIconTile extends StatelessWidget {
  final CategoryEntity? category;
  final bool isSelected;
  final double size;

  const CategoryIconTile({
    super.key,
    this.category,
    this.isSelected = false,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return IconTile(
      color: category?.color ?? Colors.grey,
      icon: category?.iconData ?? Icons.question_mark_outlined,
      isSelected: isSelected,
      size: size,
    );
  }
}
