import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/constants/constant.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/features/authentication/data/model/login_response_model.dart';
import 'package:my_project_name/features/authentication/data/model/signup_response_model.dart';
import 'package:my_project_name/features/authentication/data/model/token_taker_model.dart';
import 'package:my_project_name/features/authentication/data/resource/auth_remote_data_source.dart';

import '../../../../helpers/read_json.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
  });

  const jsonGetMe = 'helpers/dummy_data/mock_getme_api.json';
  const testLoginModel =
      LoginResponseModel(email: 'abc@gmail.com', password: '1234abcd');
  const jsonLogin = 'helpers/dummy_data/mock_login_api.json';

  group('getMe', () {
    const String token = 'sample_token';
    final Uri url = Uri.parse('${Uris.baseUrl}/users/me');
    test(
        'should perform a GET request and return GetMeResponseModel on success',
        () async {
      // Arrange

      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(readJson(jsonGetMe), 200));

      // Act
      final result = await dataSource.getMe(token);

      // Assert
      verify(mockHttpClient.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      ));
      expect(result.name, 'Mr. User');
    });

    test('should throw a ServerException if the status code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(url, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      // Act & Assert
      expect(() => dataSource.getMe(token), throwsA(isA<ServerException>()));
    });
  });

  group('login', () {
    test('Should perform a post request on the URL with success code 201',
        () async {
      // Arrange
      const url =
          'https://g5-flutter-learning-path-be.onrender.com/api/v2//auth/login';
      final headers = {'Content-Type': 'application/json'};
      const body = '{"email":"abc@gmail.com","password":"1234abcd"}';

      when(mockHttpClient.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      )).thenAnswer((_) async => http.Response((readJson(jsonLogin)), 201));

      // Act
      final result = await dataSource.login(testLoginModel);

      // Assert
      verify(mockHttpClient.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      ));
      expect(result, isA<TokenTakerModel>());
    });

    test('should throw server exception if status code is other than 200',
        () async {
      // Arrange
      const url =
          'https://g5-flutter-learning-path-be.onrender.com/api/v2//auth/login';
      final headers = {'Content-Type': 'application/json'};
      const body = '{"email":"abc@gmail.com","password":"1234abcd"}';

      when(mockHttpClient.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      )).thenAnswer((_) async => http.Response(readJson(jsonLogin), 400));

      // Act & Assert
      expect(() => dataSource.login(testLoginModel),
          throwsA(isA<ServerException>()));
    });
  });
  group('signUp', () {
    const testSignupModel = SignupResponseModel(
      name: 'Mr. User',
      email: 'user@gmail.com',
      password: 'userpassword',
    );

    final Uri url = Uri.parse('${Uris.baseUrl}/auth/register');

    test(
        'should perform a POST request and not throw on success (status code 201)',
        () async {
      // Arrange
      when(mockHttpClient.post(
        url,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{}', 201));

      // Act
      await dataSource.signUp(testSignupModel);

      // Assert
      verify(mockHttpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': testSignupModel.name,
          'email': testSignupModel.email,
          'password': testSignupModel.password,
        }),
      ));
    });

    test('should throw a ServerException if the status code is not 201',
        () async {
      // Arrange
      when(mockHttpClient.post(
        url,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Something went wrong', 400));

      // Act & Assert
      expect(() => dataSource.signUp(testSignupModel),
          throwsA(isA<ServerException>()));
    });
  });
}
