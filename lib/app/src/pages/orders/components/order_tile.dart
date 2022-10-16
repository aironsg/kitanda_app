import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/orders/components/order_status_widgtes.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class OrderTile extends StatelessWidget {
  final OrdersModel order;
  OrderTile({Key? key, required this.order}) : super(key: key);

  final UtilsService utilsService = UtilsService();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
        //Responsavel por tirar o efeito da morda do ExpansionTile
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          //header do Expansion
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pedido: ${order.id}'),
              Text(
                utilsService.formatDateTime(order.createdDateTime),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          //Corpo do Expansion
          children: [
            //Inicio
            SizedBox(
              height: 170,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: order.items.map((orderItem) {
                        //Descrição Pedidos
                        return _OrderItemWidget(
                          utilsService: utilsService,
                          orderItem: orderItem,
                        );
                      }).toList(),
                    ),
                  ),
                  VerticalDivider(
                    width: 6,
                    thickness: 2,
                    color: Colors.grey.shade400,
                  ),
                  Expanded(
                    flex: 2,
                    child: OrderStatusWidgtes(
                      status: order.status,
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                    ),
                  ),
                ],
              ),
            )
            //Fim
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsService,
    required this.orderItem,
  }) : super(key: key);

  final UtilsService utilsService;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          //quantidade e unidade de medida
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          //Nome Item
          Expanded(
              child: Text(
            orderItem.item.itemName,
          )),

          //preço total
          Text(
            utilsService.formatNumberCurrency(orderItem.totalPrice()),
          )
        ],
      ),
    );
  }
}
