// 11. app_router.dart
import 'package:desafio_fteam/core/services/injection/injection_container.dart';
import 'package:desafio_fteam/presentation/views/character_detail_view.dart';
import 'package:desafio_fteam/presentation/views/home_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../viewmodels/character_detail_viewmodel.dart';
import '../viewmodels/character_list_viewmodel.dart';


final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => CharacterListViewModel(getIt()),
        child: const HomeView(),
      ),
      routes: [
        GoRoute(
          path: 'character/:id',
          name: 'characterDetail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ChangeNotifierProvider(
              create: (_) => CharacterDetailViewModel(getIt(), id)..loadCharacter(),
              child: const CharacterDetailView(),
            );
          },
        ),
      ],
    ),
  ],
);