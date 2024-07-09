import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Lottie.asset('assets/failure.json'),
      ),
    );
  }
}

void showFailureDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const FailureDialog();
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop(true);
  });
}
