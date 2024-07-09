import 'package:flutter/material.dart';
import 'card_widget.dart';

class DustbinWidget extends StatelessWidget {
  final List<CardData> cards;
  final bool isFull;

  const DustbinWidget({super.key, required this.cards, required this.isFull, });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.delete,
              size: 100,
              color: Colors.red,
            ),
            isFull ? const Text("Choose the match") : const Text('Drop Here'),
            ...cards.map((card) => CardWidget(card: card)),
          ],
        ),
      ),
    ));
  }
}
