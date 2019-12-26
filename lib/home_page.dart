// import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final List currencies;

  HomePage(this.currencies);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (ctx, i) {
                final Map currency = widget.currencies[i];
                final MaterialColor color = _colors[i % _colors.length];
                return _getListItemUI(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency["symbol"][0], style: TextStyle(color: Colors.white),),
      ),
      title: Text(
        currency["name"],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency["percent_change_1h"]),
          isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = TextSpan(
      text: "\$$priceUSD\n",
      style: TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    double.parse(percentageChange) > 0
        ? percentageChangeTextWidget = TextSpan(
            text: percentageChangeText,
            style: TextStyle(color: Colors.green),
          )
        : percentageChangeTextWidget = TextSpan(
            text: percentageChangeText, style: TextStyle(color: Colors.red));

    return RichText(
      text: TextSpan(
        children: [
          priceTextWidget,
          percentageChangeTextWidget,
        ],
      ),
    );
  }
}
