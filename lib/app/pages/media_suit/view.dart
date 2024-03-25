import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/pages/profile/view.dart';
import 'package:video_player/video_player.dart';

import '../../common/app_color.dart';
import '../detail/logic.dart';
import 'logic.dart';


class MediaSuitScreen extends StatefulWidget {
  const MediaSuitScreen({super.key});

  @override
  State<MediaSuitScreen> createState() => _MediaSuitScreenState();
}

class _MediaSuitScreenState extends State<MediaSuitScreen> {

  @override
  Widget build(BuildContext context) {



    final h = MediaQuery.of(context).size.height;
    final editorController = Get.find<MediaSuitController>();
    final w = MediaQuery.of(context).size.width;



    return Scaffold(

      backgroundColor: Color(0xff000033),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              bottom: h * 0.17,
              left: 0,
              right: 0,
              child: SizedBox(
                  width: w,
                  child: SvgPicture.asset('assets/images/line_editor.svg' , fit:BoxFit.cover,))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: h * 0.27,
                //
                //     decoration: BoxDecoration(
                //         color: AppColor.primaryLightColor.withOpacity(0.6),
                //         borderRadius: BorderRadius.circular(18)
                //     ),
                //
                //   ),
                // ),
                // ,


          Obx(() =>     editorController.editVideoDataList.isNotEmpty ?  VideoPlayerEditor(
            key: UniqueKey(),
            videoUrls: editorController.editVideoDataList
                .map((editDataModel) => editDataModel.urlVideo)
                .toList(),
          ):SizedBox()),


                SizedBox(height: h * 0.1),
                Container(
                  height: h * 0.3,
                  color: Color(0xff000033),

                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 1,

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

                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                            width: double.infinity,
                          ),
                        ],
                      ),
                      //Video Time Line
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.08 -4.5),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editVideoDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editVideoDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.deepPurple,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.13 -4.5),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editAudioDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editAudioDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.orange.shade400,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.18 -4.5 ),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editImageDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editImageDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.redAccent,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.22 + 4.5),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editTextDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editTextDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.lightGreen,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),


                    ],
                  ),
                ),

                SizedBox(height: h * 0.02),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){

                        Get.to(ProfileScreen() , arguments: 'edit_screen');
                      },
                          icon: Icon(Icons.add , size: 27,)),
                      IconButton(onPressed: (){      print('menu');},
                          icon: SvgPicture.asset('assets/icons/menu_editor.svg')),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        width: w,
                        child: SvgPicture.asset('assets/images/box_editor.svg' , fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          IconButton(onPressed: (){
                            Get.back();
                          },
                              icon: Icon(Icons.close , size: 27,)),
                          IconButton(onPressed: (){


                            print(editorController.editVideoDataList.map((editDataModel) => editDataModel.urlVideo));
                          },
                              icon: Icon(Icons.done ,  size: 27)),


                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),


        ],
      ),
    );
  }
}



class VideoPlayerEditor extends StatefulWidget {
  final List<dynamic> videoUrls;
  VideoPlayerEditor({Key? key, required this.videoUrls}) : super(key: key);

  @override
  _VideoPlayerEditorState createState() => _VideoPlayerEditorState();
}

class _VideoPlayerEditorState extends State<VideoPlayerEditor> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  double _sliderValue = 0.0;
  int _currentIndex = 0;
  bool _isLoading = true;
  late BuildContext _context;

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
    _controller = VideoPlayerController.network(
      widget.videoUrls[_currentIndex],
    );

    await _controller.initialize();

    setState(() {
      _isLoading = false;
    });

    _controller.play();
    _controller.addListener(_onVideoControllerUpdated);
  }

  void _onVideoControllerUpdated() {
    setState(() {
      _sliderValue = _controller.value.position.inSeconds.toDouble();
    });
    if (_controller.value.position == _controller.value.duration) {
      if (_currentIndex < widget.videoUrls.length - 1) {
        _currentIndex++;
        _showLoadingSnackbar();
        _controller = VideoPlayerController.network(
          widget.videoUrls[_currentIndex],
        )..initialize().then((_) {
          setState(() {
            _isPlaying = true;
            _sliderValue = 0.0;
            ScaffoldMessenger.of(_context).hideCurrentSnackBar();
          });
          _controller.play();
          _controller.addListener(_onVideoControllerUpdated);
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPlaying ? _controller.pause() : _controller.play();
          _isPlaying = !_isPlaying;
        });
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? CircularProgressIndicator()
                : AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            !_isLoading
                ? Material(
              child: Slider(
                value: _sliderValue,
                min: 0.0,
                max: _controller.value.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                    _controller.seekTo(Duration(seconds: value.toInt()));
                  });
                },
              ),
            )
                : Container(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    if (_isPlaying) {
                      _controller.pause();
                    }
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isPlaying ? _controller.pause() : _controller.play();
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}






