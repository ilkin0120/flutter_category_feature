import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'more_button.dart';
import 'icon_tile.dart';

class IconGridSelector<C extends Cubit<S>, S> extends StatelessWidget {
  final C bloc;
  final List<IconData> icons;
  final Color Function(S state) colorSelector;
  final IconData Function(S state) selectedIconSelector;
  final Function(IconData) onIconSelected;
  final VoidCallback onMorePressed;
  final double aspectRatio;
  final int crossAxisCount;

  const IconGridSelector({
    super.key,
    required this.bloc,
    required this.icons,
    required this.colorSelector,
    required this.selectedIconSelector,
    required this.onIconSelected,
    required this.onMorePressed,
    this.aspectRatio = 1.2,
    this.crossAxisCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: icons.length + 1, // +1 для кнопки "Еще"
        itemBuilder: (context, index) {
          if (index == icons.length) {
            return MoreButton(onTap: onMorePressed);
          }

          return BlocBuilder<C, S>(
            bloc: bloc,
            buildWhen: (old, current) =>
                colorSelector(old) != colorSelector(current) ||
                selectedIconSelector(old) != selectedIconSelector(current),
            builder: (context, state) {
              final isSelected = selectedIconSelector(state) == icons[index];
              return GestureDetector(
                onTap: () => onIconSelected(icons[index]),
                child: IconTile(
                  isSelected: isSelected,
                  color: isSelected
                      ? colorSelector(state)
                      : context.color.primaryTextColor,
                  icon: icons[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
