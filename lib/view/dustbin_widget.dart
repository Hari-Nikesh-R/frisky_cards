import 'package:flutter/material.dart';
import 'card_widget.dart';

class DustbinWidget extends StatelessWidget {
  final List<CardData> cards;

  DustbinWidget({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              size: 100,
              color: Colors.red,
            ),
            Text('Drop Here'),
            ...cards.map((card) => CardWidget(card: card)).toList(),
          ],
        ),
      ),
    );
  }
}
