import 'package:flutter/material.dart';
import 'package:frisky_card/view/card_widget.dart';
import 'package:frisky_card/view/celebration_widget.dart';

class GameLogic {
  List<CardData> cards = [
    CardData(color: Colors.red, shape: Icons.circle),
    CardData(color: Colors.green, shape: Icons.square),
    CardData(color: Colors.blue, shape: Icons.star),
    CardData(color: Colors.orange, shape: Icons.car_crash),
    CardData(color: Colors.purple, shape: Icons.diamond),
    CardData(color: Colors.yellow, shape: Icons.hexagon),
  ];

  List<CardData> playerTwoCards = [
    CardData(color: Colors.red, shape: Icons.circle),
    CardData(color: Colors.green, shape: Icons.square),
    CardData(color: Colors.blue, shape: Icons.star),
    CardData(color: Colors.orange, shape: Icons.car_crash),
    CardData(color: Colors.purple, shape: Icons.diamond),
    CardData(color: Colors.yellow, shape: Icons.hexagon),
  ];


  List<CardData> dustbinCards = [];

  void dropCardInDustbin(CardData card) {
    cards.remove(card);
    dustbinCards.add(card);
  }


}
