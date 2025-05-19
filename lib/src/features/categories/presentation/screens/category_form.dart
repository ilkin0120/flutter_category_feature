import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../../../../common/constants/ui_constants.dart';

import '../../../../common/cubits/default_colors/default_colors_cubit.dart';
import '../../../../common/cubits/default_icons/default_icons_cubit.dart';
import '../../../../common/widgets/check_button.dart';
import '../../../../common/widgets/color_picker_small.dart';
import '../../../../common/widgets/custom_gap.dart';
import '../../../../common/widgets/custom_radio_button.dart';
import '../../../../common/widgets/default_app_bar.dart';
import '../../../../common/widgets/icon_grid_selector.dart';
import '../../../../common/widgets/label_text.dart';
import '../../../../routes/route_names.dart';
import '../../domain/entities/category/category_entity.dart';
import '../widgets/editable_title_with_icon.dart';
import '../../../../themes/theme.dart';
import '../cubits/categories/category_cubit.dart';
import '../cubits/edit_category/edit_category_cubit.dart';

import '../../../../common/constants/transaction_types.dart';

class CategoryFormPage extends StatefulWidget {
  final CategoryEntity? categoryToEdit;
  final int categoryType;

  const CategoryFormPage({
    super.key,
    required this.categoryType,
    this.categoryToEdit,
  });

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initCategoryState();
  }

  void _initCategoryState() {
    final editCubit = context.read<EditCategoryCubit>();

    if (widget.categoryToEdit != null) {
      _categoryNameController.text = widget.categoryToEdit!.name;
      editCubit.setEditData(widget.categoryToEdit!);
    } else {
      editCubit.resetState();
    }
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultColors = context.read<DefaultColorsCubit>().getDefaultColors();
    final defaultIcons = context.read<DefaultIconsCubit>().getDefaultIcons();
    final colors = context.color;
    final text = context.text;

    return Scaffold(
      appBar: DefaultAppBar(
        title:
            widget.categoryToEdit != null
                ? "Изменить категорию"
                : 'Добавить категорию',
        actions: [_buildCheckButton(colors)],
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.defaultHorizontalPadding,
        ),
        child: ListView(
          children: [
            EditableTitleWithIcon<EditCategoryCubit, EditCategoryState>(
              bloc: context.read<EditCategoryCubit>(),
              textController: _categoryNameController,
              hintText: "Введите название категории",
              onTextChanged:
                  (value) => context.read<EditCategoryCubit>().setName(value),
              iconSelector: (state) => state.entity.iconData,
              colorSelector: (state) => state.entity.color,
            ),
            const SizedBox(height: 24),
            _buildTypeSelector(text),
            const SizedBox(height: 24),
            const LabelText(text: 'Выберите иконку:'),
            const SizedBox(height: 8),
            IconGridSelector<EditCategoryCubit, EditCategoryState>(
              bloc: context.read<EditCategoryCubit>(),
              icons: defaultIcons.values.first.take(16).toList(),
              colorSelector: (state) => state.entity.color,
              selectedIconSelector: (state) => state.entity.iconData,
              onIconSelected:
                  (icon) => context.read<EditCategoryCubit>().setIcon(icon),
              onMorePressed:
                  () => Navigator.pushNamed(
                    context,
                    allIconsRoute,
                    arguments: {
                      'selectedColor':
                          context.read<EditCategoryCubit>().state.entity.color,
                      'selectedIcon':
                          context
                              .read<EditCategoryCubit>()
                              .state
                              .entity
                              .iconData,
                      'onClick':
                          (icon) =>
                              context.read<EditCategoryCubit>().setIcon(icon),
                    },
                  ),
            ),
            const SizedBox(height: 24),
            const LabelText(text: 'Выберите цвет:'),
            const SizedBox(height: 8),
            BlocSelector<EditCategoryCubit, EditCategoryState, Color>(
              selector: (state) => state.entity.color,
              builder: (context, selectedColor) {
                return ColorPickerSmall(
                  selectedColor: selectedColor,
                  colors: defaultColors,
                  onColorSelected:
                      (color) =>
                          context.read<EditCategoryCubit>().setColor(color),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckButton(ThemeColors colors) {
    return BlocSelector<EditCategoryCubit, EditCategoryState, String>(
      selector: (state) => state.entity.name,
      builder: (context, name) {
        return CheckButton(
          color: name.isNotEmpty ? colors.primaryColor : colors.secondaryColor,
          onClick: () {
            if (name.isNotEmpty || _categoryNameController.text.isNotEmpty) {
              final category = context
                  .read<EditCategoryCubit>()
                  .buildCategoryEntity(key: widget.categoryToEdit?.key);
              if (widget.categoryToEdit != null) {
                context.read<CategoriesCubit>().updateCategory(category);
              } else {
                context.read<CategoriesCubit>().addCategory(category);
              }
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  Widget _buildTypeSelector(ThemeTextStyles text) {
    final editCubit = context.read<EditCategoryCubit>();

    return BlocSelector<EditCategoryCubit, EditCategoryState, int>(
      selector: (state) => state.entity.type,
      builder: (context, selectedType) {
        return Row(
          children: [
            SizedBox(
              width: 100,
              child: CustomRadioButton(
                title: 'Расходы',
                onTap: (value) => editCubit.setCategoryType(value),
                value: TransactionType.expense,
                isActive: selectedType == TransactionType.expense,
                titleTextStyle: text.bodyMedium,
              ),
            ),
            const HorizontalGap(32),
            SizedBox(
              width: 100,
              child: CustomRadioButton(
                title: 'Доходы',
                onTap: (value) => editCubit.setCategoryType(value),
                value: TransactionType.income,
                isActive: selectedType == TransactionType.income,
                titleTextStyle: text.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
