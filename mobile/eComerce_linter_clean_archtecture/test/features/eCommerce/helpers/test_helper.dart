import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:my_project_name/core/platform/network_info.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/local_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/remote_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/repositories/product_repository_impl.dart';
import 'package:my_project_name/features/eCommerce/domain/repositories/product_repository.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    NetworkInfo,
    ProductRepositoryImpl
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
