import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String to1 = '?';
  String to2 = '?';
  String to3 = '?';
  CoinData coinData = CoinData();
  String? selectedCurrency = currenciesList[0];

  @override
  void initState() {
    super.initState();
    Exhange();
  }

  void Exhange() async {
    try {
      var response1 = await coinData.getExchangeRates(
          from: cryptoList[0], to: selectedCurrency!);
      var response2 = await coinData.getExchangeRates(
          from: cryptoList[1], to: selectedCurrency!);
      var response3 = await coinData.getExchangeRates(
          from: cryptoList[2], to: selectedCurrency!);

      setState(() {
        to1 = (response1['rate'] as num).toStringAsFixed(2);
        to2 = (response2['rate'] as num).toStringAsFixed(2);
        to3 = (response3['rate'] as num).toStringAsFixed(2);
      });
    } catch (e) {
      print('Error fetching rates: $e');
    }
  }

  DropdownButton<String> androidData() {
    List<DropdownMenuItem<String>> list = currenciesList.map((currency) {
      return DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: list,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        Exhange();
      },
    );
  }

  CupertinoPicker getDataISO() {
    List<Widget> text =
        currenciesList.map((currency) => Text(currency)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
        Exhange();
      },
      children: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCard(cryptoList[0], to1),
              buildCard(cryptoList[1], to2),
              buildCard(cryptoList[2], to3),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: /*Platform.isIOS ? getDataISO() :*/ androidData(),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String crypto, String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
