sealed class ChatMessage {
  const ChatMessage(this.id);
  final String id;
}

class UserMessage extends ChatMessage {
  const UserMessage(super.id, this.text);
  final String text;
}

/// Answer built only from the user's notes. Every claim points to a [Source].
class AnswerMessage extends ChatMessage {
  const AnswerMessage(super.id, {required this.parts, required this.sources});
  final List<AnswerPart> parts;
  final List<Source> sources;
}

/// A run of answer text, optionally followed by a citation badge.
class AnswerPart {
  const AnswerPart(this.text, {this.citation});
  final String text;

  /// 1-based index into [AnswerMessage.sources].
  final int? citation;
}

class Source {
  const Source({required this.noteId, required this.title, required this.dateLabel});
  final String noteId;
  final String title;
  final String dateLabel;
}

/// Chat input that was saved (expense, task, note) instead of answered.
class CaptureMessage extends ChatMessage {
  const CaptureMessage(super.id, {required this.title, required this.body});
  final String title;
  final String body;
}

/// Retrieval found nothing in the notes.
class NoAnswerMessage extends ChatMessage {
  const NoAnswerMessage(super.id);
}
