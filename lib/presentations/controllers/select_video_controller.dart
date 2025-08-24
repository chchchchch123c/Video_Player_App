import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_play_app/constant/url.dart';
import 'package:video_play_app/presentations/controllers/home_screen_controller.dart';
import 'package:video_play_app/presentations/screens/home_screen.dart';
import 'package:video_play_app/widgets/select_controls/help_dialog.dart';

class SelectVideoController extends ChangeNotifier {
  final Uri _url = Uri.parse(githubUrl);

  Future<void> pickMultipleVideos(BuildContext context) async {
    final XFile? picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picked == null) return;

    final pickedName = basename(picked.path).toLowerCase();

    final PermissionRequestOption reqOpt = const PermissionRequestOption(
      androidPermission: AndroidPermission(type: RequestType.video, mediaLocation: false),
    );
    final PermissionState ps = await PhotoManager.requestPermissionExtend(requestOption: reqOpt);

    bool allowed;
    try {
      allowed = ps.hasAccess;
    } catch (_) {
      allowed = ps == PermissionState.authorized || ps == PermissionState.limited;
    }

    final List<_LibItem> items = [];
    if (allowed) {
      try {
        final paths = await PhotoManager.getAssetPathList(
          type: RequestType.video,
          onlyAll: true,
        );
        if (paths.isNotEmpty) {
          final all = paths.first;
          final assets = await all.getAssetListRange(start: 0, end: 200);
          final seenNames = <String>{};
          for (final a in assets) {
            String? src;
            final f = await a.file;
            if (f != null) {
              src = f.path;
            } else {
              final uri = await a.getMediaUrl();
              if (uri != null) src = uri;
            }
            if (src == null) continue;
            final name = (f != null ? basename(f.path) : (a.title ?? 'video_${a.id}')).toLowerCase();
            if (seenNames.add(name)) {
              items.add(_LibItem(src, name));
            }
          }
        }
      } catch (_) {}
    }

    int startIndex = 0;
    int matchIdx = items.indexWhere((it) => it.name == pickedName);
    if (matchIdx == -1) {
      final stemPicked = basenameWithoutExtension(picked.path).toLowerCase();
      matchIdx = items.indexWhere((it) {
        final stem = it.name.contains('.') ? it.name.substring(0, it.name.lastIndexOf('.')) : it.name;
        return stem.contains(stemPicked) || stemPicked.contains(stem);
      });
    }

    late final List<XFile> videos;
    if (matchIdx != -1) {
      startIndex = matchIdx;
      videos = [for (final it in items) XFile(it.src)];
    } else {
      videos = [XFile(picked.path), ...[for (final it in items) XFile(it.src)]];
      startIndex = 0;
    }

    final controller = HomeScreenController();
    controller.setVideoList(videos, startIndex: startIndex);
    await controller.initAndPlay(videos[startIndex].path);

    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          controller: controller,
          pickedVideo: videos[startIndex],
        ),
      ),
    );
  }

  Future<void> urlLauncher() async {
    if (await canLaunchUrl(_url) && !await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> onHelpTap(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return HelpDialog(onLaunchUrl: urlLauncher);
      },
    );
  }
}

class _LibItem {
  final String src;
  final String name;
  const _LibItem(this.src, this.name);
}
