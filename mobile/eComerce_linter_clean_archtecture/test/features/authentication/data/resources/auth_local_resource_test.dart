import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/features/authentication/data/model/token_taker_model.dart';
import 'package:my_project_name/features/authentication/data/resource/auth_local_data_source.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AuthLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('getToken', () {
    const CACHED_TOKEN = 'CACHED_TOKEN';
    test(
        'should return cached products from shared reference when there is one in the cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(CACHED_TOKEN);

      //act
      final result = await dataSource.getToken();

      //assert
      expect(result, equals(CACHED_TOKEN));
    });
    test('should throw cache exception when there is not a cached value',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      //act
      final call = dataSource.getToken;

      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('cacheToken', () {
    const token = 'dummy_token';
    const tokenToCache = TokenTakerModel(token: token);

    test('should call SharedPreferences to cache the data', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.cacheToken(tokenToCache);

      // Assert
      verify(mockSharedPreferences.setString('CACHED_Token', token));
    });

    test('should throw a CacheException when there is an error', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());

      // Act
      final call = dataSource.cacheToken;

      // Assert
      expect(() => call(tokenToCache), throwsA(isA<CacheException>()));
    });
  });
  group('deleteToken', () {
    test('should call SharedPreferences to delete the data', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);

      // Act
      await dataSource.deleteToken();

      // Assert
      verify(mockSharedPreferences.remove('CACHED_Token'));
    });

    test('should throw a CacheException when there is an error', () async {
      // Arrange
      when(mockSharedPreferences.remove(any)).thenThrow(Exception());

      // Act
      final call = dataSource.deleteToken;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
