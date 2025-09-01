import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '*********************';
const uri = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

class CoinData {
  Future<dynamic> getExchangeRates(
      {required String from, required String to}) async {
    final response = await http.get(
      Uri.parse('$uri/$from/$to?apikey=$apiKey'),
    );

    if (response.statusCode == 200)
      return jsonDecode(response.body);
    else
      throw Exception('failed to load exhange rate: ${response.statusCode}');
  }
}
