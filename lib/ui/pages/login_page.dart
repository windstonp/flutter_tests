import 'package:flutter/material.dart';
import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const LoginHeader(),
          const HeadlineLarge(text: "login"),
          Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "email", icon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "password", icon: Icon(Icons.lock)),
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text("Entrar".toUpperCase()),
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text("Criar Conta"))
                ]),
              ))
        ],
      ),
    ));
  }
}
