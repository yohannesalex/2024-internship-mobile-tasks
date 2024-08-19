import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/presentation/bloc/product_bloc.dart';
import 'package:my_project_name/features/eCommerce/presentation/pages/search_page.dart';

// Mock classes
class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    HttpOverrides.global = null;
    mockProductBloc = MockProductBloc();
  });

  Widget TestWidget() {
    return BlocProvider<ProductBloc>.value(
      value: mockProductBloc,
      child: const MaterialApp(home: Search()),
    );
  }

  testWidgets('displays loading indicator when state is LoadingState',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenAnswer((_) => LoadingState());

    await tester.pumpWidget(TestWidget());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays all products when state is LoadedAllProductsState',
      (WidgetTester tester) async {
    // Arrange
    final testProducts = [
      const ProductEntity(
          id: '1',
          name: 'Test Product',
          price: 23.0,
          description: 'the product description',
          imageUrl: 'https://www.github.com')
    ];
    when(() => mockProductBloc.state)
        .thenReturn(LoadedAllProductState(productList: testProducts));

    // Act
    await tester.pumpWidget(TestWidget());
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(Card), findsNWidgets(testProducts.length));
  });

  testWidgets('displays error message when state is ProductError',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(const ErrorState(message: ''));

    // Act
    await tester.pumpWidget(TestWidget());

    // Assert
    expect(find.text(''), findsOneWidget);
  });
}
