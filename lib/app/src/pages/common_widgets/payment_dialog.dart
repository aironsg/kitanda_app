import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/models/item_model.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrdersModel order;
  final UtilsService utilsService = UtilsService();
  PaymentDialog({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //titulo
          const Text(
            'Pagamento com Pix',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          //QR code
          QrImage(
            data: "${order.copyAndPaste}",
            version: QrVersions.auto,
            size: 200.0,
          ),

          //data vencimento
          Text(
            '${utilsService.formatDateTime(order.overdueDateTime)}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),

          //total
          Text(
            '${utilsService.formatNumberCurrency(order.cartTotalPrice(order.items))}',
            style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),

          //Botão copia e cola
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: CustomColor.customSwatchColor, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.copy,
                    color: CustomColor.customSwatchColor,
                  ),
                  Text(
                    'Copiar QR code',
                    style: TextStyle(color: CustomColor.customSwatchColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
