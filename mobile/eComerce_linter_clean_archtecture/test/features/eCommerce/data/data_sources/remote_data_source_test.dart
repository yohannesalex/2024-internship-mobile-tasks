import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/constants/constant.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:my_project_name/features/eCommerce/data/models/product_model.dart';
import '../../../../helpers/read_json.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProdcutRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProdcutRemoteDataSourceImpl(client: mockHttpClient);
  });
  const testProductId = '1';
  final testProducutModel = ProductModel.fromJson(json.decode(readJson(
      'features/eCommerce/helpers/dummy_data/dummy_product_entity_response.json')));

  const jsonCurrentProduct =
      'features/eCommerce/helpers/dummy_data/mock_product_api.json';

  const jsonAllProducts =
      'features/eCommerce/helpers/dummy_data/mock_productsList_api.json';

  group('getCurrentProduct', () {
    test('Should perform a get request on the URL with success code 200',
        () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response((readJson(jsonCurrentProduct)), 200));
      final result = await dataSource.getCurrentProduct(testProductId);
      verify(mockHttpClient.get(any));
      expect(result, isA<ProductModel>());
    });
    test('should throw server exception if status code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(readJson(jsonCurrentProduct), 400));

      // act and assert
      expect(() => dataSource.getCurrentProduct(testProductId),
          throwsA(isA<ServerException>()));
    });
  });
  group('getAllProduct', () {
    test('Should perform a get request on the URL with success code 200',
        () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response((readJson(jsonAllProducts)), 200));
      final result = await dataSource.getAllProducts();
      verify(mockHttpClient.get(any));
      expect(result, isA<List<ProductModel>>());
    });
    test('should throw server exception if status code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(readJson(jsonCurrentProduct), 400));

      // act and assert
      expect(
          () => dataSource.getAllProducts(), throwsA(isA<ServerException>()));
    });
  });
  // group('addProduct', () {
  //   const productToAdd = ProductModel(
  //     id: '1',
  //     name: 'PC',
  //     description: 'long description',
  //     imageUrl: '',
  //     price: 123,
  //   );

  //   test('should perform a POST request with multipart/form-data', () async {
  //     // arrange
  //     final mockResponse = http.StreamedResponse(
  //       Stream.value(utf8.encode(json.encode({
  //         'statusCode': 201,
  //         'message': '',
  //         'data': {
  //           'id': '6672940692adcb386d593686',
  //           'name': 'PC',
  //           'description': 'long description',
  //           'price': 123,
  //           'imageUrl':
  //               'https://res.cloudinary.com/g5-mobile-track/image/upload/v1718785031/images/zqfvuxrxhip7shikyyj4.png'
  //         }
  //       }))),
  //       201,
  //     );

  //     when(mockHttpClient.send(any)).thenAnswer((_) async => mockResponse);

  //     // act
  //     await dataSource.addProduct(productToAdd);

  //     // assert
  //     verify(mockHttpClient.send(captureAny)).captured.single
  //         as http.MultipartRequest;
  //   });

  //   test('should throw a ServerException if the response code is not 201',
  //       () async {
  //     // arrange
  //     final mockResponse = http.StreamedResponse(Stream.value([]), 400);
  //     when(mockHttpClient.send(any)).thenAnswer((_) async => mockResponse);

  //     // act & assert
  //     expect(() => dataSource.addProduct(productToAdd),
  //         throwsA(isA<ServerException>()));
  //   });
  // });

  group('editProduct', () {
    final jsonBody = {
      'name': testProducutModel.name,
      'description': testProducutModel.description,
      'price': testProducutModel.price,
    };

    final headers = {'Content-Type': 'application/json'};

    test(
        'should perform a PUT request with the correct data if status code is 200',
        () async {
      when(mockHttpClient.put(
        Uri.parse('${Uris.baseUrl}/${testProducutModel.id}'),
        headers: headers,
        body: json.encode(jsonBody),
      )).thenAnswer(
          (_) async => http.Response(readJson(jsonCurrentProduct), 200));

      // Act
      await dataSource.editProduct(testProducutModel);

      // Assert
      verify(mockHttpClient.put(
        Uri.parse('${Uris.baseUrl}/${testProducutModel.id}'),
        headers: headers,
        body: json.encode(jsonBody),
      ));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.put(
        Uri.parse('${Uris.baseUrl}/${testProducutModel.id}'),
        headers: headers,
        body: json.encode(jsonBody),
      )).thenAnswer((_) async => http.Response('Something went wrong', 500));

      // Act
      Future<void> call() => dataSource.editProduct(testProducutModel);

      // Assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });
  group('deleteProduct', () {
    final headers = {'Content-Type': 'application/json'};

    test(
        'should perform a delete request with the correct data if status code is 204',
        () async {
      when(mockHttpClient.delete(
        Uri.parse('${Uris.baseUrl}/$testProductId'),
        headers: headers,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await dataSource.deleteProduct(testProductId);

      // Assert
      verify(mockHttpClient.delete(
        Uri.parse('${Uris.baseUrl}/$testProductId'),
        headers: headers,
      ));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.delete(
        Uri.parse('${Uris.baseUrl}/$testProductId'),
        headers: headers,
      )).thenAnswer((_) async => http.Response('Something went wrong', 500));

      // Act
      Future<void> call() => dataSource.deleteProduct(testProductId);

      // Assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });
}
