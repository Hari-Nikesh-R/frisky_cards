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
  void _initCards(int numberOfCards, int pair) {
    double cardHeight = 400 / 2;
    double cardWidth = 2500 / 20;
    List<int> generatedNumber = generateShuffledNumbersWithoutRepeatBetweenRange(1, numberOfCards);
    for (int i = 0; i < numberOfCards ; i++) {
      _cards.add(Positioned(
        left: ((i >= pair) ?  i - pair : i) * cardWidth / 2,
        top: (i >= pair) ? 2.5 * cardHeight : 0,
        child: Draggable<int>(
            data: generatedNumber[i],
            feedback: Material(
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(width: cardWidth, height: cardHeight, child:  Center(child: Text("${generatedNumber[i]}", style: const TextStyle(fontSize: 24),),)),
              ),
            ), childWhenDragging: Container(),
            child: Card(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: cardWidth, height: cardHeight, child:  Center(child: Text("${generatedNumber[i]}", style: const TextStyle(fontSize: 24),),),),
          ))
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initCards(20, 10);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ... _cards,
          Positioned(
            left: MediaQuery.of(context).size.width/3,
            right: MediaQuery.of(context).size.width/3 ,
            top: MediaQuery.of(context).size.height/3,
            bottom: MediaQuery.of(context).size.height/3,
            child: DragTarget<int>(
              onAcceptWithDetails: (data) {
                debugPrint('Card $data dropped!');
                // Handle the card being dropped
              },
              builder: (context, candidateData, rejectedData) {
                return SizedBox(
                  width: 300,
                  height: 200,
                  child: Card(
                  elevation: 10,

                  color: Colors.white.withOpacity(0.9),
                  child: Center(
                    child: Text('Drop here'),
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
