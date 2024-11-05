import 'package:flutter/material.dart';

class LoadContainerImage extends StatelessWidget {
  const LoadContainerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(24), child: Column(
      children: [
        Image.asset('assets/images/fullcontainer.png',
            fit: BoxFit.fill,),
        const Text("Choose the match")
      ],
    ));
  }
}
