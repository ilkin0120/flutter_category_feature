import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/routes/route_names.dart';

import '../../../categories/di/di.dart';
import '../../../categories/presentation/cubits/categories/category_cubit.dart';
import '../../../categories/presentation/cubits/subcategories/subcategories_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.wait([
      getItCategory<CategoriesCubit>().loadCategories(),
      getItCategory<SubcategoriesCubit>().loadAllSubcategories(),
    ]);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, categoriesRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('SplashScreen')));
  }
}
