import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 150,
        height: 150,
        child: Lottie.asset('assets/success.json'),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const SuccessDialog();
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop(true);
  });
}
