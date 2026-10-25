import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/note.dart';
import '../../data/notes_repository.dart';

class NotesState {
  const NotesState({required this.notes, this.query = ''});

  final List<Note> notes;
  final String query;

  List<Note> get visible => query.isEmpty
      ? notes
      : notes
          .where((n) => n.title.contains(query) || n.preview.contains(query))
          .toList();
}

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(NotesRepository repository)
      : super(NotesState(notes: repository.notes()));

  void search(String query) =>
      emit(NotesState(notes: state.notes, query: query.trim()));
}
