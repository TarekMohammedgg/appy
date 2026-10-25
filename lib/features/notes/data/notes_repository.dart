import 'models/note.dart';

/// Fake for the UI phase. The real one reads the local DB (offline-first).
class NotesRepository {
  static const _notes = [
    Note(
        id: 'ideas',
        title: 'أفكار appy',
        preview: 'الشات يرد من ملاحظاتي بس، ومعاه مصادر',
        timeLabel: 'امبارح',
        group: NoteGroup.pinned),
    Note(
        id: 'meeting',
        title: 'اجتماع مشروع appy',
        preview: 'اتفقنا إن phase 1 هتبقى capture + Notion',
        timeLabel: '10:42 م',
        group: NoteGroup.today),
    Note(
        id: 'spike',
        title: 'Flutter editor spike',
        preview: 'super_editor vs fleather — أول اختبار RTL',
        timeLabel: '9:15 ص',
        group: NoteGroup.today),
    Note(
        id: 'voice',
        title: 'أفكار في الطريق',
        preview: 'تسجيل صوتي · 2:14',
        timeLabel: '8:03 ص',
        group: NoteGroup.today),
    Note(
        id: 'car',
        title: 'صيانة العربية',
        preview: 'تغيير زيت وفلتر عند الـ60 ألف',
        timeLabel: 'الثلاثاء',
        group: NoteGroup.week),
    Note(
        id: 'books',
        title: 'كتب عايز أقراها',
        preview: 'Deep Work، Atomic Habits، The Psychology of Money',
        timeLabel: 'الاثنين',
        group: NoteGroup.week),
  ];

  List<Note> notes() => _notes;

  NoteDetail detail(String id) {
    if (id == 'new') {
      return const NoteDetail(id: 'new', title: '', dateLabel: 'النهارده', body: '');
    }
    if (id == 'meeting') {
      return NoteDetail(
        id: id,
        title: 'اجتماع مشروع appy',
        dateLabel: '20 أكتوبر 2026، 10:42 م',
        body: 'اتفقنا إن phase 1 هتبقى capture + classify + sync لـNotion. '
            'الـeditor يستنى لحد ما الـspike يخلص، وأهم معيار فيه هو الـRTL.',
        checklist: const [
          ChecklistItem('أجهز Supabase project', done: true),
          ChecklistItem('أجرّب STT على تسجيلات مصري'),
          ChecklistItem('أكتب الـschema بتاع الـnotes'),
        ],
        audio: const AudioClip(
          duration: '2:14',
          transcript: 'محتاجين نقرر الأول هنستخدم أنهي editor، وبعدين نبدأ في الـsync. '
              'الـNotion API بطيء فلازم يبقى فيه queue.',
        ),
        labels: const ['appy'],
        suggestedLabels: const ['اجتماعات', 'Supabase'],
        related: [_notes[2], _notes[0]],
      );
    }
    final note = _notes.firstWhere((n) => n.id == id, orElse: () => _notes.first);
    return NoteDetail(
      id: note.id,
      title: note.title,
      dateLabel: note.timeLabel,
      body: note.preview,
      labels: const ['appy'],
    );
  }
}
