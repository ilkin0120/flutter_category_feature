import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../../../../common/converters/color_converter.dart';
import '../../../../../common/hive/hive_type_ids.dart';
import '../../../domain/entities/category/category_entity.dart';

part 'category_model.g.dart';

@HiveType(typeId: HiveTypeIds.category)
@JsonSerializable()
class CategoryModel {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int iconData;

  @HiveField(3)
  final int color;

  @HiveField(4)
  final int type;

  @HiveField(5)
  final int order;

  CategoryModel({
    required this.key,
    required this.name,
    required this.iconData,
    required this.color,
    required this.type,
    required this.order,
  });

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      key: entity.key,
      name: entity.name,
      iconData: entity.iconData.codePoint,
      color: const ColorConverter().toJson(entity.color),
      type: entity.type,
      order: entity.order,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity.create(
      key: key,
      name: name,
      iconData: IconData(iconData, fontFamily: 'MaterialIcons'),
      color: Color(color),
      type: type,
      order: order,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
