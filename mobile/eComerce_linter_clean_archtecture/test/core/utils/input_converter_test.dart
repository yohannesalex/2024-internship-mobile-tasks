import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/core/error/failure.dart';
import 'package:my_project_name/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedDouble', () {
    test(
      'should return a double when the string represents an unsigned integer',
      () {
        // arrange
        const str = '123';
        // act
        final result = inputConverter.stringToUnsignedDouble(str);
        // assert
        expect(result, const Right(123));
      },
    );
    test(
      'should return a failure when the string is not an integer',
      () async {
        // arrange
        const str = 'abc';
        // act
        final result = inputConverter.stringToUnsignedDouble(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
    test(
      'should return a failure  when the string represents an negative integer',
      () {
        // arrange
        const str = '-123';
        // act
        final result = inputConverter.stringToUnsignedDouble(str);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
