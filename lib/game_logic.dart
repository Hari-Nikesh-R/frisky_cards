import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frisky_card/view/card_widget.dart';

class GameLogic {
  List<CardData> player1Cards = [
    CardData(color: Colors.amberAccent, shape: Icons.account_balance),
    CardData(color: Colors.red, shape: Icons.circle),
    CardData(color: Colors.green, shape: Icons.square),
    CardData(color: Colors.blue, shape: Icons.star),
    CardData(color: Colors.pink, shape: Icons.rectangle),
    CardData(color: Colors.purple, shape: Icons.ac_unit),
  ];

  List<CardData> player2Cards = [
    CardData(color: Colors.red, shape: Icons.circle),
    CardData(color: Colors.pink, shape: Icons.rectangle),
    CardData(color: Colors.purple, shape: Icons.ac_unit),
    CardData(color: Colors.amberAccent, shape: Icons.account_balance),
    CardData(color: Colors.blue, shape: Icons.star),
    CardData(color: Colors.green, shape: Icons.square),
  ];

  void refreshCards() {
    player1Cards = [
      CardData(color: Colors.amberAccent, shape: Icons.account_balance),
      CardData(color: Colors.red, shape: Icons.circle),
      CardData(color: Colors.green, shape: Icons.square),
      CardData(color: Colors.blue, shape: Icons.star),
      CardData(color: Colors.pink, shape: Icons.rectangle),
      CardData(color: Colors.purple, shape: Icons.ac_unit),
    ];
    player2Cards = [
      CardData(color: Colors.red, shape: Icons.circle),
      CardData(color: Colors.pink, shape: Icons.rectangle),
      CardData(color: Colors.purple, shape: Icons.ac_unit),
      CardData(color: Colors.amberAccent, shape: Icons.account_balance),
      CardData(color: Colors.blue, shape: Icons.star),
      CardData(color: Colors.green, shape: Icons.square),
    ];
    shuffleCards();
  }

  List<CardData> dustbinCards = [];
  bool celebrate = false;
  bool resetGameFlag = false;
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

  void shuffleCards() {
    player1Cards.shuffle();
    player2Cards.shuffle();
  }

  bool checkForMatch() {
    if (dustbinCards.length % 2 == 0) {
      return dustbinCards[dustbinCards.length - 1].color ==
          dustbinCards[dustbinCards.length - 2].color;
    }
    return false;
  }

  bool checkForParity() {
    return (dustbinCards.length % 2 == 0);
  }

  void _endGame() {
    refreshCards();
    dustbinCards.clear();
  }

  void triggeredBetterLuckCelebration() {
    // for showing better luck animation
    resetGameFlag = true;
    dustbinCards = [];
    showFailureToast();
    refreshCards();
    Future.delayed(const Duration(seconds: 2), () {
      resetGameFlag = false;
    });
  }

  void showCelebratoryToast() {
    Fluttertoast.showToast(
      msg: "Congratulations!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 24.0,
    );
  }

  void showFailureToast() {
    Fluttertoast.showToast(
      msg: "Please select correct one!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 24.0,
    );
  }

  void triggerCelebration() {
    celebrate = true;
    dustbinCards = [];
    showCelebratoryToast();
    Future.delayed(const Duration(seconds: 4), () {
      celebrate = false;
    });
    if (player2Cards.isEmpty && player1Cards.isEmpty) {
      _endGame();
    }
  }
}
