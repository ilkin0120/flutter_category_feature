import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../usecases/get_default_icons_usecase.dart';

part 'default_icons_state.dart';

class DefaultIconsCubit extends Cubit<DefaultIconsState> {
  DefaultIconsCubit({
    required GetDefaultIconsUseCase getDefaultIconsUseCase,
  })  : _getDefaultIconsUseCase = getDefaultIconsUseCase,
        super(const DefaultIconsState(selectedIcon: Icons.map));
  final GetDefaultIconsUseCase _getDefaultIconsUseCase;

  Map<String, List<IconData>> getDefaultIcons() {
    return _getDefaultIconsUseCase();
  }

  void setIcon(IconData value) {
    emit(DefaultIconsState(selectedIcon: value));
  }
}
