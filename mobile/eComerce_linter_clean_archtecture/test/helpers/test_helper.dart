import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:my_project_name/core/network/network_info.dart';
import 'package:my_project_name/features/authentication/data/resource/auth_local_data_source.dart';
import 'package:my_project_name/features/authentication/data/resource/auth_remote_data_source.dart';
import 'package:my_project_name/features/authentication/domain/repositories/auth_repository.dart';
import 'package:my_project_name/features/authentication/domain/usecases/getme.dart';
import 'package:my_project_name/features/authentication/domain/usecases/login.dart';
import 'package:my_project_name/features/authentication/domain/usecases/logout.dart';
import 'package:my_project_name/features/authentication/domain/usecases/sign_up.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/local_data_source.dart';
import 'package:my_project_name/features/eCommerce/data/data_sources/remote_data_source.dart';
import 'package:my_project_name/features/eCommerce/domain/repositories/product_repository.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/add_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/delete_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/edit_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/get_all_product.dart';
import 'package:my_project_name/features/eCommerce/domain/usecases/get_current_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    AuthRepository,
    AuthLocalDataSource,
    AuthRemoteDataSource,
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    NetworkInfo,
    InternetConnectionChecker,
    SharedPreferences,
    GetMeUseCase,
    LoginUseCase,
    SignUpUseCase,
    LogoutUseCase,
    GetCurrentProductUsecase,
    GetAllProductUsecase,
    EditProductUsecase,
    DeleteProductUsecase,
    AddProductUsecase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
