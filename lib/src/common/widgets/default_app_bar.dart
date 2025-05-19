import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';
import 'custom_gap.dart';
import 'default_back_button.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackClick;
  final bool showBackButton;
  final String? title;
  final Widget? titleWidget;
  final List<Widget> actions;
  final Widget? customLeading;
  final double height;

  const DefaultAppBar(
      {super.key,
      this.onBackClick,
      required this.showBackButton,
      this.title,
      this.height = 100,
      this.titleWidget,
      this.customLeading,
      this.actions = const []});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(0, 0),
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: UIConstants.defaultHorizontalPadding, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _showLeading(context),
                const HorizontalGap(16),
                if (titleWidget != null) titleWidget!,
                if (title != null && titleWidget == null)
                  Text(
                    title!,
                    style: context.text.bodyLarge
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                if (actions.isNotEmpty)
                  Expanded(
                    child: Row(
                      children: [const Spacer(), ...actions],
                    ),
                  )
              ],
            )),
      ),
    );
  }

  Widget _showLeading(BuildContext context) {
    if (customLeading != null) {
      return customLeading!;
    } else if (showBackButton) {
      return DefaultBackButton(
        onBackClick: () => Navigator.pop(context),
      );
    } else {
      return Container();
    }
  }
}
