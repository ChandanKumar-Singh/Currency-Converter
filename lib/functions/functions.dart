import 'dart:convert';

import 'package:currency_converter/functions/ratesModel.dart';
import 'package:currency_converter/string.dart';
import 'package:http/http.dart' as http;

Map<String, String> allCurrenciesFromJson(String str) =>
    Map.from(jsonDecode(str))
        .map((key, value) => MapEntry<String, String>(key, value));

String allCurrenciesToJson(Map<String, String> data) => jsonEncode(
    Map.from(data).map((key, value) => MapEntry<String, dynamic>(key, value)));

Future<RatesModel> fetchrates() async {
  var responce = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=' + key));
  final result = ratesModelFromJson(responce.body);
  return result;
}

Future fetchCurrencies() async {
  var responce = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=' + key));
  final allCurrencies = allCurrenciesFromJson(responce.body);
  return allCurrencies;
}
