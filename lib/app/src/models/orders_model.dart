// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:kitanda_app/app/src/models/cart_item_model.dart';

part 'part_of_models/orders_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final DateTime? createdDateTime;
  @JsonKey(name: 'due')
  final DateTime overdueDateTime;
  @JsonKey(defaultValue: [])
  final List<CartItemModel> items;
  final String status;
  @JsonKey(name: 'copiaecola')
  final String copyAndPaste;
  final double total;
  final String qrCodeImage;

  OrderModel({
    required this.id,
    this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.qrCodeImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  double cartTotalPrice(List<CartItemModel> items) {
    double total = 0;

    for (var item in items) {
      total += item.totalPrice();
    }

    return total;
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, createdDateTime: $createdDateTime, overdueDateTime: $overdueDateTime, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total, qrCodeImage: $qrCodeImage)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdDateTime == createdDateTime &&
        other.overdueDateTime == overdueDateTime &&
        listEquals(other.items, items) &&
        other.status == status &&
        other.copyAndPaste == copyAndPaste &&
        other.total == total &&
        other.qrCodeImage == qrCodeImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdDateTime.hashCode ^
        overdueDateTime.hashCode ^
        items.hashCode ^
        status.hashCode ^
        copyAndPaste.hashCode ^
        total.hashCode ^
        qrCodeImage.hashCode;
  }
}
