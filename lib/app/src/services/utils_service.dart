import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsService {
  final storage = const FlutterSecureStorage();

  //salvar token seguro localmente

  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  // buscar token seguro localmente

  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  //remover token localmente

  Future<void> deleteLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  //Responsavel por Formatar os Valores em R$
  String formatNumberCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_br');
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime.toLocal());
  }

  void showToast({required message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 16.0,
    );
  }

  Uint8List qrFormat(String stringQrCode) {
    final String base64String = stringQrCode.split(',').last;
    return base64Decode(base64String);
  }
}
