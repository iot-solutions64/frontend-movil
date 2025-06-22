import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrosmart/features/security/presentation/pages/login_page.dart';
import 'package:hydrosmart/main.dart';

void main() {
  testWidgets('Muestra la pantalla de login si no está logueado', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(isLoggedIn: false));
    await tester.pumpAndSettle(); 
    expect(find.byType(LoginPage), findsWidgets);
  });

  testWidgets('Muestra la pantalla de inicio si está logueado', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(isLoggedIn: true));
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

}