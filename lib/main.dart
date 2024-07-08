import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frisky_card/view/card_widget.dart';
import 'package:frisky_card/view/celebration_widget.dart';
import 'package:frisky_card/view/dustbin_widget.dart';

import 'game_logic.dart';

void main() {
  runApp(CardMatchGame());
}

class CardMatchGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Match Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameLogic _gameLogic = GameLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Match Game'),
      ),
      body: Column(
        children: [
          Expanded(
            child: DragTarget<CardData>(
              builder: (context, candidateData, rejectedData) {
                return DustbinWidget(
                  cards: _gameLogic.dustbinCards,
                );
              },
              onAcceptWithDetails: (card) {
                _gameLogic.dropCardInDustbin(card.data);
                setState(() {
                  if (_gameLogic.dustbinCards.length == 2 &&
                      _gameLogic.dustbinCards.first.shape ==
                          _gameLogic.dustbinCards.last.shape &&
                      _gameLogic.dustbinCards.first.color ==
                          _gameLogic.dustbinCards.last.color) {
                    _gameLogic.dustbinCards = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CelebrationWidget()));
                  }
                  else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CelebrationWidget()));

                  }
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _gameLogic.cards.length,
              itemBuilder: (context, index) {
                final card = _gameLogic.cards[index];
                return Draggable(
                  data: card,
                  child: CardWidget(card: card),
                  feedback: CardWidget(card: card),
                  childWhenDragging: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
