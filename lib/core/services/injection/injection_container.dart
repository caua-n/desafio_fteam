import 'package:desafio_fteam/core/clients/rest/client/rest_client_dio_impl.dart';
import 'package:desafio_fteam/core/clients/rest/i_rest_client.dart';
import 'package:desafio_fteam/domain/usecases/get_locations_by_id_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../data/datasources/ram_remote_datasource.dart';
import '../../../data/repositories/ram_repository_impl.dart';
import '../../../domain/repositories/i_ram_repository.dart';
import '../../../domain/usecases/get_character_by_id_usecase.dart';
import '../../../domain/usecases/get_characters_usecase.dart';
import '../../../domain/usecases/get_episode_by_id_usecase.dart';
import '../../../domain/usecases/get_episodes_usecase.dart';
import '../../../domain/usecases/get_locations_usecase.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Clients
  getIt.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api',
          connectTimeout:
              Duration(milliseconds: 30000),
          receiveTimeout:
              Duration(milliseconds: 30000),
        ),
      ),
    );
  getIt.registerLazySingleton<IRestClient>(() => RestClientDioImpl(dio: getIt<Dio>()));

  // DataSources
  getIt.registerLazySingleton(() => RamRemoteDatasource(getIt()));

  // Repositories
  getIt.registerLazySingleton<IRamRepository>(() => RamRepositoryImpl(getIt()));

  // UseCases
  getIt.registerLazySingleton(() => GetCharactersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCharacterByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetEpisodesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetEpisodeByIdUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLocationsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLocationByIdUseCase(getIt()));
}
