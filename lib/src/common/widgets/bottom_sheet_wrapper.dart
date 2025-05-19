import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class BottomSheetWrapper extends StatelessWidget {
  final List<Widget> children;
  final double? height;
  final EdgeInsets? padding;
  final bool showDragItem;

  const BottomSheetWrapper({
    super.key,
    required this.children,
    this.height,
    this.padding,
    this.showDragItem = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: height ?? MediaQuery.of(context).size.height * 0.65,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: context.color.backgroundColor,
      ),
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            if (showDragItem) ...[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.color.secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: 24,
                  height: 4,
                ),
              ),
              const SizedBox(height: 16),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}
