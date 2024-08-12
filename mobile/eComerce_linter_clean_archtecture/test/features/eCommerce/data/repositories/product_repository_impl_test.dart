import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/platform/network_info.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/local_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/remote_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/repositories/product_repository_impl.dart';

import '../../helpers/test_helper.mocks.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ProductRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
  });
}
