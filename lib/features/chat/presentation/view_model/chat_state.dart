import '../../data/models/chat_message.dart';

class ChatState {
  const ChatState({
    this.messages = const [],
    this.thinking = false,
    this.webSearch = false,
  });

  final List<ChatMessage> messages;

  /// Waiting for a reply (shows the three-dot pulse).
  final bool thinking;

  /// Web search runs only while this is on.
  final bool webSearch;

  ChatState copyWith({List<ChatMessage>? messages, bool? thinking, bool? webSearch}) =>
      ChatState(
        messages: messages ?? this.messages,
        thinking: thinking ?? this.thinking,
        webSearch: webSearch ?? this.webSearch,
      );
}
