import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/icon_tile.dart' show IconTile;

class EditableTitleWithIcon<C extends Cubit<S>, S> extends StatefulWidget {
  final C bloc;
  final TextEditingController textController;
  final String hintText;
  final Function(String) onTextChanged;
  final IconData Function(S state) iconSelector;
  final Color Function(S state) colorSelector;
  final bool enabled;

  const EditableTitleWithIcon({
    super.key,
    required this.bloc,
    required this.textController,
    required this.hintText,
    required this.onTextChanged,
    required this.iconSelector,
    required this.colorSelector,
    this.enabled = true,
  });

  @override
  State<EditableTitleWithIcon<C, S>> createState() =>
      _EditableTitleWithIconState<C, S>();
}

class _EditableTitleWithIconState<C extends Cubit<S>, S>
    extends State<EditableTitleWithIcon<C, S>> {
  late FocusNode _focusNode;

  final ValueNotifier<bool> _focusedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Вместо setState — меняем значение в _focusedNotifier
    _focusNode.addListener(() {
      _focusedNotifier.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _focusedNotifier,
      builder: (context, isFocused, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: widget.enabled ? null : context.color.secondaryColor,
            border: Border.all(
              color:
                  isFocused
                      ? context.color.primaryColor
                      : context.color.secondaryColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // BlocBuilder для иконки
              BlocBuilder<C, S>(
                bloc: widget.bloc,
                buildWhen:
                    (oldState, newState) =>
                        widget.iconSelector(oldState) !=
                            widget.iconSelector(newState) ||
                        widget.colorSelector(oldState) !=
                            widget.colorSelector(newState),
                builder: (context, state) {
                  return IconTile(
                    color: widget.colorSelector(state),
                    isSelected: false,
                    icon: widget.iconSelector(state),
                    size: 45,
                  );
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  hintText: 'Например: Дом',
                  padding: EdgeInsets.zero,
                  enabled: widget.enabled,
                  focus: _focusNode,
                  onChanged: widget.onTextChanged,
                  controller: widget.textController,
                  maxLength: 24,
                  counterText: '',
                  borderVisible: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
