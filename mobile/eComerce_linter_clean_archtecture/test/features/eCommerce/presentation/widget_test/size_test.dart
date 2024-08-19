import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_project_name/features/eCommerce/presentation/widget/size.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets('ProductCard widget test', (WidgetTester tester) async {
    const size = 42;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(child: shoeSize.displaySize(size)),
            ],
          ),
        ),
      ),
    ));

    expect(find.byType(Container), findsOneWidget);

    expect(find.text('42'), findsOneWidget);
  });
}
