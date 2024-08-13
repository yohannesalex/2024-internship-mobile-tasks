import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:my_project_name/core/network/network_info.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/local_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/remote_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/repositories/product_repository_impl.dart';
import 'package:my_project_name/features/eCommerce/domain/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    NetworkInfo,
    InternetConnectionChecker,
    SharedPreferences,
    ProductRepositoryImpl,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
