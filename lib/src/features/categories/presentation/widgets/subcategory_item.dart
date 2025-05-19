import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../../../../common/widgets/custom_ink_well.dart';
import '../../domain/entities/subcategory/subcategory_entity.dart';

class SubcategoryItem extends StatelessWidget {
  final SubcategoryEntity entity;
  final VoidCallback onClick;

  const SubcategoryItem({
    super.key,
    required this.entity,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          entity.name,
          style: context.text.bodyLarge.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
