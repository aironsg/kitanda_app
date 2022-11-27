import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/models/orders_model.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';

import '../../config/custom_color.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  final UtilsService utilsService = UtilsService();
  PaymentDialog({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
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
                Image.memory(
                  utilsService.qrFormat(order.qrCodeImage),
                  height: 200,
                  width: 200,
                ),

                //data vencimento
                Text(
                  'Vencimento: ${utilsService.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),

                //total
                Text(
                  'Total: ${utilsService.formatNumberCurrency(order.total)}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //Botão copia e cola
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: CustomColor.customSwatchColor, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    FlutterClipboard.copy(order.copyAndPaste);
                    utilsService.showToast(
                        message: 'Codigo Copiado com Sucesso!');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copy,
                        color: CustomColor.customSwatchColor,
                      ),
                      Text(
                        'Copiar código pix',
                        style: TextStyle(color: CustomColor.customSwatchColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 1,
            right: 5,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close)),
          )
        ],
      ),
    );
  }
}
