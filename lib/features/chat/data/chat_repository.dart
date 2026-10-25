import 'models/chat_message.dart';

/// Fake for the UI phase. The real one calls the chat agent (Edge Function).
class ChatRepository {
  List<String> get suggestions => const [
        'إيه اللي اتفقنا عليه في اجتماع appy؟',
        'دفعت 150 بنزين',
        'أحسن مطعم سوشي في المعادي؟',
      ];

  // ponytail: keyword-scripted replies so every chat state is reachable in the
  // UI; replaced by the agent call in the logic phase.
  Future<ChatMessage> reply(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final id = DateTime.now().microsecondsSinceEpoch.toString();

    if (text.contains('دفعت')) {
      final amount = RegExp(r'\d+').firstMatch(text)?.group(0) ?? '0';
      return CaptureMessage(id,
          title: 'اتسجل في المصاريف', body: '$amount ج · مواصلات · النهارده');
    }
    if (text.contains('اجتماع') || text.contains('مهام')) {
      return AnswerMessage(id, parts: const [
        AnswerPart(
            'اتفقتوا إن أول phase هتبقى capture + sync لـNotion، والـeditor يستنى لحد ما الـspike يخلص',
            citation: 1),
        AnswerPart('، وإنت هتجهز الـSupabase project قبل الخميس', citation: 2),
      ], sources: const [
        Source(noteId: 'meeting', title: 'اجتماع مشروع appy', dateLabel: '20 أكتوبر'),
        Source(noteId: 'week', title: 'مهام الأسبوع', dateLabel: '22 أكتوبر'),
      ]);
    }
    return NoAnswerMessage(id);
  }
}
