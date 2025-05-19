import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/di/app_dependencies.dart';
import 'package:flutter_category_feature/src/common/hive/hive_setup.dart';
import 'package:flutter_category_feature/src/routes/app_router.dart';
import 'package:flutter_category_feature/src/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupHive();
  await AppDependencies.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      themeMode: ThemeMode.light,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
