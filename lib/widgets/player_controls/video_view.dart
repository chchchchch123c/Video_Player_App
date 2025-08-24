import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/player_controls/components/dimmed_overlay.dart';
import 'package:video_play_app/widgets/player_controls/components/double_speed_banner.dart';
import 'package:video_play_app/widgets/player_controls/components/orientation_button.dart';
import 'package:video_play_app/widgets/player_controls/components/play_button.dart';
import 'package:video_play_app/widgets/player_controls/components/setting/setting_button.dart';
import 'package:video_play_app/widgets/ripple/ripple_zone.dart';
import 'package:video_play_app/widgets/player_controls/components/seek_slider.dart';
import 'package:video_play_app/widgets/player_controls/components/time_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isVideoEnded;
  final VoidCallback onEndReset;
  final bool isShow;
  final VoidCallback onShowTap;
  final VoidCallback onPlayPressed;
  final VoidCallback onForceHide;
  final VoidCallback onLongPress;
  final void Function(LongPressEndDetails) onLongPressEnd;
  final bool isiDoubleSpeed;
  final VoidCallback onFullScreenToggle;
  final VoidCallback onSettingPress;
  final VoidCallback onSkipPrevious;
  final VoidCallback onSkipNext;
  final bool canSkipPrev;
  final bool canSkipNext;
  final bool showVideoLayer;

  const VideoView({
    super.key,
    required this.controller,
    required this.isVideoEnded,
    required this.onEndReset,
    required this.isShow,
    required this.onShowTap,
    required this.onPlayPressed,
    required this.onForceHide,
    required this.onLongPress,
    required this.onLongPressEnd,
    required this.isiDoubleSpeed,
    required this.onFullScreenToggle,
    required this.onSettingPress,
    required this.onSkipPrevious,
    required this.onSkipNext,
    required this.canSkipPrev,
    required this.canSkipNext,
    required this.showVideoLayer,
  });

  @override
  Widget build(BuildContext context) {
    final initialized = controller.value.isInitialized;
    final aspect = initialized ? controller.value.aspectRatio : (16 / 9);

    return GestureDetector(
      onTap: onShowTap,
      child: AspectRatio(
        aspectRatio: aspect,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (showVideoLayer && initialized)
              VideoPlayer(
                controller,
                key: ValueKey(controller),
              )
            else
              const ColoredBox(color: Colors.black),
            DimmedOverlay(isShow: isShow),
            RippleZone(
              controller: controller,
              isShow: isShow,
              onForceHide: onForceHide,
              onLongPress: onLongPress,
              onLongPressEnd: onLongPressEnd,
            ),
            Positioned(
              top: 0,
              child: DoubleSpeedBanner(isVisible: isiDoubleSpeed),
            ),
            Positioned(
              bottom: 32,
              left: 18,
              child: TimeIndicator(
                controller: controller,
                isShow: isShow,
              ),
            ),
            Positioned(
              left: -6,
              right: 16,
              bottom: 0,
              child: SeekSlider(
                controller: controller,
                isShow: isShow,
              ),
            ),
            Positioned(
              bottom: 0,
              right: -4,
              child: OrientationButton(
                isShow: isShow,
                onFullScreenToggle: onFullScreenToggle,
              ),
            ),
            PlayButton(
              controller: controller,
              isVideoEnded: isVideoEnded,
              onReplayPressed: onEndReset,
              isShow: isShow,
              onPlayPressed: onPlayPressed,
              onSkipPrevious: onSkipPrevious,
              onSkipNext: onSkipNext,
              canSkipPrev: canSkipPrev,
              canSkipNext: canSkipNext,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SettingButton(
                isShow: isShow,
                onSettingPress: onSettingPress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
