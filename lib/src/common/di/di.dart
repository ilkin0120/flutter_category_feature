import 'package:get_it/get_it.dart';

import '../cubits/default_colors/default_colors_cubit.dart';
import '../cubits/default_icons/default_icons_cubit.dart';
import '../usecases/get_default_colors_usecase.dart';
import '../usecases/get_default_icons_usecase.dart';

final getItGlobal = GetIt.instance;

Future<void> setupGlobalDependencies() async {
  getItGlobal.registerLazySingleton<GetDefaultIconsUseCase>(
    () => GetDefaultIconsUseCase(),
  );
  getItGlobal.registerLazySingleton<GetDefaultColorsUseCase>(
    () => GetDefaultColorsUseCase(),
  );
  getItGlobal.registerFactory<DefaultColorsCubit>(
    () => DefaultColorsCubit(
      getDefaultColorsUseCase: getItGlobal<GetDefaultColorsUseCase>(),
    ),
  );
  getItGlobal.registerFactory<DefaultIconsCubit>(
    () => DefaultIconsCubit(
      getDefaultIconsUseCase: getItGlobal<GetDefaultIconsUseCase>(),
    ),
  );
}
