import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_project_name/features/eCommerce/presentation/bloc/product_bloc.dart';
import 'package:my_project_name/features/eCommerce/presentation/pages/edit_page.dart';

class MockProductBloc extends Mock implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: Edit(),
        ),
      ),
    );
  }

  testWidgets('shows success Snackbar on successful product creation',
      (WidgetTester tester) async {
    // Arrange

    when(() => mockProductBloc.state).thenReturn(InitialState());

    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable([SuccessState()]),
    );

    await pumpWidget(tester);

    await tester.enterText(find.byType(TextField).at(0), 'Test Product');
    await tester.enterText(find.byType(TextField).at(1), 'Test Category');
    await tester.enterText(find.byType(TextField).at(2), '100');
    await tester.enterText(find.byType(TextField).at(3), 'Test Description');

    await tester.tap(find.text('EDIT').first);
    await tester.pumpAndSettle();

    expect(find.text('The Product is Updated Successfully'), findsOneWidget);
  });

  testWidgets('shows error Snackbar on product creation failure',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(InitialState());

    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable(
          [const ErrorState(message: 'Failed to Update a product')]),
    );

    await pumpWidget(tester);

    await tester.enterText(find.byType(TextField).at(0), 'Test Product');
    await tester.enterText(find.byType(TextField).at(1), 'Test Category');
    await tester.enterText(find.byType(TextField).at(2), '100');
    await tester.enterText(find.byType(TextField).at(3), 'Test Description');

    await tester.tap(find.text('EDIT'));
    await tester.pumpAndSettle();

    expect(find.text('Failed to Update a product'), findsOneWidget);
  });
}
