import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:jarnama/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login and open ads list', (WidgetTester tester) async {
    // 1. Запускаем приложение
    app.main();
    await tester.pumpAndSettle();

    // 2. Вводим email
    await tester.enterText(
      find.byKey(const Key('login_email')),
      'test@example.com',
    );

    // 3. Вводим пароль
    await tester.enterText(
      find.byKey(const Key('login_password')),
      '123456',
    );

    // 4. Нажимаем "Войти"
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();

    // 5. Проверяем, что открылся список объявлений
    expect(find.byKey(const Key('ads_list')), findsOneWidget);
  });
}
