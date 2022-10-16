import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/models/cart_item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/payment_dialog.dart';
import 'package:kitanda_app/app/src/pages/orders/components/order_status_widgtes.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

class OrderTile extends StatelessWidget {
  final OrdersModel order;
  OrderTile({Key? key, required this.order}) : super(key: key);

  final UtilsService utilsService = UtilsService();

  @override
  Widget build(BuildContext context) {
    var total = order.cartTotalPrice(order.items);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
        //Responsavel por tirar o efeito da morda do ExpansionTile
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: order.status == 'pending_payment',
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
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,

          //Corpo do Expansion
          children: [
            //Inicio

            IntrinsicHeight(
              //Descrição pedido
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
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
                  ),

                  //Divisão
                  VerticalDivider(
                    width: 6,
                    thickness: 2,
                    color: Colors.grey.shade400,
                  ),

                  //Status
                  Expanded(
                    flex: 2,
                    child: OrderStatusWidgtes(
                      status: order.status,
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                    ),
                  ),
                ],
              ),
            ),
            //Fim

            //total

            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Total:',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    //modificar esta linha

                    text: '${utilsService.formatNumberCurrency(total)}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            //botão pagamento

            Visibility(
              visible: order.status == 'pending_payment',
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return PaymentDialog(order: order);
                        });
                  },
                  icon: const Icon(
                    Icons.pix_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Ver QR code Pix',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
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
