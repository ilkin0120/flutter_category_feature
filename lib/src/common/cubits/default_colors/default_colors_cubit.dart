import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../usecases/get_default_colors_usecase.dart';

part 'default_colors_state.dart';

class DefaultColorsCubit extends Cubit<DefaultColorsState> {
  DefaultColorsCubit({
    required GetDefaultColorsUseCase getDefaultColorsUseCase,
  })  : _getDefaultColorsUseCase = getDefaultColorsUseCase,
        super(const DefaultColorsState(selectedColor: Colors.orange));

  final GetDefaultColorsUseCase _getDefaultColorsUseCase;

  List<Color> getDefaultColors() {
    return _getDefaultColorsUseCase(6, 10);
  }

  void setColor(Color value) {
    emit(DefaultColorsState(selectedColor: value));
  }
}
