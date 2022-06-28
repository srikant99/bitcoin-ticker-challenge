import 'package:http/http.dart' as http;
import 'dart:convert';

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '0422305C-D53A-40A9-8A9A-9BBEA89F481B';

class CoinData {

  Future getCoinData({String currency}) async {

    Map<String,String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      http.Response response = await http.get('$coinAPIURL/$crypto/$currency?apikey=$apiKey');
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        double rate = decodedData['rate'];
        cryptoPrices[crypto] = rate.toStringAsFixed(0);
      }
      else {
        print(response.statusCode);
        throw 'Problem with get request';
      }

      return cryptoPrices;
    }

  }
}
