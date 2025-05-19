import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'subcategory_entity.freezed.dart';

@freezed
abstract class SubcategoryEntity with _$SubcategoryEntity {
  const SubcategoryEntity._();

  /// Internal factory constructor.
  /// Use [SubcategoryEntity.create] when creating a new subcategory instance.
  factory SubcategoryEntity({
    required String key,
    required String categoryKey,
    required String name,
    @Default(false) bool isBeingDeleted,
  }) = _SubcategoryEntity;

  /// Creates a new [SubcategoryEntity] with a unique key if none is provided.
  factory SubcategoryEntity.create({
    String? key,
    required String categoryKey,
    required String name,
    bool isBeingDeleted = false,
  }) =>
      SubcategoryEntity(
        key: key ?? const Uuid().v4(),
        categoryKey: categoryKey,
        name: name,
        isBeingDeleted: isBeingDeleted,
      );
}
