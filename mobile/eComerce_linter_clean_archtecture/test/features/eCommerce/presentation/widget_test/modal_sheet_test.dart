import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/eCommerce/presentation/widget/modal_sheet.dart';

void main() {
  testWidgets('Modal Sheet Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: modalSheet.diaplayModal(),
      ),
    ));

    // Verify that the 'Category' text is displayed, ignoring leading/trailing spaces
    expect(find.textContaining('Category'), findsOneWidget);

    // Verify that the 'Price' text is displayed, ignoring leading/trailing spaces
    expect(find.textContaining('Price'), findsOneWidget);

    // Verify that the TextField is displayed
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the RangeSlider is displayed
    expect(find.byType(RangeSlider), findsOneWidget);

    // Verify that the 'APPLY' button is displayed
    expect(find.widgetWithText(ElevatedButton, 'APPLY'), findsOneWidget);
  });
}
