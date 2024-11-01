

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:mediaverse/app/pages/detail/widgets/image_full_screen_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_icon.dart';

class CustomAppBarVideoAndImageDetailWidget extends StatelessWidget {
   CustomAppBarVideoAndImageDetailWidget({
    super.key,
    required this.selectedItem, required this.isVideo,required this.detailController,
  });

   DetailController detailController;
  final  selectedItem;
  final bool isVideo;
  String imageURL = "";

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    try {
      imageProvider = NetworkImage(detailController.imageDetails?['file']?['url']);//
      imageURL = detailController.imageDetails?['file']?['url'];
    } catch (e) {

      imageProvider = AssetImage('assets/${F.assetTitle}/images/tum_image.jpeg');
    }


    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
         isVideo ? showDialog(
            context: context,
            builder: (BuildContext context) {
             return VideoDialog(videoUrl: selectedItem['file']?['url'],controller: detailController,);
            }) : showDialog(
             context: context,
             builder: (BuildContext context) {
               return FullScreenDialogWidget(detailController.imageDetails?['file']?['url']);
             });



        },
        child: Stack(
          children: [
            Container(
              height: 27.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp), bottomRight: Radius.circular(25.sp)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: isVideo ? Transform.scale(
                scale: 0.15,
                child: SvgPicture.asset(AppIcon.playIcon),
              ) : Opacity(opacity: 0),
            ),

            Container(
              height: 27.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp) , bottomRight: Radius.circular(25.sp)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.66),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,

                      ])

              ),
            ),
            Positioned(
                bottom: 15,
                left: 25,
                child: SvgPicture.asset(isVideo ? AppIcon.videoIcon : AppIcon.imageIcon , color: Colors.white60,))
          ],
        ),
      ),
    );
  }
}



class VideoDialog extends StatefulWidget {
  final String videoUrl;
   VideoDialog({Key? key, required this.videoUrl, required this.controller}) : super(key: key);
  final DetailController controller;

  @override
  _VideoDialogState createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  late VideoPlayerController _controller;
  late bool _isPlaying;
  double _sliderValue = 0.0;

  var chewieController ;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      '${widget.videoUrl}',
    )..initialize().then((_) {
      chewieController= ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: true,
        showOptions: false
      );
      setState(() {
        //     _isPlaying = true;
      });
      //   _controller.play();
    });
    // _isPlaying = false;
    // _controller.addListener(() {
    //   setState(() {
    //     _sliderValue = _controller.value.position.inSeconds.toDouble();
    //   });
    // });
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
      child: Stack(
        alignment: Alignment.center,
        children: [



    _controller.value.isInitialized  ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Screenshot(
                    controller: widget.controller.screenshotController,
                    child:  Chewie(
                      controller: chewieController,
                    )
                ),
              ),

      ],
    ) : CircularProgressIndicator(),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    try {
                      _controller.pause();
                    }  catch (e) {
                      // TODO
                    }

                  Get.back();
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/${F.assetTitle}/icons/icon__screenshot.svg",
                    width: 6.w,
                  ),
                  color: Colors.white,
                  onPressed: () {

                    widget.controller.secondsTimeVideoToImage = _controller.value.position.inSeconds;
                    widget.controller.videoConvertToImage();
                    print( widget.controller.secondsTimeVideoToImage);
                  },
                ),


              ],
            ),
          ),


        ],
      ),
    );
  }
}


