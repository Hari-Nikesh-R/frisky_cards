import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frisky_card/view/card_widget.dart';
import 'package:frisky_card/view/celebration_widget.dart';
import 'package:frisky_card/view/dustbin_widget.dart';

import 'game_logic.dart';

void main() {
  runApp(const CardMatchGame());
}

class CardMatchGame extends StatelessWidget {
  const CardMatchGame({super.key});

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
  const GameScreen({super.key});

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
      duration: const Duration(seconds: 1),
    );
    _player2Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
      appBar: AppBar(title: const Text('Card Match Game'), centerTitle: true),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 12,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 3,
                            vertical: 12),
                        child: Text(
                          _gameLogic.currentPlayer.toUpperCase(),
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: GestureDetector(onTap:() {
                    _gameLogic.undoCards();
                  }, child: const Icon(Icons.undo)))
                ],
              ),
              Expanded(
                child: DragTarget<CardData>(
                  builder: (context, candidateData, rejectedData) {
                    return DustbinWidget(
                      cards: _gameLogic.dustbinCards,
                    );
                  },
                  onAcceptWithDetails: (card) {
                    _handleCardDropped(card.data, _gameLogic.currentPlayer);
                    _switchPlayer();
                  },
                ),
              ),
              _gameLogic.currentPlayer == 'player1'
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: _gameLogic.player1Cards.length,
                        itemBuilder: (context, index) {
                          final card = _gameLogic.player1Cards[index];
                          return ScaleTransition(
                            scale: _player1Controller
                                .drive(Tween(begin: 1.0, end: 1.1)),
                            child: Draggable<CardData>(
                              data: card,
                              child: CardWidget(card: card),
                              feedback: CardWidget(card: card),
                              childWhenDragging: Container(),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: _gameLogic.player2Cards.length,
                        itemBuilder: (context, index) {
                          final card = _gameLogic.player2Cards[index];
                          return ScaleTransition(
                            scale: _player2Controller
                                .drive(Tween(begin: 1.0, end: 1.1)),
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
            const Center(
              child: CelebrationWidget(),
            ),
        ],
      ),
    );
  }
}
