import 'package:desafio_fteam/core/services/injection/injection_container.dart';
import 'package:desafio_fteam/presentation/routes/app_router.dart';
import 'package:desafio_fteam/presentation/viewmodels/character_list_viewmodel.dart';
import 'package:desafio_fteam/presentation/viewmodels/episode_list_viewmodel.dart';
import 'package:desafio_fteam/presentation/viewmodels/location_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterListViewModel(getCharactersUseCase: getIt()),
        ),
        ChangeNotifierProvider(
          create: (_) => EpisodeListViewModel(getEpisodesUseCase: getIt()),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationListViewModel(getLocationsUseCase: getIt()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rick and Morty App',
        routerConfig: appRouter,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.lightGreen,
            secondary: Colors.amberAccent,
          ),
          scaffoldBackgroundColor: Color(0xff24325f),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff24325f),
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color(0xff24325f),
            border: OutlineInputBorder(),
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.white,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
