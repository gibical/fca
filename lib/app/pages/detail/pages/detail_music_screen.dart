import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/detail/widgets/report_botton_sheet.dart';
import 'package:mediaverse/app/pages/detail/widgets/youtube_bottomsheet.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_config.dart';
import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../../common/utils/duraton_music_helper.dart';
import '../../../common/widgets/appbar_btn.dart';
import '../../media_suit/logic.dart';
import '../logic.dart';
import '../widgets/back_widget.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/details_bottom_widget.dart';
import '../widgets/player/player.dart';
import 'detail_video_screen.dart';


class DetailMusicScreen extends StatelessWidget {
  DetailMusicScreen({super.key});

  final logic = Get.put(DetailController(3),
      tag: "${DateTime.now().microsecondsSinceEpoch}");

  var idAssetMediaValte = Get.arguments['idAssetMedia'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.arguments['idAssetMedia'] == "idAssetMedia") {
          Get.offAllNamed(PageRoutes.WRAPPER);
        } else {
          Get.back();
        }

        return false;
      },
      child: Scaffold(
          backgroundColor: AppColor.secondaryDark,
          body: SafeArea(
            child: Obx(() {
              if (logic.isLoadingMusic.value ||
                  logic.musicDetails!.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 10.h,
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppbarBTNWidget(
                                  iconName: 'back1',
                                  onTap: () {
                                    Get.back();
                                  }),
                              Text(
                                'Audio',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(iconName: 'menu', onTap: () {}),
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.secondaryDark,
                    ),

                    //--
                    SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 2 - 100),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                              backgroundColor:
                              AppColor.primaryColor.withOpacity(0.2),
                            ),
                          ),
                        )),
                    //--
                  ],
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 10.h,
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppbarBTNWidget(
                                  iconName: 'back1',
                                  onTap: () {
                                    Get.back();
                                  }),
                              Text(
                                'Video',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(
                                  iconName: 'menu',
                                  onTap: () {
                                    logic.isEditAvaiblae.isTrue
                                        ? showMenu(
                                      color: '#0F0F26'.toColor(),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              12.sp)),
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          100, 80, 0, 0),
                                      items: [
                                        PopupMenuItem(
                                          value: 1,
                                          onTap: () {
                                            logic
                                                .sendToEditProfile(
                                                PostType.audio);
                                          },
                                          child: SizedBox(
                                            width: 130,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/mediaverse/icons/edit.svg'),
                                                Text('Edit'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).then((value) {
                                      if (value != null) {
                                        print('$value');
                                      }
                                    })
                                        :  showMenu(
                                      color: '#0F0F26'.toColor(),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              12.sp)),
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          100, 80, 0, 0),
                                      items: [
                                        PopupMenuItem(
                                          value: 1,
                                          onTap: () {
                                            Get.bottomSheet(
                                                elevation: 0,
                                                isScrollControlled: true,
                                                ReportBottomSheet2(logic));
                                          },
                                          child: SizedBox(
                                            width: 130,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/mediaverse/icons/report.svg' , ),
                                                Text('Report'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).then((value) {
                                      if (value != null) {
                                        print('$value');
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.secondaryDark,
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 2.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: CachedNetworkImage(
                                  imageUrl: logic
                                      .musicDetails?['user']['image_url'] ??
                                      '',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/mediaverse/icons/userprofile.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: AppColor.primaryLightColor,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Container(
                                      color: AppColor.primaryLightColor,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/mediaverse/icons/userprofile.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${logic.musicDetails?['user']['username']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '${logic.musicDetails?['user']['full_name']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              '16 Dec 2024, 6:50PM',
                              style: TextStyle(
                                fontSize: 13,
                                color: '#9C9CB8'.toColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 350,
                          width: 350,


                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(14.sp),
                          ),
                          child:     Stack(
                            alignment: Alignment.center,
                            children: [
                              PlayerVideo(),
                              IgnorePointer(
                                ignoring: true,
                                child: Opacity(
                                  opacity: 0.2,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Center(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14.sp),
                                          child: CachedNetworkImage(
                                            imageUrl: logic.musicDetails?[
                                            'thumbnails'] !=
                                                null &&
                                                logic.musicDetails!['thumbnails']
                                                is Map<String, dynamic>
                                                ? logic.musicDetails!['thumbnails']
                                            ['525x525'] ??
                                                ''
                                                : '',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: SvgPicture.asset(
                                                  'assets/mediaverse/icons/file-text.svg' , height: 4,),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: SvgPicture.asset(
                                                  'assets/mediaverse/icons/file-text.svg' ,height: 4,),
                                              );
                                            },
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            buildCustomDetailBTNWidget(
                                iconName: 'Magic',
                                onTap: () {
                                  runCustomSelectBottomToolsAsset(
                                      logic);
                                },
                                name: 'Tools'),
                            SizedBox(
                              width: 8,
                            ),
                            buildCustomDetailBTNWidget(
                                iconName: 'globe',
                                onTap: () {
                                  runCustomPublishSheet(logic);
                                },
                                name: 'Publish'),
                            Spacer(),
                            // buildCustomDetailBTNWidget(
                            //     iconName: 'Forward',
                            //     onTap: () {},
                            //     name: 'Share'),
                          ],
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          '${logic.musicDetails?['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: logic
                                      .musicDetails?['description'] ==
                                      null
                                      ? ''
                                      : logic.isExpandedViewBodyText
                                      ? logic
                                      .musicDetails!['description']
                                      : logic
                                      .musicDetails![
                                  'description']
                                      .length >
                                      80
                                      ? logic.musicDetails![
                                  'description']
                                      .substring(0, 80) +
                                      ' '
                                      : logic
                                      .musicDetails?['description'],
                                  style: TextStyle(
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                                if (logic
                                    .musicDetails!['description'] !=
                                    null &&
                                    !logic.isExpandedViewBodyText &&
                                    logic.musicDetails!['description']
                                        .length >
                                        80)
                                  TextSpan(
                                    text: '...more',
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 3.h,
                        ),
                      ),
                    ),
                    //--

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Obx(() {
                              if (logic.isLoadingComment.value) {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'details_12'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (logic.commentsData == null ||
                                  logic.commentsData!.isEmpty) {
                                return SizedBox();
                              } else {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'details_12'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text:
                                        ' (${logic.commentsData!['data'].length})',
                                        style: TextStyle(
                                          color: '#9C9CB8'.toColor(),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: TextField(
                            controller: logic.commentTextController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'Add a comment...',
                                fillColor: '#0F0F26'.toColor(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                suffixIcon: Transform.scale(
                                    scale: 0.8,
                                    child: IconButton(
                                      onPressed: () async {
                                        logic.postComment();
                                        logic
                                            .commentTextController.text = '';
                                        logic.isLoadingComment.value =
                                        true;
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        logic.fetchMediaComments();
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/mediaverse/icons/send.svg',
                                        height: 25,
                                      ),
                                    ))),
                          )),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--

                    Obx(() {
                      if (logic.isLoadingComment.value) {
                        return SliverToBoxAdapter(
                            child: Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColor.primaryColor,
                                )));
                      } else if (logic.commentsData == null ||
                          logic.commentsData!.isEmpty) {
                        return SliverToBoxAdapter(child: SizedBox());
                      } else {
                        return SliverList.builder(
                            itemCount:
                            logic.commentsData!['data'].length,
                            itemBuilder: (context, index) {
                              final comment =
                              logic.commentsData?['data'][index];
                              return CommentBoxWidget(
                                data: comment,
                              );
                            });
                      }
                    }),

                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                  ],
                );
              }
            }),
          )),
    );
  }

  Container buildCustomDetailBTNWidget(
      {required String iconName,
        required Function() onTap,
        required String name}) {
    return Container(
      decoration: BoxDecoration(
        color: '#0F0F26'.toColor(),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.01),
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/mediaverse/icons/${iconName}.svg',
                  height: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${name}',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayMusicDialog extends StatefulWidget {
  final String videoUrl;
  PlayMusicDialog({Key? key, required this.videoUrl, required this.controller}) : super(key: key);
  final DetailController controller;

  @override
  _PlayMusicDialogState createState() => _PlayMusicDialogState();
}

class _PlayMusicDialogState extends State<PlayMusicDialog> {
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
          allowFullScreen: false,
          showOptions: false,

        materialProgressColors: ChewieProgressColors(

          playedColor: Colors.black.withOpacity(0.2),
          handleColor: AppColor.primaryDarkColor
        )
      );
      setState(() {
        //     _isPlaying = true;
      });
      //   _controller.play();
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_PlayMusicDialogState.build = ${widget.controller.musicDetails?['thumbnails']}');
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  (widget.controller.musicDetails!['thumbnails'].toString().length>3)?
                  Positioned.fill(child: Image.network(widget.controller.musicDetails?['thumbnails']['336x366'] , fit: BoxFit.cover,)):SizedBox.expand(
                    child: Image.asset(
                        "assets/${F.assetTitle}/images/tum_sound.jpeg",
                        fit: BoxFit.cover),
                  ),
                    Opacity(
                      opacity: 0.8,
                      child: Chewie(
                        controller: chewieController,
                      ),
                    ),

                  ],
                )
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
                  Get.back();


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