import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 40),
        //Safe area es para si los celus tienen
        //notchs (módulo que se sitúa en la parte superior de la pantalla de un smartphone, y cuya funcionalidad es la de albergar la cámara frontal y otros sensores )
        //que molesten arriba
        child: SafeArea(
          child: Column(
            children: [
              Image(image: AssetImage('assets/tag-logo.png')),
              SizedBox(height: 20),
              Text(title, style: TextStyle(fontSize: 30))
            ],
          ),
        ),
      ),
    );
  }
}
