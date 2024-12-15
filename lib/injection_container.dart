
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mock_api_practice/core/http_client/http_client_imp.dart';
import 'package:mock_api_practice/core/http_client/http_interface/i_http_client.dart';
import 'package:mock_api_practice/feature/home/data/datasources/home_remote_datasource.dart';
import 'package:mock_api_practice/feature/home/data/repositories/home_repository_imp.dart';
import 'package:mock_api_practice/feature/home/domain/respositories/home_repositories.dart';
import 'package:mock_api_practice/feature/home/domain/usecases/home.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_bloc.dart';
import 'package:mock_api_practice/feature/home/presentation/widgets/custom_drawer.dart';
import 'package:mock_api_practice/feature/login/data/datasources/login_remote_datasource.dart';
import 'package:mock_api_practice/feature/login/data/repositories/login_repositroy_impl.dart';
import 'package:mock_api_practice/feature/login/domain/repositories/login_repository.dart';
import 'package:mock_api_practice/feature/login/domain/usecases/login.dart';
import 'package:mock_api_practice/feature/login/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  // HttpClient
  sl.registerSingleton<IHttpClient<Response>>(HttpClient());

  // SharedPreferences (await the instance before registering)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Remote Api Services
  sl.registerSingleton<LoginRemoteDataSource>(LoginRemoteDataSourceImp(sl()));
  sl.registerSingleton<HomeRemoteDatasource>(HomeRemoteDatasourceImp(httpClient: sl()));

  // Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginRemoteDataSource: sl(), prefs: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp(homeRemoteDatasource: sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => CategoriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => ProductsUseCase(repository: sl()));

  // Blocs
  sl.registerLazySingleton(() => LoginBloc(sl()));
  sl.registerLazySingleton(() => HomeBloc(sl(),sl()));


}