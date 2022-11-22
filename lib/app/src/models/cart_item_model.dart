// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:kitanda_app/app/src/models/item_model.dart';

part 'part_of_models/cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  String id;

  @JsonKey(name: 'product')
  ItemModel item;

  int quantity;

  CartItemModel({
    required this.id,
    required this.item,
    required this.quantity,
  });

  double totalPrice() => item.price * quantity;
  static double totalPriceCart(double total) => total;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  @override
  String toString() =>
      'CartItemModel(id: $id, item: $item, quantity: $quantity)';
}
