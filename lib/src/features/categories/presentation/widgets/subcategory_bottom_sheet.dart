import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter_category_feature/src/features/categories/presentation/widgets/subcategory_form_dialog.dart';
import 'package:flutter_category_feature/src/features/categories/presentation/widgets/subcategory_item.dart';

import '../../../../common/constants/ui_constants.dart';
import '../../../../common/widgets/bottom_sheet_wrapper.dart';
import '../../../../common/widgets/custom_alert_dialog.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_gap.dart';
import '../../domain/entities/subcategory/subcategory_entity.dart';
import '../cubits/subcategories/subcategories_cubit.dart';

class SubcategoryBottomSheet extends StatelessWidget {
  final String categoryKey;
  final Function(String)? onSubcategoryClick;

  const SubcategoryBottomSheet(
      {super.key, required this.categoryKey, this.onSubcategoryClick});

  void _showAddSubcategoryDialog(BuildContext context,
      {String? key, String? name}) {
    showDialog(
      context: context,
      builder: (_) {
        return SubcategoryFormDialog(
            subcategoryName: name,
            onClick: (subcategoryName) => name != null
                ? context
                    .read<SubcategoriesCubit>()
                    .updateSubcategory(key!, categoryKey, subcategoryName)
                : context
                    .read<SubcategoriesCubit>()
                    .addSubcategory(categoryKey, subcategoryName));
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, SubcategoryEntity subcategory) {
    final subcategoryCubit = context.read<SubcategoriesCubit>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Удалить подкатегорию?",
          content:
              "Все связанные с ней доходы и расходы больше не будут привязаны к какой-либо подкатегории.",
          isConfirmDestructive: true,
          confirmText: "Удалить",
          onConfirm: () {
            subcategoryCubit.setBeingDeleted(subcategory);
            Future.delayed(UIConstants.fastAnimationDuration, () {
              subcategoryCubit.removeSubcategory(subcategory.key);
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(children: [
      Text(
        "Подкатегории",
        style: context.text.titleSmall.copyWith(fontWeight: FontWeight.w500),
      ),
      const VerticalGap(16),
      Expanded(
        child: BlocBuilder<SubcategoriesCubit, SubcategoriesState>(
          builder: (context, state) {
            final subcategories = state.filteredSubcategories;

            return ListView.builder(
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return AnimatedOpacity(
                  key: ValueKey(subcategory.key),
                  duration: UIConstants.fastAnimationDuration,
                  opacity: subcategory.isBeingDeleted ? 0.0 : 1.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SubcategoryItem(
                          onClick: () => onSubcategoryClick != null
                              ? onSubcategoryClick!(subcategory.key)
                              : _showAddSubcategoryDialog(
                                  context,
                                  name: subcategory.name,
                                  key: subcategory.key,
                                ),
                          entity: subcategory,
                        ),
                      ),
                      if (onSubcategoryClick == null)
                        CustomButton(
                          onPressed: () => _showDeleteConfirmationDialog(
                              context, subcategory),
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: context.color.errorColor,
                          ),
                          width: 24,
                          height: 24,
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      const VerticalGap(8),
      CustomButton(
        onPressed: () => _showAddSubcategoryDialog(context),
        style: BoxDecoration(
          color: context.color.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text(
          'Добавить подкатегорию',
          style: context.text.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13),
      ),
      const VerticalGap(8)
    ]);
  }
}
