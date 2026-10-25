import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/chat/data/chat_repository.dart';
import '../features/chat/presentation/view/chat_screen.dart';
import '../features/chat/presentation/view_model/chat_cubit.dart';
import '../features/notes/data/notes_repository.dart';
import '../features/notes/presentation/view/note_editor_screen.dart';
import '../features/notes/presentation/view/notes_screen.dart';
import '../features/notes/presentation/view_model/note_editor_cubit.dart';
import '../features/notes/presentation/view_model/notes_cubit.dart';
import '../features/settings/data/settings_repository.dart';
import '../features/settings/presentation/view/settings_screen.dart';
import '../features/settings/presentation/view_model/settings_cubit.dart';
import '../features/tasks/data/tasks_repository.dart';
import '../features/tasks/presentation/view/tasks_screen.dart';
import '../features/tasks/presentation/view_model/tasks_cubit.dart';
import 'app_shell.dart';

final _notesRepository = NotesRepository();

/// Tabs live in a [StatefulShellRoute] so each keeps its state; the editor and
/// Settings push above the shell, which hides the tab pill.
final appRouter = GoRouter(
  initialLocation: '/chat',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/chat',
            builder: (context, state) => BlocProvider(
              create: (_) => ChatCubit(ChatRepository()),
              child: const ChatScreen(),
            ),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/notes',
            builder: (context, state) => BlocProvider(
              create: (_) => NotesCubit(_notesRepository),
              child: const NotesScreen(),
            ),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/tasks',
            builder: (context, state) => BlocProvider(
              create: (_) => TasksCubit(TasksRepository()),
              child: const TasksScreen(),
            ),
          ),
        ]),
      ],
    ),
    GoRoute(
      path: '/note/:id',
      builder: (context, state) => BlocProvider(
        create: (_) => NoteEditorCubit(_notesRepository, state.pathParameters['id']!),
        child: const NoteEditorScreen(),
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => BlocProvider(
        create: (_) => SettingsCubit(SettingsRepository()),
        child: const SettingsScreen(),
      ),
    ),
  ],
);
