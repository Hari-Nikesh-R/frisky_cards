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

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final GameLogic _gameLogic = GameLogic();
  late AnimationController _player1Controller;
  late AnimationController _player2Controller;

  @override
  void initState() {
    super.initState();
    _player1Controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _player2Controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _player1Controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  void _handleCardDropped(CardData card, String player) {
    _gameLogic.dropCardInDustbin(card, player);
    setState(() {
      if (_gameLogic.checkForMatch()) {
        _gameLogic.triggerCelebration();
      }
    });
  }

  void _switchPlayer() {
    if (_gameLogic.currentPlayer == 'player1') {
      _player1Controller.stop();
      _player2Controller.repeat(reverse: true);
      _gameLogic.currentPlayer = 'player2';
    } else {
      _player2Controller.stop();
      _player1Controller.repeat(reverse: true);
      _gameLogic.currentPlayer = 'player1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Match Game'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: DragTarget<CardData>(
                  builder: (context, candidateData, rejectedData) {
                    return DustbinWidget(
                      cards: _gameLogic.dustbinCards,
                    );
                  },
                  onAccept: (card) {
                    _handleCardDropped(card, _gameLogic.currentPlayer);
                    _switchPlayer();
                  },
                ),
              ),
              _gameLogic.currentPlayer == 'player1' ?
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: _gameLogic.player1Cards.length,
                  itemBuilder: (context, index) {
                    final card = _gameLogic.player1Cards[index];
                    return ScaleTransition(
                      scale:
                          _player1Controller.drive(Tween(begin: 1.0, end: 1.1)),
                      child: Draggable<CardData>(
                        data: card,
                        child: CardWidget(card: card),
                        feedback: CardWidget(card: card),
                        childWhenDragging: Container(),
                      ),
                    );
                  },
                ),
              ) :
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: _gameLogic.player2Cards.length,
                  itemBuilder: (context, index) {
                    final card = _gameLogic.player2Cards[index];
                    return ScaleTransition(
                      scale:
                          _player2Controller.drive(Tween(begin: 1.0, end: 1.1)),
                      child: Draggable<CardData>(
                        data: card,
                        child: CardWidget(card: card),
                        feedback: CardWidget(card: card),
                        childWhenDragging: Container(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (_gameLogic.celebrate)
            Center(
              child: CelebrationWidget(),
            ),
        ],
      ),
    );
  }
}
