import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../constants/ui_constants.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode? focus;
  final bool readOnly;
  final TextEditingController controller;
  final String? hintText;
  final Function(String) onChanged;
  final EdgeInsets? padding;
  final bool borderVisible;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool enabled;
  final int? maxLength;
  final String? counterText;
  final bool autoFocus;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final ScrollController? scrollController;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.padding,
      required this.controller,
      required this.onChanged,
      this.readOnly = false,
      this.inputFormatters,
      this.keyboardType,
      this.textAlign = TextAlign.left,
      this.focus,
      this.maxLength,
      this.scrollController,
      this.autoFocus = false,
      this.enabled = true,
      this.counterText,
      this.textStyle,
      this.borderVisible = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late ValueNotifier<bool> _isFocusedNotifier;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focus ?? FocusNode();
    _isFocusedNotifier = ValueNotifier(_focusNode.hasFocus);
    _focusNode.addListener(_handleFocusChange);
    if (widget.autoFocus) _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _isFocusedNotifier.dispose();
    if (widget.focus == null) _focusNode.dispose();

    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      _isFocusedNotifier.value = _focusNode.hasFocus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFocusedNotifier,
      builder: (context, isFocused, child) {
        return Container(
          padding: widget.padding ?? UIConstants.textFieldPadding,
          decoration: BoxDecoration(
            borderRadius: UIConstants.defaultBorderRadius,
            border: widget.borderVisible
                ? UIConstants.getDefaultBorder(context, isFocused)
                : null,
          ),
          child: child,
        );
      },
      child: TextField(
        scrollController: widget.scrollController,
        autofocus: widget.autoFocus,
        maxLength: widget.maxLength,
        focusNode: _focusNode,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        textAlign: widget.textAlign,
        readOnly: widget.readOnly,
        controller: widget.controller,
        cursorColor: context.color.primaryColor,
        style: widget.textStyle ??
            context.text.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters ??
            (widget.keyboardType ==
                    const TextInputType.numberWithOptions(decimal: true)
                ? []
                : null),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          counterText: widget.counterText,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: UIConstants.getDefaultHintStyle(context),
          isDense: true,
        ),
      ),
    );
  }
}
