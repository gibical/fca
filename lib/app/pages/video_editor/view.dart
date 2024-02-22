import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediaverse/app/pages/video_editor/widgets/crop_page.dart';
import 'package:mediaverse/app/pages/video_editor/widgets/export_service.dart';

import 'package:video_editor/video_editor.dart';

import 'package:video_player/video_player.dart';




class VideoEditorScreen extends StatefulWidget {
  const VideoEditorScreen({super.key});

  @override
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  final ImagePicker _picker = ImagePicker();

  void _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);

    if (mounted && file != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => VideoEditor(file: File(file.path)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Picker")),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Click on the button to select video"),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text("Pick Video From Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------//
//VIDEO EDITOR SCREEN//
//-------------------//
class VideoEditor extends StatefulWidget {
  const VideoEditor({super.key, required this.file});

  final File file;

  @override
  State<VideoEditor> createState() => _VideoEditorState();
}

class _VideoEditorState extends State<VideoEditor> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  late final VideoEditorController _controller = VideoEditorController.file(
    widget.file,
    minDuration: const Duration(seconds: 1),
    maxDuration: const Duration(seconds: 30),
  );

  @override
  void initState() {
    super.initState();
    _controller
        .initialize(aspectRatio: 9 / 16)
        .then((_) => setState(() {}))
        .catchError((error) {
      // handle minumum duration bigger than video duration error
      Navigator.pop(context);
    }, test: (e) => e is VideoMinDurationError);
  }

  @override
  void dispose() async {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    ExportService.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  void _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;

    final config = VideoFFmpegVideoEditorConfig(
      _controller,
      format: VideoExportFormat.mp4,
      commandBuilder: (config, videoPath, outputPath) {
        final List<String> filters = config.getExportFilters();
        filters.add('hflip'); // add horizontal flip

        return '-i $videoPath ${config.filtersCmd(filters)} -preset ultrafast $outputPath';
      },
    );

    await ExportService.runFFmpegCommand(
      await config.getExecuteConfig(),
      onProgress: (stats) {
         _exportingProgress.value = config.getFFmpegProgress(stats.getTime());
      },
      onError: (e, s) => _showErrorSnackBar("Error on export video :("),
      onCompleted: (file) {
        _isExporting.value = false;
        if (!mounted) return;

        // showDialog(
        //   context: context,
        //   builder: (_) => VideoResultPopup(video: file),
        // );
      },
    );
  }

  void _exportCover() async {
    final config = CoverFFmpegVideoEditorConfig(_controller);
    final execute = await config.getExecuteConfig();
    if (execute == null) {
      _showErrorSnackBar("Error on cover exportation initialization.");
      return;
    }

    await ExportService.runFFmpegCommand(
      execute,
      onError: (e, s) => _showErrorSnackBar("Error on cover exportation :("),
      onCompleted: (cover) {
        if (!mounted) return;

        // showDialog(
        //   context: context,
        //   builder: (_) => CoverResultPopup(cover: cover),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _controller.initialized
            ? SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 230,
                  color: Color(0xff000033),
                  child: Stack(
                    children: [
                      Container(
                        height: 230,

                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 1,

                              width: double.infinity,
                            ),
                            Container(
                              height: 1,
                              color: Colors.red,
                              width: double.infinity,
                            ),
                            Container(
                              height: 1,
                              color: Colors.white.withOpacity(0.4),
                              width: double.infinity,
                            ),
                            Container(
                              height: 1,
                              color: Colors.white.withOpacity(0.4),
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: _trimSlider(),
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _topNavBar() {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Leave editor',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.left),
                icon: const Icon(Icons.rotate_left),
                tooltip: 'Rotate unclockwise',
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.right),
                icon: const Icon(Icons.rotate_right),
                tooltip: 'Rotate clockwise',
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => CropPage(controller: _controller),
                  ),
                ),
                icon: const Icon(Icons.crop),
                tooltip: 'Open crop screen',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: PopupMenuButton(
                tooltip: 'Open export menu',
                icon: const Icon(Icons.save),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: _exportCover,
                    child: const Text('Export cover'),
                  ),
                  PopupMenuItem(
                    onTap: _exportVideo,
                    child: const Text('Export video'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatter(Duration duration) => [
    duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
    duration.inSeconds.remainder(60).toString().padLeft(2, '0')
  ].join(":");

  List<Widget> _trimSlider() {
    return [
      // AnimatedBuilder(
      //   animation: Listenable.merge([
      //     _controller,
      //     _controller.video,
      //   ]),
      //   builder: (_, __) {
      //     final int duration = _controller.videoDuration.inSeconds;
      //     final double pos = _controller.trimPosition * duration;
      //
      //     return Padding(
      //       padding: EdgeInsets.symmetric(horizontal: height / 4),
      //       child: Row(children: [
      //         Text(formatter(Duration(seconds: pos.toInt()))),
      //         const Expanded(child: SizedBox()),
      //         AnimatedOpacity(
      //           opacity: _controller.isTrimming ? 1 : 0,
      //           duration: kThemeAnimationDuration,
      //           child: Row(mainAxisSize: MainAxisSize.min, children: [
      //             Text(formatter(_controller.startTrim)),
      //             const SizedBox(width: 10),
      //             Text(formatter(_controller.endTrim)),
      //           ]),
      //         ),
      //       ]),
      //     );
      //   },
      // ),

      Row(
        children: [
          Expanded(
            child: TrimTimeline(

              controller: _controller,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 11
              ),
              padding: const EdgeInsets.only(top: 12, left: 10 , right: 10 ),

            ),
          ),
        ],
      ),
      // SizedBox(
      //   height: 15,
      // ),

      Container(

        width: MediaQuery.of(context).size.width,


        child: TrimSlider(
          controller: _controller,
          height: 100,


        ),
      )
    ];
  }

  Widget _coverSelection() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: CoverSelection(
            controller: _controller,
            size: height + 10,
            quantity: 8,
            selectedCoverBuilder: (cover, size) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  cover,
                  Icon(
                    Icons.check_circle,
                    color: const CoverSelectionStyle().selectedBorderColor,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}