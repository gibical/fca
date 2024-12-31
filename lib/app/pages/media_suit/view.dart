import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/pages/detail/widgets/back_widget.dart';
import 'package:mediaverse/app/pages/media_suit/test.dart';
import 'package:mediaverse/app/pages/media_suit/widget/anim/timeline_blinking_icon_anim_widget.dart';
import 'package:mediaverse/app/pages/media_suit/widget/audio_player_widget.dart';
import 'package:mediaverse/app/pages/media_suit/widget/time_line_model.dart';
import 'package:mediaverse/app/pages/media_suit/widget/video_player_online_widget.dart';
import 'package:lottie/lottie.dart';

import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../common/app_color.dart';

import '../profile/view.dart';
import 'logic.dart';

class MediaSuitScreen extends StatefulWidget {
  const MediaSuitScreen({super.key});

  @override
  State<MediaSuitScreen> createState() => _MediaSuitScreenState();
}

class _MediaSuitScreenState extends State<MediaSuitScreen> {
  bool isSelected = false;
  double value = 0;
  double actualValue = 0;
  double minValue = 0; // Start from 1

  double itemWidth = 100;

  late ScrollSynchronizer scrollSynchronizer;

  final ScrollController _rulerScrollController = ScrollController();
  final ScrollController _listScrollControllerImage = ScrollController();
  final ScrollController _listScrollControllerText = ScrollController();
  final ScrollController _listScrollControllerAudio = ScrollController();
  final ScrollController _listScrollControllerVideo = ScrollController();

  @override
  void initState() {
    super.initState();
    editorController.isTrimming = false;
    scrollSynchronizer = ScrollSynchronizer();

    // Register all scroll controllers initially
    scrollSynchronizer.registerScrollController(_rulerScrollController);
    scrollSynchronizer.registerScrollController(_listScrollControllerImage);
    scrollSynchronizer.registerScrollController(_listScrollControllerText);
    scrollSynchronizer.registerScrollController(_listScrollControllerAudio);
    scrollSynchronizer.registerScrollController(_listScrollControllerVideo);


  }


  final editorController = Get.find<MediaSuitController>();

  Timer? _resizeTimer;
  double _lastPanUpdateDx = 0.0;
  int _currentResizingIndex = -1;
  bool _isTransparentContainerAdded = true;
  bool _isForward = true;

