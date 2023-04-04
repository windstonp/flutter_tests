import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.blue[300],
        home: Scaffold(
          appBar: AppBar(
              title:
                  const Text("Home", style: TextStyle(color: Colors.white70))),
          body: Center(child: Text("Teste")),
        ));
  }
}
