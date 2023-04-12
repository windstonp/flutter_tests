import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    const primaryColor = Color.fromRGBO(136, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    return MaterialApp(
      title: "forDevs",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          focusColor: primaryColor,
          textTheme: const TextTheme(
              headlineLarge: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColorDark)),
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelStyle: TextStyle(color: primaryColor),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColorLight)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              iconColor: primaryColorLight,
              alignLabelWithHint: true),
          buttonTheme: ButtonThemeData(
              colorScheme: const ColorScheme.light(primary: primaryColor),
              buttonColor: primaryColor,
              splashColor: primaryColorLight,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: primaryColor,
                  surfaceTintColor: primaryColorLight,
                  textStyle: Theme.of(context).textTheme.bodyMedium)),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black87))),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: primaryColor)),
      home: const LoginPage(),
    );
  }
}
