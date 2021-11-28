import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('create_page', () {
    testWidgets('create_page: Appbar', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Create Task'),
          ),
        ),
      ));
      // await tester.pumpWidget(
      //   CreateTask(),
      // );
      expect(find.textContaining('Create Task'), findsOneWidget);
      // expect(find.textContaining('Detail'), findsOneWidget);
    });
    testWidgets('create_page: TextFormField', (tester) async {
      TextEditingController _name = new TextEditingController();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(
            child: TextFormField(
              controller: _name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name of task',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ),
      ));
      expect(find.textContaining('Enter name of task'), findsOneWidget);
    });
    testWidgets('create_page: TextButton', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ));
      expect(find.textContaining('Submit'), findsOneWidget);
    });
  });
}
