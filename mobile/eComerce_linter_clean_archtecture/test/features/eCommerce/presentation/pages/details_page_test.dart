import 'dart:io';

import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';
import 'package:my_project_name/features/eCommerce/presentation/bloc/product_bloc.dart';
import 'package:my_project_name/features/eCommerce/presentation/pages/details_page.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

// Fallback classes for Mocktail
class FakeProductEvent extends Fake implements ProductEvent {}

class FakeProductState extends Fake implements ProductState {}

void main() {
  late MockProductBloc mockProductBloc;
  late ProductEntity testProduct;

  setUpAll(() {
    registerFallbackValue(FakeProductEvent());
    registerFallbackValue(FakeProductState());
  });

  setUp(() {
    mockProductBloc = MockProductBloc();
    HttpOverrides.global = null;
    testProduct = const ProductEntity(
      id: '1',
      name: 'shoes',
      price: 23.0,
      description: 'description',
      imageUrl: 'https://example.com/image.jpg',
    );
  });

  Widget TestWidget() {
    return BlocProvider<ProductBloc>.value(
      value: mockProductBloc,
      child: MaterialApp(
        home: Detail(product: testProduct),
      ),
    );
  }

  testWidgets('displays product details', (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(InitialState());

    // Act
    await tester.pumpWidget(TestWidget());
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('shoes'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
  });

  testWidgets('DELETE button triggers DeleteProductEvent',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(InitialState());

    // Act
    await tester.pumpWidget(TestWidget());
    await tester.pumpAndSettle();
    await tester.tap(find.text('DELETE'));
    await tester.pump();

    // Assert
    verify(() => mockProductBloc.add(DeleteProductEvent(testProduct.id)))
        .called(1);
  });

  testWidgets('shows success Snackbar on successful deletion',
      (WidgetTester tester) async {
    // Arrange
    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable([InitialState(), SuccessState()]),
      initialState: InitialState(),
    );

    // Act
    await tester.pumpWidget(TestWidget());
    await tester.tap(find.text('DELETE'));
    await tester.pump();
    await tester.pumpAndSettle();
    // Assert
    expect(find.text('The Product is deleted'), findsOneWidget);
  });

  testWidgets('shows error Snackbar on deletion failure',
      (WidgetTester tester) async {
    // Arrange
    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable([const ErrorState(message: '')]),
      initialState: InitialState(),
    );

    // Act
    await tester.pumpWidget(TestWidget());
    await tester.tap(find.text('DELETE'));
    await tester.pump();
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Failed to delete the product'), findsOneWidget);
  });
}
