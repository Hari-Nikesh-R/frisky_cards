import 'package:flutter/material.dart';
import 'package:frisky_card/view/card_widget.dart';

class GameLogic {
  List<CardData> player1Cards = [
    CardData(color: Colors.red, shape: Icons.circle),
    CardData(color: Colors.green, shape: Icons.square),
    CardData(color: Colors.blue, shape: Icons.star),
  ];

  List<CardData> player2Cards = [
    CardData(color: Colors.orange, shape: Icons.circle),
    CardData(color: Colors.purple, shape: Icons.star),
    CardData(color: Colors.yellow, shape: Icons.square),
  ];

  List<CardData> dustbinCards = [];
  bool celebrate = false;
  String currentPlayer = 'player1';
  String inactivePlayer = 'player2';

  void dropCardInDustbin(CardData card, String player) {
    if (player == 'player1') {
      player1Cards.remove(card);
    } else if (player == 'player2') {
      player2Cards.remove(card);
    }
    dustbinCards.add(card);
  }

  bool checkForMatch() {
    if (dustbinCards.length % 2 == 0) {
      return dustbinCards[dustbinCards.length - 1].color ==
          dustbinCards[dustbinCards.length - 2].color;
    }
    return false;
  }

  void triggerCelebration() {
    celebrate = true;
    Future.delayed(Duration(seconds: 2), () {
      celebrate = false;
    });
  }
}
