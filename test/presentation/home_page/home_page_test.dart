import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todoapp/main.dart' as app;

Future<void> main() async {
  group('home_page', () {
    testWidgets('home_page Appbar', (tester) async {
      app.main();
      expect(find.textContaining('Todo'), findsOneWidget);
    });
    testWidgets('home_page Bottombar', (tester) async {
      app.main();
      expect(find.textContaining('All Tasks'), findsOneWidget);
      expect(find.textContaining('Complete'), findsOneWidget);
      expect(find.textContaining('Incomplete'), findsOneWidget);
    });
  });
}
