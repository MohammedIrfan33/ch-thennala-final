import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chcenterthennala/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PosterShareWidget extends StatefulWidget {
  final String name;
  final String imagePath;
  final Color nameColor;

  /// 🔹 Position config (0.0 - 1.0)
  final double nameTopFactor;
  final double nameLeftFactor;
  final double nameWidthFactor;
  final double  ? marginRigt;
  final double  ? width;
  

  const PosterShareWidget({
    super.key,
    required this.name,
    required this.imagePath,
    this.nameTopFactor = 0.34,
    this.nameLeftFactor = 0.11,
    this.nameWidthFactor = 0.55,
    this.nameColor = Colors.white,
    
    this.marginRigt, this.width,
    

    
  });

  @override
  State<PosterShareWidget> createState() => _PosterShareWidgetState();
}

class _PosterShareWidgetState extends State<PosterShareWidget> {
  final GlobalKey _captureKey = GlobalKey();
  bool _isSharing = false;


  /// Capture & Share Poster
  Future<void> _sharePoster(BuildContext context) async {
     if (_isSharing) return;

  setState(() {
    _isSharing = true;
  });

    try {
      await Future.delayed(const Duration(milliseconds: 50));

      final boundary =
          _captureKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/poster.png');

      await file.writeAsBytes(bytes);

      final box = context.findRenderObject() as RenderBox?;
      final origin = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : const Rect.fromLTWH(0, 0, 1, 1);

      await Share.shareXFiles([XFile(file.path)], sharePositionOrigin: origin);

    } catch (e) {
      debugPrint('Share error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to share image')));
    }finally {
    setState(() {
      _isSharing = false;
    });
  }
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 53,
              height: 53,
              margin: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset(
                  'assets/backarrow_s.svg',
                  width: 22,
                  height: 22,
                  semanticsLabel: 'Example SVG',
                ),
              ),
            ),
            const Center(
              child: Text(
                'Poster',
                style: TextStyle(
                  color: Color(0xFF3A3A3A),
                  fontSize: 14,
                  fontFamily: 'Fontsemibold',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
                textScaleFactor: 1.0,
              ),
            ),
            Container(
              width: 53,
              height: 53,
              margin: const EdgeInsets.only(right: 20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFEDF4FC)),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(8),
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset(
                  'assets/home.svg',
                  width: 18,
                  height: 20,
                  semanticsLabel: 'Example SVG',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posterWidth = MediaQuery.of(context).size.width * 0.85;
    final posterHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),

          /// Poster
          RepaintBoundary(
            key: _captureKey,
            child: SizedBox(
              width: posterWidth,
              height: posterHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        fit: BoxFit.cover,
                      ),

                      /// Name (relative positioning)
                      Positioned(
                        bottom: constraints.maxHeight * widget.nameTopFactor,
                        right: 0,
                        
                        

                        child: Container(
                          width: widget.width?? 220.w,
                       
                          margin: EdgeInsets.only(right:widget.marginRigt ?? 10.w),
                        
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            widget.name,

                            maxLines: 1,
                            minFontSize: 13,
                            maxFontSize: 18,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.nameColor,
                              overflow: TextOverflow.ellipsis,
                              shadows: const [
                                Shadow(
                                  offset: Offset(0, 1.5), 
                                  blurRadius: 3, 
                                  color: Colors.black38, 
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 50),

          /// Gradient Share Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height * 0.065).clamp(
                44,
                56,
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.0, 0.0),
                    end: Alignment(-1.0, 0.0),
                    colors: [AppColors.primaryColor, AppColors.primaryColor],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: ElevatedButton(
  onPressed: _isSharing ? null : () => _sharePoster(context),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
    ),
  ),
  child: _isSharing
      ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
      : const Text(
          'Share',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
),

            
              ),
            ),
          ),
        ],
      ),
    );
  }
}
