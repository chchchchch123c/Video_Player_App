import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';

class HelpDialog extends StatelessWidget {
  final VoidCallback onLaunchUrl;

  const HelpDialog({super.key, required this.onLaunchUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: kWhite,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minWidth: 360,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Text(
                'VideoPlayer Guide',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _SectionTitle('Getting Started'),
                    _Bullet('On the Select screen, tap “Load a video” to choose a video.'),
                    _Bullet('To use Previous/Next, allow Photos/Videos permission. If permission is denied or only one video exists, the buttons are disabled.'),
                    SizedBox(height: 14),
                    _SectionTitle('Playback Controls'),
                    _Bullet('Tap anywhere: show/hide controls. While playing, controls auto-hide after ~2.6s.'),
                    _Bullet('Center button: Play/Pause. When the video ends, the icon turns into Replay.'),
                    _Bullet('Left/Right arrows: Go to previous/next video. Disabled at the first/last item.'),
                    _Bullet('Seek bar: Drag to scrub. Current/total time is shown on the left.'),
                    SizedBox(height: 14),
                    _SectionTitle('Speed & Gestures'),
                    _Bullet('Long press: 2× speed while pressed, returns to 1× when released. A banner appears at the top.'),
                    _Bullet('Settings (gear): Choose fixed speed (0.5×, 1.0×, 1.5×, 2.0×) and toggle Loop.'),
                    SizedBox(height: 14),
                    _SectionTitle('Full Screen'),
                    _Bullet('Use the bottom-right fullscreen button to enter/exit landscape. Back button first exits fullscreen.'),
                    SizedBox(height: 14),
                    _SectionTitle('How Previous/Next Works'),
                    _Bullet('Builds a recent videos list from the device library starting from the initially selected video.'),
                    _Bullet('Duplicate entries are removed; navigation moves relative to the selected position.'),
                    _Bullet('If only one item exists, Previous/Next is disabled.'),
                    SizedBox(height: 14),
                    _SectionTitle('Troubleshooting'),
                    _Bullet('If controls are hidden, tap the screen once.'),
                    _Bullet('If Previous/Next is disabled: grant permission and make sure multiple videos exist on the device.'),
                    _Bullet('If playback stalls, press Play/Pause again.'),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: onLaunchUrl,
                    icon: const Icon(Icons.open_in_new, color: kBlack),
                    label: const Text('Learn more', style: TextStyle(color: kBlack)),
                  ),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: kBlack),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.85);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  '),
          Expanded(child: Text(text, style: TextStyle(color: color, height: 1.35))),
        ],
      ),
    );
  }
}
