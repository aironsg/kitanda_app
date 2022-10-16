import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/models/user_model.dart';

import '../models/item_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/images/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/images/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/images/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/images/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/images/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/images/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

//Lista Itens carrinho
List<CartItemModel> cartItens = [
  CartItemModel(item: apple, quantity: 4),
  CartItemModel(item: guava, quantity: 2),
  CartItemModel(item: papaya, quantity: 1),
  CartItemModel(item: mango, quantity: 2),
  CartItemModel(item: grape, quantity: 2),
  CartItemModel(item: kiwi, quantity: 1),
];

List<String> categories = [
  'Frutas',
  'Verduras',
  'Grãos',
  'Carnes',
  'Temperos',
];

UserModel user = UserModel(
    name: 'Airon',
    email: 'airon@email.com',
    phone: '00 0 0000-0000',
    cpf: '000.000.000-00',
    password: '');

List<OrdersModel> orders = [
  //Pedido 1
  OrdersModel(
    id: 'a5jc4me8',
    createdDateTime: DateTime.parse('2022-10-15 19:35:54.250'),
    overdueDateTime: DateTime.parse('2022-10-20 20:35:54.250'),
    status: 'pending_payment',
    copyAndPaste: 'kbg6j39cm3',
    items: [
      CartItemModel(item: apple, quantity: 2),
      CartItemModel(item: mango, quantity: 3),
      CartItemModel(item: grape, quantity: 5),
    ],
    total: cartTotalPrice(),
  ),

  //Pedido 2
  OrdersModel(
    id: 'a5jcdfd2',
    createdDateTime: DateTime.parse('2022-10-13 19:35:54.250'),
    overdueDateTime: DateTime.parse('2022-10-19 20:35:54.250'),
    status: 'paid',
    copyAndPaste: 'kbg6j39cm3',
    items: [
      CartItemModel(item: apple, quantity: 2),
      CartItemModel(item: grape, quantity: 5),
    ],
    total: cartTotalPrice(),
  ),

  //Pedido 3
  OrdersModel(
    id: 'jch5sm99s',
    createdDateTime: DateTime.parse('2022-10-14 19:35:54.250'),
    overdueDateTime: DateTime.parse('2022-10-14 20:35:54.250'),
    status: 'refunded',
    copyAndPaste: 'lgjii3a9m3',
    items: [
      CartItemModel(item: kiwi, quantity: 15),
    ],
    total: cartTotalPrice(),
  ),
];

double cartTotalPrice() {
  double total = 0;

  for (var item in cartItens) {
    total += item.totalPrice();
  }

  return total;
}
