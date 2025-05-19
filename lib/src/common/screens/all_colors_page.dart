import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../constants/ui_constants.dart';
import '../cubits/default_colors/default_colors_cubit.dart';
import '../widgets/check_button.dart';
import '../widgets/default_app_bar.dart';

class AllColorsPage extends StatelessWidget {
  final Function(Color) onClick;
  final bool isCircle;

  const AllColorsPage({
    super.key,
    required this.onClick,
    required this.isCircle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColors = context.read<DefaultColorsCubit>().getDefaultColors();
    return Scaffold(
      appBar: DefaultAppBar(
        showBackButton: true,
        title: 'Выбор цвета',
        actions: [
          CheckButton(
            color: context.color.primaryColor,
            onClick: () => Navigator.pop(context),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.defaultHorizontalPadding,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: defaultColors.length,
        itemBuilder: (context, index) {
          final color = defaultColors[index];
          return GestureDetector(
            onTap: () {
              context.read<DefaultColorsCubit>().setColor(color);
              onClick(color);
            },
            child: BlocBuilder<DefaultColorsCubit, DefaultColorsState>(
              buildWhen: (old, current) {
                final isPreviouslySelected = old.selectedColor == color;
                final isCurrentlySelected = current.selectedColor == color;
                return isPreviouslySelected || isCurrentlySelected;
              },
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        isCircle
                            ? BorderRadius.circular(90)
                            : UIConstants.defaultBorderRadius,
                    border: Border.all(
                      color: context.color.secondaryColor,
                      width: state.selectedColor == color ? 4 : 0,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
