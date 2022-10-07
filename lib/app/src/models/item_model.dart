class ItemModel {
  String itemName;
  String imgUrl;
  String unit;
  double price;
  String description;

  ItemModel(
      {required this.itemName,
      required this.imgUrl,
      required this.price,
      required this.unit,
      required this.description});
}
