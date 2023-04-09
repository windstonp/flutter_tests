import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Image(image: AssetImage('lib/ui/assets/logo.png')),
          Text("Login".toUpperCase()),
          Form(
            child: Column(children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "email", icon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "senha", icon: Icon(Icons.lock)),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Entrar".toUpperCase()),
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  label: const Text("Criar Conta"))
            ]),
          )
        ],
      ),
    ));
  }
}
