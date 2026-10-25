import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/chat_repository.dart';
import '../../data/models/chat_message.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._repository) : super(const ChatState());

  final ChatRepository _repository;

  List<String> get suggestions => _repository.suggestions;

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.thinking) return;
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    emit(state.copyWith(
      messages: [...state.messages, UserMessage(id, trimmed)],
      thinking: true,
    ));
    final reply = await _repository.reply(trimmed);
    if (isClosed) return;
    emit(state.copyWith(messages: [...state.messages, reply], thinking: false));
  }

  void toggleWebSearch() => emit(state.copyWith(webSearch: !state.webSearch));

  /// Undo on a capture card removes what was saved.
  void undo(String messageId) => emit(state.copyWith(
        messages: state.messages.where((m) => m.id != messageId).toList(),
      ));
}
