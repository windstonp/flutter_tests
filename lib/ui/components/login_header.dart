import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      height: 240,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark
              ]),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 0,
                color: Colors.black)
          ],
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(80))),
      child: const Image(image: AssetImage('lib/ui/assets/logo.png')),
    );
  }
}
