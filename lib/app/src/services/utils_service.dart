import 'package:intl/intl.dart';

class UtilsService {
  //Responsavel por Formatar os Valores em R$
  String formatNumberCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_br');
    return numberFormat.format(price);
  }
}
