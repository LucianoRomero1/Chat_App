import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/widgets/btn_blue.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';

class LoginPage extends StatelessWidget {
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
                  const Logo(title: "Messenger"),
                  _Form(),
                  const Labels(
                      routeToNavigate: 'register',
                      haveAccount: "You do not have an account?",
                      textAccount: 'Create an account'),
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);

    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
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
                onPressed: authService.authenticating
                    ? () => null
                    : () async {
                        //Esto me baja el teclado si puse credenciales invalidas
                        FocusScope.of(context).unfocus();
                        final loginOk = await authService.login(
                            emailCtrl.text.trim(), passCtrl.text.trim());
                        if (loginOk) {
                          socketService.connect();
                          Navigator.pushReplacementNamed(context, 'users');
                        } else {
                          showAlert(
                              context, "Login failed", "Invalid credentials");
                        }
                      })
          ],
        ));
  }
}
