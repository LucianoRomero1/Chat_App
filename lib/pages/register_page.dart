import 'package:chat_app/widgets/btn_blue.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              //Esto es el total de alto de la pantalla
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(title: "Register"),
                  _Form(),
                  const Labels(
                      routeToNavigate: 'login',
                      haveAccount: 'Do you already have an account?',
                      textAccount: 'Sign in'),
                  const Text(
                    'Terms and Conditions',
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInput(
              icon: Icons.perm_identity,
              placeholder: 'Name',
              keyboardType: TextInputType.text,
              textController: nameCtrl,
            ),
            CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Password',
              isPassword: true,
              textController: passCtrl,
            ),
            BtnBlue(
                text: "Login",
                onPressed: () {
                  print(nameCtrl.text);
                  print(passCtrl.text);
                })
          ],
        ));
  }
}
