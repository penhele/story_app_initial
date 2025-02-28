import 'package:flutter/material.dart';

import '../model/quote.dart';

class HomeScreen extends StatelessWidget {
  final List<Quote> quotes;
  final Function(String) onTapped;

  const HomeScreen({
    super.key,
    required this.quotes,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
      ),
      body: ListView(
        children: [
          for (var quote in quotes)
            ListTile(
              title: Text(quote.author),
              subtitle: Text(quote.quote),
              isThreeLine: true,
              onTap: () => onTapped(quote.id),
            )
        ],
      ),
    );
  }
}
