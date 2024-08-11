import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:my_project_name/features/eCommerce/domain/repositories/product_repository.dart';

@GenerateMocks(
  [ProductRepository],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
