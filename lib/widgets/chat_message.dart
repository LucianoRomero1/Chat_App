import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String uid;
  final String text;
  final AnimationController animationCtrl;

  const ChatMessage(
      {super.key,
      required this.uid,
      required this.text,
      required this.animationCtrl});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationCtrl,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationCtrl, curve: Curves.easeOut),
        child: Container(
            child: this.uid == authService.user.uid
                ? _myMessage()
                : _messageFromAnother()),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 160, right: 5),
        child: Text(text, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _messageFromAnother() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 160),
        child: Text(text, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
            color: Color(0xffE4E5E8), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
