import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/models/note.dart';

/// Audio card (play, waveform, duration) with a collapsible transcript.
class AudioAttachment extends StatefulWidget {
  const AudioAttachment(this.clip, {super.key});

  final AudioClip clip;

  @override
  State<AudioAttachment> createState() => _AudioAttachmentState();
}

class _AudioAttachmentState extends State<AudioAttachment> {
  bool _playing = false;
  bool _showTranscript = false;

  static const List<double> _bars = [
    6, 12, 18, 10, 22, 16, 8, 20, 26, 14, 10, 18, 24, 12, 6, 16, 22, 18, 10,
    8, 14, 20, 12, 6, 10, 16, 8, 12,
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final progress = _playing ? 0.35 : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 64,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: c.raised,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            spacing: 12,
            children: [
              Semantics(
                button: true,
                label: _playing ? 'إيقاف مؤقت' : 'تشغيل',
                excludeSemantics: true,
                child: GestureDetector(
                  onTap: () => setState(() => _playing = !_playing),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
                    child: Icon(
                        _playing ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill,
                        size: 18,
                        color: c.onAccent),
                  ),
                ),
              ),
              Expanded(
                child: ExcludeSemantics(
                  child: Row(
                    children: [
                      for (var i = 0; i < _bars.length; i++)
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 3,
                              height: _bars[i],
                              decoration: BoxDecoration(
                                color: i / _bars.length < progress ? c.accent : c.grey3,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Text(widget.clip.duration,
                  style: AppText.footnote.copyWith(
                      color: c.ink2,
                      fontFeatures: const [FontFeature.tabularFigures()])),
            ],
          ),
        ),
        Pressable(
          onTap: () => setState(() => _showTranscript = !_showTranscript),
          child: SizedBox(
            height: 40,
            child: Row(
              spacing: 4,
              children: [
                Text('النص المكتوب', style: AppText.subhead.copyWith(color: c.ink2)),
                AnimatedRotation(
                  turns: _showTranscript ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(CupertinoIcons.chevron_down, size: 14, color: c.ink2),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          alignment: AlignmentDirectional.topStart,
          child: _showTranscript
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(widget.clip.transcript,
                      style: AppText.subhead.copyWith(color: c.ink)),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
