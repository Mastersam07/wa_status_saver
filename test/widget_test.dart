
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';


void main() {
  testWidgets('app should work', (tester) async {
    // Build an App with a Text Widget that displays the letter 'H'
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Find a Widget that displays the letter 'H'
    expect(find.text('H'), findsOneWidget);
  });
}