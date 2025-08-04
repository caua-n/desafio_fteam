import 'package:desafio_fteam/core/services/injection/injection_container.dart';
import 'package:desafio_fteam/presentation/routes/app_router.dart';
import 'package:desafio_fteam/presentation/viewmodels/character_list_viewmodel.dart';
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
      ],
      child: MaterialApp.router(
        title: 'Rick and Morty App',
        routerConfig: appRouter,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.tealAccent,
            secondary: Colors.amberAccent,
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.black,
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
