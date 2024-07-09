import 'package:flutter/material.dart';

class CardData {
  final Color color;
  final IconData shape;
  CardData({required this.color, required this.shape});
}

class CardWidget extends StatelessWidget {
  final CardData card;
  final bool? inDragTarget;

  const CardWidget({super.key, required this.card, this.inDragTarget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Icon(
          card.shape,
          size: inDragTarget??false ? 200 : 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
