import 'package:flutter/material.dart';

class BtnBlue extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const BtnBlue({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: StadiumBorder(),
        ),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 15),
          )),
        ));
  }
}
