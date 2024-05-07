import 'package:flutter_clean_architecture_template/app/env.dart';
import 'package:flutter_clean_architecture_template/core/database/database_service.dart';
import 'package:flutter_clean_architecture_template/core/graphql/ferry_client.dart';
import 'package:flutter_clean_architecture_template/core/graphql/graphql_impl.dart';
import 'package:flutter_clean_architecture_template/core/interface/graphql_client.dart';
import 'package:flutter_clean_architecture_template/core/services/user_services.dart';
import 'package:flutter_clean_architecture_template/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:flutter_clean_architecture_template/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_template/features/auth/domain/usecases/login_interactor.dart';
import 'package:flutter_clean_architecture_template/features/splash/domain/usecases/fetch_start_up_data.dart';
import 'package:get_it/get_it.dart';

class DI {
  static final instance = GetIt.instance;

  static Future<void> init({required Env env}) async {
    //Environment
    //Register Environment Before calling api client
    instance.registerSingleton<Env>(env);

    final ferryClient = FerryUtils.getFerryClient();

    //Databases
    instance.registerLazySingleton(() => DatabaseService());

    //Network
    instance.registerSingleton<GraphqlClient>(
      GraphqlClientImpl(client: ferryClient),
    );

    //Services
    instance.registerLazySingleton(
      () => UserServices(databaseService: instance<DatabaseService>()),
    );

    //--------------------------Splash-------------------------------

    instance.registerLazySingleton(
      () => FetchStartupDataInteractor(
        userServices: instance(),
      ),
    );

    //--------------------------Login-------------------------------

    //Data Sources
    instance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(),
    );

    //Repository
    instance.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: instance<UserRemoteDataSource>(),
      ),
    );

    // Interactor
    instance.registerLazySingleton<LoginInteractor>(
      () => LoginInteractor(
        userRepository: instance<UserRepository>(),
        userServices: instance<UserServices>(),
      ),
    );
  }
}
