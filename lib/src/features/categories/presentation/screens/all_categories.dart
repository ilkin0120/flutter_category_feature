import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/default_app_bar.dart';
import '../../../../routes/route_names.dart';
import '../../../categories/presentation/cubits/categories/category_cubit.dart';
import '../widgets/category_item.dart';

class AllCategories extends StatelessWidget {
  final Function(String) onCategoryClick;
  final String? selectedCategoryKey;
  final int categoryType;

  const AllCategories({
    super.key,
    required this.categoryType,
    required this.onCategoryClick,
    this.selectedCategoryKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        showBackButton: true,
        title: 'Выберите',
        actions: [
          CustomButton(
            onPressed:
                () => Navigator.pushNamed(
                  context,
                  categoryFormRoute,
                  arguments: {"tabIndex": categoryType},
                ),
            //,
            icon: Icon(Icons.add, color: context.color.primaryColor),
            width: 24,
            height: 24,
          ),
        ],
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final categories =
              state.categories
                  .where((category) => category.type == categoryType)
                  .toList();
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onCategoryClick(categories[index].key);
                  Navigator.pop(context);
                },
                child: CategoryItem(
                  isSelected: selectedCategoryKey == categories[index].key,
                  categoryEntity: categories[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
