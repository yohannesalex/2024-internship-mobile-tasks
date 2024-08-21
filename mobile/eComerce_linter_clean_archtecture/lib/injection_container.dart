import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/data/resource/auth_local_data_source.dart';
import 'features/authentication/data/resource/auth_remote_data_source.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/getme.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/sign_up.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/eCommerce/data/data_sources/local_data_source.dart';
import 'features/eCommerce/data/data_sources/remote_data_source.dart';
import 'features/eCommerce/data/repositories/product_repository_impl.dart';
import 'features/eCommerce/domain/repositories/product_repository.dart';
import 'features/eCommerce/domain/usecases/add_product.dart';
import 'features/eCommerce/domain/usecases/delete_product.dart';
import 'features/eCommerce/domain/usecases/edit_product.dart';
import 'features/eCommerce/domain/usecases/get_all_product.dart';
import 'features/eCommerce/domain/usecases/get_current_product.dart';
import 'features/eCommerce/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => AuthBloc(
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => ProductBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  // Usecases
  sl.registerLazySingleton(() => GetMeUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton(() => GetCurrentProductUsecase(sl()));
  sl.registerLazySingleton(() => GetAllProductUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => EditProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  //repo
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authLocalDataSource: sl(),
        authRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        productLocalDataSource: sl(),
        productRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  //Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProdcutRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
