  import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

final GlobalKey globalKey = GlobalKey();



Future<void> capturePng({required String pathName,required BuildContext context}) async {
  try {

    await Future.delayed(const Duration(milliseconds: 50));

    final boundary = globalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData =
        await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) return;

    final pngBytes = byteData.buffer.asUint8List();

    // Use TEMP directory (important for iOS)
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/status.png';

    final file = File(path);
    await file.writeAsBytes(pngBytes, flush: true);

    // Small delay before sharing (important on iOS)
    await Future.delayed(const Duration(milliseconds: 50));

    // 🔥 REQUIRED FOR iOS (even iPhone sometimes)
    final renderBox = context.findRenderObject() as RenderBox?;

    Rect origin;
    if (renderBox != null && renderBox.hasSize) {
      origin = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    } else {
      final size = MediaQuery.of(context).size;
      origin = Rect.fromLTWH(
        size.width / 2,
        size.height / 2,
        1,
        1,
      );
    }

    await Share.shareXFiles(
      [XFile(file.path)],
      text: ' ',
      sharePositionOrigin: origin,
    );
  } catch (e) {
    debugPrint("Share error: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to share image')),
    );
  }
}
