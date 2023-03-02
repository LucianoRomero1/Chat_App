import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String routeToNavigate;
  final String haveAccount;
  final String textAccount;

  const Labels(
      {super.key,
      required this.routeToNavigate,
      required this.haveAccount,
      required this.textAccount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(haveAccount,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.w200)),
          const SizedBox(height: 10),
          //Permite agregar acciones
          GestureDetector(
            child: Text(
              textAccount,
              style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, routeToNavigate);
            },
          )
        ],
      ),
    );
  }
}
