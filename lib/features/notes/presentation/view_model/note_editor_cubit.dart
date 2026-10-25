import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/note.dart';
import '../../data/notes_repository.dart';

/// State is the note itself; the rich-text body stays in the view for now
/// (the editor package is chosen after the spike).
class NoteEditorCubit extends Cubit<NoteDetail> {
  NoteEditorCubit(NotesRepository repository, String id)
      : super(repository.detail(id));

  void toggleItem(int index) => emit(state.copyWith(checklist: [
        for (var i = 0; i < state.checklist.length; i++)
          i == index ? state.checklist[i].toggled() : state.checklist[i],
      ]));

  void addItem() => emit(state.copyWith(
      checklist: [...state.checklist, const ChecklistItem('عنصر جديد')]));

  void acceptLabel(String label) => emit(state.copyWith(
        labels: [...state.labels, label],
        suggestedLabels: state.suggestedLabels.where((l) => l != label).toList(),
      ));

  void rejectLabel(String label) => emit(state.copyWith(
        suggestedLabels: state.suggestedLabels.where((l) => l != label).toList(),
      ));
}
