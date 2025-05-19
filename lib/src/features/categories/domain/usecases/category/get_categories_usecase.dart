import 'package:flutter/material.dart';

import '../../../../../common/constants/default_constants.dart';
import '../../../../../common/constants/transaction_types.dart';
import '../../entities/category/category_entity.dart';
import '../../repositories/category_repository_base.dart';

class GetCategoriesUseCase {
  final CategoryRepositoryBase _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<CategoryEntity>> call() async {
    final categories = await _repository.getCategories();

    if (categories.isEmpty) {
      final defaultCategories = _createDefaultCategories();
      await _repository.saveCategories(defaultCategories);
      return defaultCategories;
    }
    return categories;
  }

  List<CategoryEntity> _createDefaultCategories() {
    if (DefaultConstants.isTestMode) {
      return _createMassiveTestCategories();
    } else {
      return [
        ..._createDefaultExpenseCategories(),
        ..._createDefaultIncomeCategories(),
      ];
    }
  }
  List<CategoryEntity> _createMassiveTestCategories() {
    final List<CategoryEntity> testCategories = [];

    for (int i = 0; i < 50; i++) {
      testCategories.add(
        CategoryEntity.create(
          name: 'Тест расход №$i',
          iconData: Icons.shopping_cart,
          color: Colors.redAccent,
          type: TransactionType.expense,
          order: i,
        ),
      );
    }

    for (int i = 0; i < 50; i++) {
      testCategories.add(
        CategoryEntity.create(
          name: 'Тест доход №$i',
          iconData: Icons.attach_money,
          color: Colors.greenAccent,
          type: TransactionType.income,
          order: i,
        ),
      );
    }

    return testCategories;
  }
  List<CategoryEntity> _createDefaultExpenseCategories() {
    return [
      CategoryEntity.create(
          name: 'Шопинг',
          iconData: Icons.shopping_cart,
          color: Colors.blue,
          type: TransactionType.expense,
          order: 0),
      CategoryEntity.create(
          name: 'Дом',
          iconData: Icons.house_outlined,
          color: Colors.orange,
          type: TransactionType.expense,
          order: 1),
      CategoryEntity.create(
          name: 'Путешествие',
          iconData: Icons.airplanemode_on_outlined,
          color: Colors.greenAccent,
          type: TransactionType.expense,
          order: 2),
      CategoryEntity.create(
          name: 'Подарки',
          iconData: Icons.card_giftcard_outlined,
          color: Colors.red,
          type: TransactionType.expense,
          order: 3),
      CategoryEntity.create(
          name: 'Здоровье',
          iconData: Icons.health_and_safety,
          color: Colors.green,
          type: TransactionType.expense,
          order: 4),
    ];
  }

  List<CategoryEntity> _createDefaultIncomeCategories() {
    return [
      CategoryEntity.create(
          name: 'Зарплата',
          iconData: Icons.attach_money,
          color: Colors.green,
          type: TransactionType.income,
          order: 0),
    ];
  }
}
