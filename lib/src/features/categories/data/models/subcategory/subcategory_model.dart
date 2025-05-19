import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';


import '../../../../../common/hive/hive_type_ids.dart';
import '../../../domain/entities/subcategory/subcategory_entity.dart';

part 'subcategory_model.g.dart';

@HiveType(typeId: HiveTypeIds.subCategory)
@JsonSerializable()
class SubcategoryModel {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String categoryKey;
  @HiveField(2)
  final String name;

  SubcategoryModel({
    required this.key,
    required this.categoryKey,
    required this.name,
  });

  factory SubcategoryModel.fromEntity(SubcategoryEntity entity) {
    return SubcategoryModel(
      key: entity.key,
      categoryKey: entity.categoryKey,
      name: entity.name,
    );
  }

  SubcategoryEntity toEntity() {
    return SubcategoryEntity(
      key: key,
      categoryKey: categoryKey,
      name: name,
    );
  }

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryModelToJson(this);
}
