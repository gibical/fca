
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../logic.dart';
import '../test.dart';
class VideoPlayerEditor extends StatefulWidget {
  final List<dynamic> videoUrls;

  final ScrollController scrollController;

  MediaSuitController mediaSuitController;

  VideoPlayerEditor(
      {Key? key, required this.videoUrls, required this.mediaSuitController, required this.scrollController })
      : super(key: key);

  @override
  _VideoPlayerEditorState createState() => _VideoPlayerEditorState();
}

class _VideoPlayerEditorState extends State<VideoPlayerEditor> {
  late ScrollSynchronizer scrollSynchronizer;


  double _sliderValue = 0.0;
  double actualValue = 0;
  int _currentIndex = 0;
  bool _isLoading = true;
  late BuildContext _context;
  bool isPlaying = false;
  late VideoPlayerController controllerVideo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _context = context;
  }

  @override
  void initState() {
    super.initState();


    _initializeVideo();
  }

  void _initializeVideo() async {
    controllerVideo = VideoPlayerController.network(
      widget.videoUrls[_currentIndex],
    );

    await controllerVideo.initialize();

    setState(() {
      _isLoading = false;
    });

    controllerVideo.setVolume(0.0);
    controllerVideo.play();
    controllerVideo.addListener(_onVideoControllerUpdated);
  }

  void _onVideoControllerUpdated() {
    setState(() {
      _sliderValue = controllerVideo.value.position.inSeconds.toDouble();
    });
    if (controllerVideo.value.position == controllerVideo.value.duration) {
      if (_currentIndex < widget.videoUrls.length - 1) {
        _currentIndex++;
        _showLoadingSnackbar();
        controllerVideo = VideoPlayerController.network(
          widget.videoUrls[_currentIndex],
        )
          ..initialize().then((_) {
            setState(() {
              isPlaying = true;
              _sliderValue = 0.0;
              ScaffoldMessenger.of(_context).hideCurrentSnackBar();
            });
            controllerVideo.play();
            controllerVideo.addListener(_onVideoControllerUpdated);
          });
      }
    }
  }

  void _showLoadingSnackbar() {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text('Loading...'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    controllerVideo.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlaying ? controllerVideo.pause() : controllerVideo.play();
          isPlaying = !isPlaying;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          _isLoading
              ? Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.2,
                child: CustomRulerTimelineOtherAssetsWidget1(
                  minValue: 0.0,
                  maxValue: 300,
                  value: 0,
                  majorTick: 10,

                  minorTick: 1,

                  labelValuePrecision: 0,
                  tickValuePrecision: 0,
                  onChanged: (val) {

                  },

                  activeColor: AppColor.primaryLightColor,
                  inactiveColor: AppColor.primaryLightColor.withOpacity(0.2),
                  linearStep: true,
                  totalSeconds: 300,
                  scrollController: widget.scrollController,
                  minPaddingValue: widget.mediaSuitController.minPaddingValue,
                  maxPaddingValue: widget.mediaSuitController.maxPaddingValue,
                ),
              ),
              Transform.scale(
                scale: 0.5,
                child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: CircularProgressIndicator(
                      color: AppColor.primaryLightColor,)),
              )
            ],
          )
              : AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(controllerVideo,),
          ),


          !_isLoading
              ? Listener(
            onPointerMove: (event) {
              setState(() {
                _sliderValue =
                    controllerVideo.value.position.inSeconds.toDouble();
              });
            },
            child: CustomRulerTimelineOtherAssetsWidget1(
              maxPaddingValue: widget.mediaSuitController.maxPaddingValue,
              minPaddingValue: widget.mediaSuitController.minPaddingValue,

              minValue: 0.0,
              maxValue: controllerVideo.value.duration.inSeconds.toDouble(),
              value: _sliderValue,
              majorTick: 10,

              minorTick: 1,

              labelValuePrecision: 0,

              tickValuePrecision: 0,
              onChanged: (val) {
                setState(() {
                  _sliderValue = val;
                  actualValue = val.roundToDouble();
                  print('Slider value: $_sliderValue');
                  print('Actual value: $actualValue');
                  controllerVideo.seekTo(Duration(seconds: val.toInt()));
                });
              },
              activeColor: AppColor.primaryLightColor,
              inactiveColor: AppColor.primaryLightColor.withOpacity(0.2),
              linearStep: true,
              totalSeconds: max(controllerVideo.value.duration.inSeconds.toInt(), 200),
              scrollController: widget.scrollController,
            ),
          )

              : Container(),

        ],
      ),
    );
  }

}

String formatDuration(Duration duration) {
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}


