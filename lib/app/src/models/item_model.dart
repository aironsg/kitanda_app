// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:kitanda_app/app/src/models/category_model.dart';

part 'part_of_models/item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;
  @JsonKey(name: 'title')
  String itemName;
  @JsonKey(name: 'picture')
  String imgUrl;
  String unit;
  double price;
  String description;
  List<CategoryModel>? categorys;

  ItemModel(
      {this.id = '',
      required this.itemName,
      required this.imgUrl,
      required this.price,
      required this.unit,
      required this.description,
      this.categorys});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description, categorys: $categorys)';
  }
}
