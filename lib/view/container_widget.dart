import 'package:flutter/material.dart';

import 'card_widget.dart';
import 'load_container_image_widget.dart';

class ContainerWidget extends StatelessWidget {
  final List<CardData> cards;
  bool isFull = false;

  ContainerWidget({
    super.key,
    required this.cards,
    required this.isFull,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFull ? const Center(child: LoadContainerImage()) : const SizedBox(width: 140, height: 240, child: Center(child: Text('Drop Here'))),
                ...cards.map((card) => CardWidget(card: card)),
              ],
            ),
          ),
        ));
  }
}
