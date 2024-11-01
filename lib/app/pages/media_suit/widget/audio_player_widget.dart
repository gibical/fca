


import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';

import '../logic.dart';
class AudioPlayerWidget extends StatefulWidget {


  final String urlAudio;

  const AudioPlayerWidget({required this.urlAudio, Key? key}) : super(key: key);
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  String _generateRandomString(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;
  late File file;
  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();

    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      controller.startPlayer(finishMode: FinishMode.loop);
      setState(() {});
    });
  }


  void _preparePlayer() async {
    // Sending request to server to get audio file
    dio.Response response = await dio.Dio().get(
      widget.urlAudio,
      options: dio.Options(responseType: dio.ResponseType.bytes),
    );

    // Get temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String randomName = _generateRandomString(8);
    // Saving received audio file in temporary directory
    File file = File('${tempDir.path}/mediavers-$randomName.mp3');
    await file.writeAsBytes(response.data);

    // Prepare player with extracting waveform
    controller.preparePlayer(
      path: file.path,
      shouldExtractWaveform: true,
    );
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        AudioFileWaveforms(
          size: Size(MediaQuery.of(context).size.width, 100.0),
          playerController: controller,
          enableSeekGesture: true,


          waveformType: WaveformType.long,
          waveformData: [],
          playerWaveStyle: playerWaveStyle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              DurationAudio.formtTime(Duration(milliseconds: controller.maxDuration)),
              textAlign: TextAlign.center,

            ),
          ),
        ),
      ],
    );
  }
}



