import 'package:flutter_category_feature/src/features/categories/data/models/category/category_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/categories/data/models/subcategory/subcategory_model.dart';

Future<void> setupHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(SubcategoryModelAdapter());
}
