import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_login_tdd_clean_architecture/core/network/network_info.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/datasources/login_remote_data_source.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/data/repositories/login_repository_impl.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/repositories/login_repository.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter_login_tdd_clean_architecture/features/login/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/login/data/datasources/login_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Feature - Number Trivia
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      loginUsecase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  // repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));

  // ! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