  @override
  Widget build(BuildContext context) {
    int totalItemCount = ((editorController.maxValueRuler - minValue) / (itemWidth / 10)).round();

    final h = MediaQuery.of(context).size.height;

    final w = MediaQuery.of(context).size.width;
    Widget _proxyDecorator(Widget child, int index, Animation<double> animation,
        Color color, Color shadowColor) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 15, animValue)!;
          return Material(
            elevation: elevation,
            color: color,
            shadowColor: shadowColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(0xff000033),
        body: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    bottom: h * 0.17,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                        width: w,
                        child: SvgPicture.asset(
                          'assets/${F.assetTitle}/images/line_editor.svg',
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.1),
                      Container(
                        color: Color(0xff000033),
                        child: Obx(
                          () => Column(
                            children: [
                              Obx(() {
                                final selectedVideoIndex =
                                    editorController.selectedVideoIndex.value;
                                final selectedImageIndex =
                                    editorController.selectedImageIndex.value;
                                final selectedAudioIndex =
                                    editorController.selectedAudioIndex.value;
                                final selectedTextIndex =
                                    editorController.selectedTextIndex.value;

                                if (selectedVideoIndex != null &&
                                    editorController
                                        .isWaitingAssetConvert.isFalse) {
                                  //  editorController.player.stop();

                                  return VideoPlayerEditor(
                                    key: UniqueKey(),
                                    scrollController: _rulerScrollController,
                                    mediaSuitController: editorController,
                                    videoUrls: [
                                      editorController
                                          .editVideoDataList[selectedVideoIndex]
                                          .urlMedia
                                    ],
                                  );
                                } else if (selectedImageIndex != null &&
                                    editorController
                                        .isWaitingAssetConvert.isFalse) {
                                  return SizedBox(
                                      height: 33.h,
                                      width: double.infinity,
                                      child: Image.network(
                                        editorController
                                            .editImageDataList[
                                                selectedImageIndex]
                                            .urlMedia!,
                                        fit: BoxFit.cover,
                                      ));
                                } else if (selectedAudioIndex != null &&
                                    editorController
                                        .isWaitingAssetConvert.isFalse) {
                                  return SizedBox(
                                      height: 30.h,
                                      child: AudioPlayerWidget(
                                        urlAudio: editorController
                                            .editAudioDataList[
                                                selectedAudioIndex]
                                            .urlMedia!,
                                      ));
                                } else if (selectedTextIndex != null &&
                                    editorController
                                        .isWaitingAssetConvert.isFalse) {
                                  //editorController.player.stop();
                                  return SizedBox(
                                    height: 27.h,
                                    child: Text(
                                      editorController
                                          .editTextDataList[selectedTextIndex]
                                          .name
                                          .toUpperCase(),
                                    ),
                                  );
                                } else {
                                  //editorController.player.stop();
                                  return SizedBox(
                                      child: Text(
                                    'Media has not been selected yet!',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.3),
                                        fontSize: 13),
                                  ));
                                }
                              }),

                              editorController.selectedVideoIndex.value != null
                                  ? SizedBox()
                                  : CustomRulerTimelineOtherAssetsWidget1(
                                      minValue: minValue,
                                      maxValue: editorController.maxValueRuler,
                                      value: value,
                                      majorTick: 10,
                                      // Adjust as per your preference
                                      minorTick: 1,
                                      // Set to 1 for closer ticks
                                      labelValuePrecision: 0,
                                      tickValuePrecision: 0,

                                      onChanged: (val) => setState(() {
                                        value = val;
                                        actualValue = val.roundToDouble();
                                        print('Slider value: $value');
                                        print('Actual value: $actualValue');
                                      }),
                                      activeColor: AppColor.primaryLightColor,
                                      inactiveColor: AppColor.primaryLightColor
                                          .withOpacity(0.2),
                                      linearStep: true,
                                      totalSeconds:
                                          ((editorController.maxValueRuler - minValue) / 1).toInt() +
                                              1,
                                      // Adjust to cover the entire range
                                      scrollController: _rulerScrollController,
                                      maxPaddingValue:
                                          editorController.maxPaddingValue,
                                      minPaddingValue:
                                          editorController.minPaddingValue,

                                      //
                                      // listScrollController: editorController.selectedTextIndex.value != null
                                      //     ? _listScrollControllerText
                                      //     : editorController.selectedImageIndex.value != null
                                      //     ? _listScrollControllerImage
                                      //     : _listScrollControllerAudio,
                                    ),

                              CustomDividerTilmelineWidget(),
                              TimelineItemList(
                                controller: _listScrollControllerVideo,
                                itemCount:
                                    editorController.editVideoDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.purple,
                                dataList: editorController.editVideoDataList,
                                selectedIndex:
                                    editorController.selectedVideoIndex,
                              ),
                              CustomDividerTilmelineWidget(),
                              TimelineItemList(
                                controller: _listScrollControllerImage,
                                itemCount:
                                    editorController.editImageDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.orange,
                                dataList: editorController.editImageDataList,
                                selectedIndex:
                                    editorController.selectedImageIndex,
                              ),
                              CustomDividerTilmelineWidget(),
                              TimelineItemList(
                                controller: _listScrollControllerAudio,
                                itemCount:
                                    editorController.editAudioDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.red,
                                dataList: editorController.editAudioDataList,
                                selectedIndex:
                                    editorController.selectedAudioIndex,
                              ),
                              CustomDividerTilmelineWidget(),
                              TimelineItemList(
                                controller: _listScrollControllerText,
                                itemCount:
                                    editorController.editTextDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.green,
                                dataList: editorController.editTextDataList,
                                selectedIndex:
                                    editorController.selectedTextIndex,
                              ),
                              CustomDividerTilmelineWidget(),
                              SizedBox(
                                height: 1.h,
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: SizedBox(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  child: SliderTheme(
                                    data: const SliderThemeData(
                                      overlayColor: Colors.transparent,
                                      overlayShape: RoundSliderThumbShape(),
                                      rangeTrackShape:
                                          RectangularRangeSliderTrackShape(),
                                      rangeThumbShape:
                                          RoundRangeSliderThumbShape(
                                              elevation: 0),
                                      thumbColor: Colors.transparent,
                                    ),
                                    child: RangeSlider(
                                      values: RangeValues(
                                          editorController.minPaddingValue,
                                          editorController.maxPaddingValue),
                                      min: 10,
                                      max: 80,
                                      onChanged: (RangeValues values) {
                                        setState(() {
                                          if (values.start > 25) {
                                            editorController.minPaddingValue =
                                                25;
                                          } else {
                                            editorController.minPaddingValue =
                                                values.start;
                                          }

                                          editorController.maxPaddingValue =
                                              values.end;

                                          if (editorController.maxPaddingValue <
                                              30) {
                                            editorController.maxPaddingValue =
                                                30;
                                          }

                                          print(values);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.to(ProfileScreen(),
                                      arguments: 'edit_screen');
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 27,
                                )),
                            Obx(() {
                              List<ActionEditorModel>? currentActions;
                              if (editorController.selectedVideoIndex.value !=
                                  null) {
                                currentActions = editorController.videoAction;
                              } else if (editorController
                                      .selectedAudioIndex.value !=
                                  null) {
                                currentActions = editorController.audioAction;
                              } else if (editorController
                                      .selectedTextIndex.value !=
                                  null) {
                                currentActions = editorController.textAction;
                              }

                              return currentActions != null
                                  ? PopupMenuButton(
                                      color: Colors.grey.withOpacity(0.8),
                                      child: Icon(Icons.menu),
                                      itemBuilder: (context) {
                                        return List.generate(
                                            currentActions!.length, (index) {
                                          var model = currentActions![index];
                                          return PopupMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                      '${model.nameItem}')),
                                            ),
                                            onTap: () {
                                              setState(() {});
                                              model.onTap();
                                            },
                                          );
                                        });
                                      },
                                    )
                                  : SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          editorController.selectedTextIndex.value = null;
                          editorController.selectedVideoIndex.value = null;
                          editorController.selectedImageIndex.value = null;
                          editorController.selectedAudioIndex.value = null;
                          editorController.isTrimming=false;
                          setState(() {});

                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                                width: w,
                                child: SvgPicture.asset(
                                  'assets/${F.assetTitle}/images/box_editor.svg',
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 27,
                                      )),
                                  IconButton(
                                      onPressed: () {

                                        editorController.exportOnline();
                                      },
                                      icon: Icon(Icons.done, size: 27)),
                                ],
                              ),
                            ),

                            //secend :60 pixel:690 =>
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                            editorController.isTrimming == true
                    ? GetBuilder<MediaSuitController>(
                        builder: (controller) {
                          return Positioned(
                            bottom: 11.5.h,
                            child: IconButton(
                                onPressed: () {
                                  if (editorController
                                          .selectedAudioIndex.value !=
                                      -1) {
                                    // final model = editorController.editVideoDataList[editorController.selectedVideoIndex.value!];
                                    // print('Start Trim: ${model.startTrim.round()}');
                                    // print('End Trim: ${model.endTrim.round()}');
                                    editorController.confirmAudioTrim();
                                  } else {
                                    print('No container is being trimmed');
                                  }
                                  if (editorController
                                          .selectedVideoIndex.value !=
                                      -1) {
                                    // final model = editorController.editVideoDataList[editorController.selectedVideoIndex.value!];
                                    // print('Start Trim: ${model.startTrim.round()}');
                                    // print('End Trim: ${model.endTrim.round()}');
                                    editorController.confirmVideoTrim();
                                  } else {
                                    print('No container is being trimmed');
                                  }
                                },
                                icon: Image.asset(
                                  'assets/${F.assetTitle}/icons/trim_timeline.png',
                                  width: 25,
                                  color: Colors.white,
                                )),
                          );
                        },
                      )
                    : Positioned(
                        bottom: 11.5.h,
                        child: editorController.selectedVideoIndex.value !=
                                    null ||
                                editorController.selectedAudioIndex.value !=
                                    null
                            ? IconButton(
                                onPressed: () {
                                  editorController.selectedTextIndex.value =
                                      null;
                                  editorController.selectedVideoIndex.value =
                                      null;
                                  editorController.selectedImageIndex.value =
                                      null;
                                  editorController.selectedAudioIndex.value =
                                      null;
                                  editorController.isTrimming = false;
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.stop,
                                  size: 27,
                                ))
                            : IconButton(
                                onPressed: () {
                                  if (editorController
                                          .editVideoDataList.isNotEmpty ||
                                      editorController
                                          .editAudioDataList.isNotEmpty) {
                                    editorController.selectFirstMediaSelected();
                                  } else {}
                                  editorController.isTrimming = false;
                                  setState(() {});
                                },
                                icon: BlinkingIcon(),
                              ),
                      ),
                Positioned(
                    top: 5.h,
                    child: Text(
                      'Editor',
                      style: TextStyle(),
                    )),
                BackWidget()
              ],
            ),
            // Obx(() {
            //   return Visibility(
            //     visible: editorController.isloadingSubmit.value,
            //     child: SizedBox.expand(
            //       child: Container(
            //         color: Colors.black.withOpacity(0.4),
            //         child: Stack(
            //           children: [
            //             Align(
            //               child: Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
            //                   height: 10.h),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   );
            // }),
            Obx(() {
              return Visibility(
                visible: editorController.isloadingAssetConvert.value,
                child: SizedBox.expand(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Stack(
                      children: [
                        Align(
                          child: Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                              height: 10.h),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Container CustomDividerTilmelineWidget() {
    return Container(
      color: Colors.grey.withOpacity(0.7),
      height: 1,
      width: double.infinity,
    );
  }


  Widget _buildInfiniteScrollContainer(String key) {
    return Container(
      key:  ValueKey(key),
      width: 100000.0,
      color: Colors.transparent,
    );
  }

  Widget TimelineItemList({
    required ScrollController controller,
    required int itemCount,
    required int totalItemCount,
    required Color color,
    required RxList<EditDataModel> dataList,
    dynamic selectedIndex,
  }) {
    return Obx(
      () => GestureDetector(
        onPanUpdate: (details) {
          if (!Get.find<MediaSuitController>().isResizing) {
            controller.jumpTo(
              controller.offset - details.delta.dx * 2,
            );
          }
        },
        onPanEnd: (details) {
          if (!Get.find<MediaSuitController>().isResizing) {
            double velocity = details.velocity.pixelsPerSecond.dx;
            double offset = controller.offset - velocity * 0.1;

            double maxScrollExtent = controller.position.maxScrollExtent;
            double minScrollExtent = controller.position.minScrollExtent;
            if (offset < minScrollExtent) offset = minScrollExtent;
            if (offset > maxScrollExtent) offset = maxScrollExtent;

            controller.animateTo(
              offset,
              duration: Duration(milliseconds: 200),
              curve: Curves.decelerate,
            );
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.050,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            scrollController: controller,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataList.length + totalItemCount,
            itemBuilder: (context, index) {
              if (index < dataList.length) {
                var model = dataList[index];
                return GestureDetector(
                  key: ValueKey('${model.assetId }${index}'),
                  onTap: () {
                    setState(() {
                      selectedIndex.value = index;
                    });
                    Get.find<MediaSuitController>().isTrimming = false;
                  },
                  child: EditeBoxWidget(
                    index: index,
                    model: model,
                    scrollController: controller,
                    color: color,
                    removeItem: () {
                      dataList.removeAt(index);
                    },
                  ),
                );
              } else {
                return _buildInfiniteScrollContainer(index.toString()  );
              }
            },
            proxyDecorator: (child, index, animation) => _proxyDecorator(
                child, index, animation, color, color.withOpacity(0.5)),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) newIndex -= 1;
                final item = dataList.removeAt(oldIndex);
                dataList.insert(newIndex, item);
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _resizeTimer?.cancel();
    super.dispose();
  }
}

Widget _proxyDecorator(Widget child, int index, Animation<double> animation,
    Color color, Color shadowColor) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(0, 15, animValue)!;
      return Material(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        child: child,
      );
    },
    child: child,
  );
}


