import 'dart:io';

import 'package:flutter/material.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<int> generateShuffledNumbersWithoutRepeatBetweenRange(int start, int end) {
    if (start >= end) {
      throw ArgumentError('Start should be less than end.');
    }
    List<int> numbers = List.generate(end - start + 1, (index) => start + index);
    numbers.shuffle();
    return numbers;
  }

  final List<Widget> _cards = [];
  final List<int> _droppedCards = [];
  final List<int> _generatedNumbers = [];
   final int totalNumberOfCard = 40;


  void _initCards(int numberOfCards) {
    double cardHeight = 400 / 2;
    double cardWidth = 2500 / 20;
    _cards.clear();
    for (int i = 0; i < numberOfCards ; i++) {
      _cards.add(Positioned(
        left: ((i >= numberOfCards/2) ?  i - numberOfCards/2 : i) * cardWidth,
        top: (i >= numberOfCards/2) ?  2.9 * cardHeight : 0,
        child: Draggable<int>(
            data: _generatedNumbers[i],
            feedback: Material(
              child:  _droppedCards.contains(_generatedNumbers[i]) ? Container(): Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(width: cardWidth, height: cardHeight, child:  Center(child: Text("${_generatedNumbers[i]}", style: const TextStyle(fontSize: 24),),)),
              ),
            ), childWhenDragging: Container(),
           child: _droppedCards.contains(_generatedNumbers[i]) ? Container(): Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Center(
              child: Text(
                "${_generatedNumbers[i]}",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ))
        ),
      );
    }
  }

  _initCardNumber(int start, int totalCards) {
    try {
      int end = (totalCards / 2) as int;
      List<int> numbers = generateShuffledNumbersWithoutRepeatBetweenRange(
          start, end);
      double limit = totalCards / end;
      while (limit > 0) {
        _generatedNumbers.addAll(numbers);
        limit--;
      }
    }
    catch (e) {
      //todo: implement error page for card size.
    }
  }



  @override
  void initState() {
    super.initState();

    _initCardNumber(1, totalNumberOfCard);
    _initCards(totalNumberOfCard);
  }


  List<Widget> loadCardView() {
    List<Card> selectedCardView = [];
    for (var number in _droppedCards) {
      selectedCardView.add(Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: 100,
          height: 200,
          child: Center(child: Text("$number",
            style: const TextStyle(fontSize: 24),),),),
      ));
    }
    return selectedCardView;
  }


  bool _isFromWeb() {
    try{
      if(Platform.isAndroid||Platform.isIOS) {
        return false;
      } else {
        return true;
      }
    } catch(e){
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(padding: const EdgeInsets.all(16),child: SizedBox(
        width: MediaQuery.of(context).size.width,
    child: Column(
    children: [
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Stack(
        children: [
          Container(
            width: totalNumberOfCard > 10 ? MediaQuery.of(context).size.width * totalNumberOfCard / 24 : MediaQuery.of(context).size.width * 2,
            height: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height * 2 : MediaQuery.of(context).size.height * 1.5,
            child: Stack(
              children: [
                ... _cards,
                Padding(padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3,MediaQuery.of(context).orientation == Orientation.landscape && !_isFromWeb() ? MediaQuery.of(context).size.height/1.8 : MediaQuery.of(context).size.height/3, MediaQuery.of(context).size.width/3, MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height/1.8 : MediaQuery.of(context).size.height/3), child: DragTarget<int>(
                    onAcceptWithDetails: (data) {
                      debugPrint('Card $data dropped!');
                      setState(() {
                        _droppedCards.add(data.data);
                        _initCards(totalNumberOfCard);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return SizedBox(
                        width: totalNumberOfCard > 10 ? MediaQuery.of(context).size.width/(60/totalNumberOfCard) : MediaQuery.of(context).size.width/4,
                        height: 250,
                        child: Card(
                            elevation: 10,
                            color: Colors.white.withOpacity(0.9),
                            child: Center(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _droppedCards.isNotEmpty ? loadCardView() : [Text('Drop here')],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ))])))),
    );
  }
}
