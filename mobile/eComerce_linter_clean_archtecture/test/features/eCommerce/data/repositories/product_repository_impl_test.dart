import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/core/error/failure.dart';
import 'package:my_project_name/features/eCommerce/data/models/product_model.dart';
import 'package:my_project_name/features/eCommerce/data/repositories/product_repository_impl.dart';
import 'package:my_project_name/features/eCommerce/domain/entities/product.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSource();
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
        productRemoteDataSource: mockRemoteDataSource,
        productLocalDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  const testProductId = '1';
  const testProductModel = ProductModel(
    id: '1',
    name: 'nike',
    description: 'sportShoes',
    price: 23.4,
    imageUrl: 'imageUrl',
  );
  const ProductEntity testProductEntity = testProductModel;
  const testProductListModel = [
    ProductModel(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    ),
    ProductModel(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    )
  ];
  const testProductListEntity = [
    ProductEntity(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    ),
    ProductEntity(
      id: '1',
      name: 'nike',
      description: 'sportShoes',
      price: 23.4,
      imageUrl: 'imageUrl',
    )
  ];

  group('getCurrentProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return a product when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getCurrentProduct(testProductId))
            .thenAnswer((_) async => testProductModel);

        //act
        final result = await repository.getCurrentProduct(testProductId);

        //assert
        expect(result, equals(const Right(testProductEntity)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getCurrentProduct(testProductId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getCurrentProduct(testProductId);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.getCurrentProduct(testProductId))
              .thenThrow(SocketException());
          //act
          final result = await repository.getCurrentProduct(testProductId);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
  group('getAllProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return a list of products when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getAllProducts())
            .thenAnswer((_) async => testProductListModel);

        //act
        final result = await repository.getAllProducts();

        final unpackedResult =
            result.fold((failure) => null, (productList) => productList);

        //assert
        expect(unpackedResult, equals(testProductListEntity));
      });
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllProducts())
              .thenAnswer((_) async => testProductListModel);
          when(mockLocalDataSource.cacheAllProducts(testProductListModel))
              .thenAnswer((_) async => const Right(null));
          // act

          await repository.getAllProducts();
          // assert
          verify(mockRemoteDataSource.getAllProducts());
          verify(mockLocalDataSource.cacheAllProducts(testProductListModel));
        },
      );
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getCurrentProduct(testProductId))
            .thenThrow(ServerException());
        //act
        final result = await repository.getCurrentProduct(testProductId);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is offline', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        test('should return cached products when no network is available',
            () async {
          //arrange
          when(mockLocalDataSource.getAllProducts())
              .thenAnswer((_) async => testProductListModel);

          //act
          final result = await repository.getAllProducts();
          final unpackedResult =
              result.fold((failure) => null, (productList) => productList);

          //assert
          expect(unpackedResult, equals(testProductListEntity));
        });
        test('should return cache failure when failing to get cached products',
            () async {
          //arrange
          when(mockLocalDataSource.getAllProducts())
              .thenThrow(CacheException());

          //act
          final result = await repository.getAllProducts();

          //assert
          expect(result, equals(Left(CacheFailure())));
        });
      });
    });
  });
  group('createProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.addProduct(testProductModel))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.addProduct(testProductEntity);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.addProduct(testProductModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.addProduct(testProductEntity);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.addProduct(testProductModel))
              .thenThrow(SocketException());
          //act
          final result = await repository.addProduct(testProductEntity);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
  group('editProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.editProduct(testProductModel))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.editProduct(testProductEntity);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.editProduct(testProductModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.editProduct(testProductEntity);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.editProduct(testProductModel))
              .thenThrow(SocketException());
          //act
          final result = await repository.editProduct(testProductEntity);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
  group('deleteProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.deleteProduct(testProductId))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.deleteProduct(testProductId);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.editProduct(testProductModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.editProduct(testProductEntity);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });

      group('device is ofline', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test('should return connection failure when the device has no internet',
            () async {
          //arrange
          when(mockRemoteDataSource.editProduct(testProductModel))
              .thenThrow(SocketException());
          //act
          final result = await repository.editProduct(testProductEntity);

          //assert
          expect(result, equals(Left(ConnectionFailure())));
        });
      });
    });
  });
}
