import 'package:flutter/material.dart';

class CardData {
  final Color color;
  final IconData shape;
  CardData({required this.color, required this.shape});
}

class CardWidget extends StatelessWidget {
  final CardData card;

  CardWidget({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Icon(
          card.shape,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
