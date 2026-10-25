enum NoteGroup { pinned, today, week }

class Note {
  const Note({
    required this.id,
    required this.title,
    required this.preview,
    required this.timeLabel,
    required this.group,
  });

  final String id;
  final String title;
  final String preview;
  final String timeLabel;
  final NoteGroup group;
}

class ChecklistItem {
  const ChecklistItem(this.text, {this.done = false});
  final String text;
  final bool done;

  ChecklistItem toggled() => ChecklistItem(text, done: !done);
}

class AudioClip {
  const AudioClip({required this.duration, required this.transcript});
  final String duration;
  final String transcript;
}

/// Everything the editor shows for one note.
class NoteDetail {
  const NoteDetail({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.body,
    this.checklist = const [],
    this.audio,
    this.labels = const [],
    this.suggestedLabels = const [],
    this.related = const [],
  });

  final String id;
  final String title;
  final String dateLabel;
  final String body;
  final List<ChecklistItem> checklist;
  final AudioClip? audio;

  /// Accepted labels.
  final List<String> labels;

  /// AI suggestions, shown dashed until accepted.
  final List<String> suggestedLabels;
  final List<Note> related;

  NoteDetail copyWith({
    String? title,
    String? body,
    List<ChecklistItem>? checklist,
    List<String>? labels,
    List<String>? suggestedLabels,
  }) =>
      NoteDetail(
        id: id,
        title: title ?? this.title,
        dateLabel: dateLabel,
        body: body ?? this.body,
        checklist: checklist ?? this.checklist,
        audio: audio,
        labels: labels ?? this.labels,
        suggestedLabels: suggestedLabels ?? this.suggestedLabels,
        related: related,
      );
}
