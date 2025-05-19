import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../constants/ui_constants.dart';
import '../cubits/default_icons/default_icons_cubit.dart';
import '../widgets/check_button.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/icon_tile.dart';

class AllIconsPage extends StatelessWidget {
  final Color selectedColor;
  final Function(IconData) onClick;

  const AllIconsPage({
    super.key,
    required this.onClick,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultIcons = context.read<DefaultIconsCubit>().getDefaultIcons();

    return Scaffold(
      appBar: DefaultAppBar(
        showBackButton: true,
        title: 'Выбор иконки',
        actions: [
          CheckButton(
            color: context.color.secondaryTextColor,
            onClick: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.defaultHorizontalPadding,
        ),
        children:
            defaultIcons.entries.map((entry) {
              final categoryName = entry.key;
              final icons = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(categoryName, style: context.text.bodyMedium),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: icons.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<DefaultIconsCubit>().setIcon(
                            icons[index],
                          );
                          onClick(icons[index]);
                        },
                        child:
                            BlocBuilder<DefaultIconsCubit, DefaultIconsState>(
                              buildWhen: (old, current) {
                                final isPreviouslySelected =
                                    old.selectedIcon == icons[index];
                                final isCurrentlySelected =
                                    current.selectedIcon == icons[index];
                                return isPreviouslySelected ||
                                    isCurrentlySelected;
                              },
                              builder: (context, state) {
                                bool isSelected =
                                    icons[index] == state.selectedIcon;
                                return IconTile(
                                  color:
                                      isSelected
                                          ? selectedColor
                                          : context.color.primaryTextColor,
                                  isSelected: isSelected,
                                  icon: icons[index],
                                );
                              },
                            ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
      ),
    );
  }
}
