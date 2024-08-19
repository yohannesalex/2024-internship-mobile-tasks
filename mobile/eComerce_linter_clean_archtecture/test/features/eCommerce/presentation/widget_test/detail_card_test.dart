import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/presentation/widget/detail_card.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets('ProductCard widget test', (WidgetTester tester) async {
    const product = ProductEntity(
      id: '1',
      imageUrl: 'https://shoes/image.png',
      name: 'Product1',
      price: 29.99,
      description: 'description',
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                  child: detailItem.displayDetailCard(product.name, 'Category',
                      product.price, product.description, product.imageUrl)),
            ],
          ),
        ),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.text('Product1'), findsOneWidget);
    expect(find.textContaining('  (4.5)'), findsOneWidget);
    expect(find.text('29.99'), findsOneWidget);
    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle();
  });
}
