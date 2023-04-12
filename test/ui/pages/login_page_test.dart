import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/ui/pages/login_page.dart';

void main() {
  late MaterialApp loginPage;

  setUp(() {
    loginPage = const MaterialApp(home: LoginPage());
  });
  testWidgets("should load with correct initial state", (tester) async {
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            "When a textFormField has one textChild means it has no errors, since one of the childs is always the label text");

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('password'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget,
        reason:
            "When a textFormField has one textChild means it has no errors, since one of the childs is always the label text");
  });

  testWidgets("button should be disabled on start", (tester) async {
    await tester.pumpWidget(loginPage);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    expect(button.onPressed, null);
  });
}
