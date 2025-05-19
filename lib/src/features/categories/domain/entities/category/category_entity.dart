import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/constants/default_constants.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const CategoryEntity._();

  /// Primary constructor for CategoryEntity
  ///
  /// @param key Unique identifier for the category
  /// @param name Display name of the category
  /// @param iconData Icon to represent the category visually
  /// @param color Color associated with the category
  /// @param type Category type (income/expense)
  /// @param isBeingDeleted Flag used for animated deletion - when true, the UI can show delete animation before actual removal
  /// @param order Position of the category in the UI list (for custom sorting)
  factory CategoryEntity({
    @Default('') String key,
    required String name,
    required IconData iconData,
    required Color color,
    required int type,
    @Default(false) bool isBeingDeleted,
    required int order,
  }) = _CategoryEntity;

  /// Named constructor for creating a new CategoryEntity
  ///
  /// Generates a new UUID if key is not provided
  factory CategoryEntity.create({
    String? key,
    required String name,
    required IconData iconData,
    required Color color,
    required int type,
    bool isBeingDeleted = false,
    required int order,
  }) =>
      CategoryEntity(
        key: key ?? const Uuid().v4(),
        name: name,
        iconData: iconData,
        color: color,
        type: type,
        isBeingDeleted: isBeingDeleted,
        order: order,
      );

  /// Creates a default "Unknown" category when a proper category can't be determined
  ///
  /// Used as a fallback option for orphaned transactions or system defaults
  factory CategoryEntity.unknown({
    required int type,
  }) =>
      CategoryEntity(
        key: DefaultConstants.unknownCategoryId,
        name: 'Неизвестно',
        iconData: Icons.question_mark_outlined,
        color: Colors.grey,
        type: type,
        order: 0,
      );
}
