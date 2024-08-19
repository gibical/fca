import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gibical/app/pages/detail/widgets/back_widget.dart';
import 'package:gibical/app/pages/media_suit/test.dart';
import 'package:gibical/app/pages/media_suit/widget/audio_player_widget.dart';
import 'package:gibical/app/pages/media_suit/widget/time_line_model.dart';
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
  double maxValue = 200;
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


    scrollSynchronizer = ScrollSynchronizer();

    // Register all scroll controllers initially
    scrollSynchronizer.registerScrollController(_rulerScrollController);
    scrollSynchronizer.registerScrollController(_listScrollControllerImage);
    scrollSynchronizer.registerScrollController(_listScrollControllerText);
    scrollSynchronizer.registerScrollController(_listScrollControllerAudio);
    scrollSynchronizer.registerScrollController(_listScrollControllerVideo);

    // Update scroll synchronizer based on the selected media type
    // updateScrollSynchronizer();
  }

  // void updateScrollSynchronizer() {
  //   scrollSynchronizer.unregisterScrollController(_listScrollControllerVideo);
  //   scrollSynchronizer.unregisterScrollController(_listScrollControllerImage);
  //   scrollSynchronizer.unregisterScrollController(_listScrollControllerAudio);
  //   scrollSynchronizer.unregisterScrollController(_listScrollControllerText);
  //
  //   if (editorController.selectedVideoIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerVideo);
  //   } else if (editorController.selectedImageIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerImage);
  //   } else if (editorController.selectedAudioIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerAudio);
  //   } else if (editorController.selectedTextIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerText);
  //   }
  //
  //   // Always register the ruler scroll controller
  //   scrollSynchronizer.registerScrollController(_rulerScrollController);
  // }




  // void initScroll() {
  //   final editorController = Get.find<MediaSuitController>();
  //
  //   if (editorController.selectedVideoIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerVideo);
  //     scrollSynchronizer.registerScrollController(_rulerScrollController);
  //   } else {
  //     scrollSynchronizer.unregisterScrollController(_listScrollControllerVideo);
  //     scrollSynchronizer.unregisterScrollController(_rulerScrollController);
  //   }
  //
  //   if (editorController.selectedImageIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerImage);
  //     scrollSynchronizer.registerScrollController(_rulerScrollController);
  //   } else {
  //     scrollSynchronizer.unregisterScrollController(_listScrollControllerImage);
  //     scrollSynchronizer.unregisterScrollController(_rulerScrollController);
  //   }
  //
  //   if (editorController.selectedAudioIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerAudio);
  //     scrollSynchronizer.registerScrollController(_rulerScrollController);
  //   } else {
  //     scrollSynchronizer.unregisterScrollController(_listScrollControllerAudio);
  //     scrollSynchronizer.unregisterScrollController(_rulerScrollController);
  //   }
  //
  //   if (editorController.selectedTextIndex.value != null) {
  //     scrollSynchronizer.registerScrollController(_listScrollControllerText);
  //     scrollSynchronizer.registerScrollController(_rulerScrollController);
  //   } else {
  //     scrollSynchronizer.unregisterScrollController(_listScrollControllerText);
  //     scrollSynchronizer.unregisterScrollController(_rulerScrollController);
  //   }
  // }
  final editorController = Get.find<MediaSuitController>();


  Timer? _resizeTimer;
  double _lastPanUpdateDx = 0.0;
  int _currentResizingIndex = -1;
  bool _isTransparentContainerAdded = true;
  bool _isForward = true;



  @override
  Widget build(BuildContext context) {

    int totalItemCount = ((maxValue - minValue) / (itemWidth / 10)).round();

    final h = MediaQuery
        .of(context)
        .size
        .height;

    final w = MediaQuery
        .of(context)
        .size
        .width;
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

    return Scaffold(
      backgroundColor: Color(0xff000033),
      body: GestureDetector(
        onTap: () {
          editorController.selectedTextIndex
              .value = null;
          editorController.selectedVideoIndex
              .value = null;
          editorController.selectedImageIndex
              .value = null;
          editorController.selectedAudioIndex
              .value = null;
          setState(() {

          });
        },
        child: Stack(
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
                          'assets/images/line_editor.svg',
                          fit: BoxFit.cover,
                        )
                    )
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [


                      SizedBox(height: h * 0.1),

                      Container(

                        color: Color(0xff000033),
                        child: Obx(() =>
                            Column(

                              children: [

                                Obx(() {
                                  final selectedVideoIndex = editorController
                                      .selectedVideoIndex.value;
                                  final selectedImageIndex = editorController
                                      .selectedImageIndex.value;
                                  final selectedAudioIndex = editorController
                                      .selectedAudioIndex.value;
                                  final selectedTextIndex = editorController
                                      .selectedTextIndex.value;


                                  if (selectedVideoIndex != null&&editorController.isWaitingAssetConvert.isFalse) {
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
                                  } else if (selectedImageIndex != null&&editorController.isWaitingAssetConvert.isFalse) {
                                    return SizedBox(
                                        height: 33.h,
                                        width: double.infinity,
                                        child: Image.network(editorController
                                            .editImageDataList[selectedImageIndex]
                                            .urlMedia!, fit: BoxFit.cover,));
                                  } else if (selectedAudioIndex != null&&editorController.isWaitingAssetConvert.isFalse) {
                                    return SizedBox(
                                        height: 30.h,
                                        child: AudioPlayerWidget(
                                          urlAudio: editorController
                                              .editAudioDataList[selectedAudioIndex]
                                              .urlMedia!,));
                                  } else if (selectedTextIndex != null&&editorController.isWaitingAssetConvert.isFalse) {
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
                                              fontSize: 13
                                          ),)
                                    );
                                  }
                                }),

                                editorController
                                    .selectedVideoIndex.value != null
                                    ? SizedBox()
                                    : CustomRulerTimelineOtherAssetsWidget1(
                                  minValue: minValue,
                                  maxValue: maxValue,
                                  value: value,
                                  majorTick: 10,
                                  // Adjust as per your preference
                                  minorTick: 1,
                                  // Set to 1 for closer ticks
                                  labelValuePrecision: 0,
                                  tickValuePrecision: 0,

                                  onChanged: (val) =>
                                      setState(() {
                                        value = val;
                                        actualValue = val.roundToDouble();
                                        print('Slider value: $value');
                                        print('Actual value: $actualValue');
                                      }),
                                  activeColor: AppColor.primaryLightColor,
                                  inactiveColor: AppColor.primaryLightColor
                                      .withOpacity(0.2),
                                  linearStep: true,
                                  totalSeconds: ((maxValue - minValue) / 1)
                                      .toInt() + 1,
                                  // Adjust to cover the entire range
                                  scrollController: _rulerScrollController,
                                  maxPaddingValue: editorController.maxPaddingValue,
                                  minPaddingValue: editorController.minPaddingValue,

                                  //
                                  // listScrollController: editorController.selectedTextIndex.value != null
                                  //     ? _listScrollControllerText
                                  //     : editorController.selectedImageIndex.value != null
                                  //     ? _listScrollControllerImage
                                  //     : _listScrollControllerAudio,
                                ),


                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  height: 1,
                                  width: double.infinity,
                                ),
                                Obx(
                                      () =>
                                      SizedBox(
                                        height: h * 0.050,
                                        child: ReorderableListView.builder(
                                          scrollController: _listScrollControllerVideo,
                                          itemCount: editorController
                                              .editVideoDataList.length +
                                              totalItemCount,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {

                                            if (index <
                                                editorController.editVideoDataList
                                                    .length) {
                                              var model = editorController
                                                  .editVideoDataList[index];
                                              String name = editorController
                                                  .editVideoDataList[index].name;

                                              return GestureDetector(
                                                key: ValueKey('item_$index'),
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelected) {
                                                      // If already selected, do nothing
                                                      return;
                                                    } else {
                                                      editorController
                                                          .selectedTextIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedVideoIndex
                                                          .value = index;
                                                      editorController
                                                          .selectedImageIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedAudioIndex
                                                          .value = null;
                                                    }
                                                  }
                                                  );
                                                },
                                                child: EditeBoxWidget(

                                                  index: index,
                                                  model: model,
                                                  scrollController: _listScrollControllerVideo, color: Colors.purple,  removeItem: () {
                                                  editorController
                                                      .editVideoDataList.removeAt(
                                                      index);
                                                },
                                                ),
                                              );
                                            } else {
                                              return _buildInfiniteScrollContainer();
                                            }
                                          },
                                          proxyDecorator: (child, index,
                                              animation) =>
                                              _proxyDecorator(
                                                child, index, animation,
                                                Colors.purple,
                                                Colors.purple.shade300,),
                                          onReorder: (int oldIndex, int newIndex) {
                                            setState(() {
                                              if (oldIndex < newIndex) {
                                                newIndex -= 1;
                                              }
                                              final item = editorController
                                                  .editVideoDataList.removeAt(
                                                  oldIndex);
                                              editorController.editVideoDataList
                                                  .insert(newIndex, item);
                                            });
                                          },
                                        ),
                                      ),
                                ),
                                // Obx(
                                //       () =>
                                //       SizedBox(
                                //         height: h * 0.050,
                                //         child: ReorderableListView.builder(
                                //           scrollController: _listScrollControllerVideo,
                                //
                                //           itemCount:
                                //           editorController.editVideoDataList.length,
                                //           scrollDirection: Axis.horizontal,
                                //           itemBuilder: (context, index) {
                                //             var model =
                                //             editorController.editVideoDataList[index];
                                //             String name = editorController
                                //                 .editVideoDataList[index].name;
                                //             //   return TimeLineWidget(model: model, color: Colors.redAccent, name: name,);
                                //
                                //             return GestureDetector(
                                //               key: Key('${index}'),
                                //               onTap: () {
                                //                 setState(() {
                                //                   if (isSelected) {
                                //                     // If already selected, do nothing
                                //                     return;
                                //                   } else {
                                //                     editorController.selectedTextIndex
                                //                         .value = null;
                                //                     editorController.selectedVideoIndex
                                //                         .value = index;
                                //                     editorController.selectedImageIndex
                                //                         .value = null;
                                //                     editorController.selectedAudioIndex
                                //                         .value = null;
                                //                   }
                                //                 }
                                //
                                //
                                //                 );
                                //
                                //
                                //
                                //
                                //
                                //               },
                                //               child: TimeLineWidget(
                                //                 model: model,
                                //                 color: Colors.purple,
                                //                 name: name,
                                //
                                //                 removeItem: () {
                                //                   editorController.editVideoDataList
                                //                       .removeAt(index);
                                //                 },
                                //                 index: index,
                                //               ),
                                //             );
                                //           },
                                //           proxyDecorator: (child, index, animation) =>
                                //               _proxyDecorator(child, index, animation,
                                //                   Colors.purple, Colors.purple.shade300),
                                //           onReorder: (int oldIndex, int newIndex) {
                                //             setState(() {
                                //               if (oldIndex < newIndex) {
                                //                 newIndex -= 1;
                                //               }
                                //               final item = editorController
                                //                   .editVideoDataList
                                //                   .removeAt(oldIndex);
                                //               editorController.editVideoDataList
                                //                   .insert(newIndex, item);
                                //             });
                                //           },
                                //         ),
                                //       ),
                                // ),


                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  height: 1,
                                  width: double.infinity,
                                ),
                                Obx(() {
                                  return SizedBox(
                                    height: h * 0.050,
                                    child: ReorderableListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      scrollController: _listScrollControllerImage,
                                      itemCount: editorController.editImageDataList.length + (_isTransparentContainerAdded ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        if (index < editorController.editImageDataList.length) {
                                          var model = editorController.editImageDataList[index];
                                          return GestureDetector(
                                            key: ValueKey('item_$index'),
                                            onTap: () {
                                              setState(() {
                                                editorController
                                                    .selectedTextIndex.value =
                                                null;
                                                editorController
                                                    .selectedVideoIndex.value =
                                                    null;
                                                editorController
                                                    .selectedImageIndex.value =
                                                index;
                                                editorController
                                                    .selectedAudioIndex.value =
                                                null;
                                              });
                                            },
                                            child: EditeBoxWidget(

                                              index: index,
                                              model: model,
                                              scrollController: _listScrollControllerImage, color: Colors.orange,  removeItem: () {
                                              editorController
                                                  .editImageDataList.removeAt(
                                                  index);
                                            },
                                            ),
                                          );
                                        } else {
                                          return _buildInfiniteScrollContainer();
                                        }
                                      },
                                      onReorder: (int oldIndex, int newIndex) {
                                        setState(() {
                                          if (oldIndex < newIndex) {
                                            newIndex -= 1;
                                          }
                                          final item = editorController.editImageDataList.removeAt(oldIndex);
                                          editorController.editImageDataList.insert(newIndex, item);
                                        });
                                      },
                                    ),
                                  );
                                }),


                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  height: 1,
                                  width: double.infinity,
                                ),
                                Obx(
                                      () =>
                                      SizedBox(
                                        height: h * 0.050,
                                        child: ReorderableListView.builder(
                                          itemCount:
                                          editorController.editAudioDataList
                                              .length + totalItemCount,

                                          scrollDirection: Axis.horizontal,
                                          scrollController: _listScrollControllerAudio,
                                          itemBuilder: (context, index) {
                                            //   return TimeLineWidget(model: model, color: Colors.redAccent, name: name,);
                                            if (index < editorController.editAudioDataList.length) {
                                              var model =
                                              editorController
                                                  .editAudioDataList[index];
                                              String name = editorController
                                                  .editAudioDataList[index].name;
                                              return GestureDetector(
                                                key: ValueKey('item_$index'),
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelected) {
                                                      // If already selected, do nothing
                                                      return;
                                                    } else {
                                                      editorController
                                                          .selectedTextIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedVideoIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedImageIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedAudioIndex
                                                          .value = index;
                                                    }
                                                  }
                                                  );
                                                },
                                                child: EditeBoxWidget(

                                                  index: index,
                                                  model: model,
                                                  scrollController: _listScrollControllerAudio, color: Colors.red,  removeItem: () {
                                                  editorController
                                                      .editAudioDataList.removeAt(
                                                      index);
                                                },
                                                ),
                                              );
                                            } else {
                                              return _buildInfiniteScrollContainer();
                                            }
                                          },
                                          proxyDecorator: (child, index,
                                              animation) =>
                                              _proxyDecorator(
                                                  child, index, animation,
                                                  Colors.red, Colors.red.shade300),
                                          onReorder: (int oldIndex, int newIndex) {
                                            setState(() {
                                              if (oldIndex < newIndex) {
                                                newIndex -= 1;
                                              }
                                              final item = editorController
                                                  .editAudioDataList
                                                  .removeAt(oldIndex);
                                              editorController.editAudioDataList
                                                  .insert(newIndex, item);
                                            });
                                          },
                                        ),
                                      ),
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  height: 1,
                                  width: double.infinity,
                                ),
                                Obx(
                                      () =>
                                      SizedBox(
                                        height: h * 0.050,
                                        child: ReorderableListView.builder(

                                          itemCount:
                                          editorController.editTextDataList.length +
                                              totalItemCount,

                                          scrollDirection: Axis.horizontal,
                                          scrollController: _listScrollControllerText,
                                          itemBuilder: (context, index) {
                                            if (index < editorController.editTextDataList.length) {
                                              var model =
                                              editorController
                                                  .editTextDataList[index];
                                              String name = editorController
                                                  .editTextDataList[index].name;
                                              return GestureDetector(
                                                key: ValueKey('item_$index'),
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelected) {
                                                      // If already selected, do nothing
                                                      return;
                                                    } else {
                                                      editorController
                                                          .selectedTextIndex
                                                          .value = index;
                                                      editorController
                                                          .selectedVideoIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedImageIndex
                                                          .value = null;
                                                      editorController
                                                          .selectedAudioIndex
                                                          .value = null;
                                                    }
                                                  }
                                                  );
                                                },
                                                child: EditeBoxWidget(

                                                  index: index,
                                                  model: model,
                                                  scrollController: _listScrollControllerText, color: Colors.green,  removeItem: () {
                                                  editorController
                                                      .editTextDataList.removeAt(
                                                      index);
                                                },
                                                ),
                                              );
                                            } else {
                                              return _buildInfiniteScrollContainer();
                                            }
                                          },
                                          proxyDecorator: (child, index,
                                              animation) =>
                                              _proxyDecorator(
                                                  child, index, animation,
                                                  Colors.green,
                                                  Colors.green.shade300),
                                          onReorder: (int oldIndex, int newIndex) {
                                            setState(() {
                                              if (oldIndex < newIndex) {
                                                newIndex -= 1;
                                              }
                                              final item = editorController
                                                  .editTextDataList
                                                  .removeAt(oldIndex);
                                              editorController.editTextDataList
                                                  .insert(newIndex, item);
                                            });
                                          },
                                        ),
                                      ),
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.7),
                                  height: 1,
                                  width: double.infinity,
                                ),

                                SizedBox(
                                  height: 1.h,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: SizedBox(
                                    height: 30,

                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: SliderTheme(

                                      data: const SliderThemeData(


                                        overlayColor: Colors.transparent,
                                        overlayShape: RoundSliderThumbShape(),
                                        rangeTrackShape: RectangularRangeSliderTrackShape(

                                        ),
                                        rangeThumbShape: RoundRangeSliderThumbShape(
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
                                              editorController.minPaddingValue = 25;
                                            } else {
                                              editorController.minPaddingValue =
                                                  values.start;
                                            }

                                            editorController.maxPaddingValue =
                                                values.end;

                                            if (editorController.maxPaddingValue <
                                                30) {
                                              editorController.maxPaddingValue = 30;
                                            }

                                            print(values);
                                          });
                                        },
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ),),
                      ),


                      SizedBox(height: h * 0.02),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.to(ProfileScreen(), arguments: 'edit_screen');
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
                              } else if (editorController.selectedAudioIndex
                                  .value != null) {
                                currentActions = editorController.audioAction;
                              } else if (editorController.selectedTextIndex.value !=
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text('${model.nameItem}')),
                                      ),
                                      onTap: () {
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
                      Stack(
                        alignment: Alignment.center,
                        children: [

                          SizedBox(
                              width: w,
                              child: SvgPicture.asset(
                                'assets/images/box_editor.svg',
                                fit: BoxFit.cover,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                ),
                Positioned(
                  bottom: 11.5.h,
                  child:


                  editorController.selectedVideoIndex.value != null ||
                      editorController.selectedAudioIndex.value != null
                      ? IconButton(
                      onPressed: () {
                        editorController.selectedTextIndex
                            .value = null;
                        editorController.selectedVideoIndex
                            .value = null;
                        editorController.selectedImageIndex
                            .value = null;
                        editorController.selectedAudioIndex
                            .value = null;
                        setState(() {

                        });
                      },
                      icon:
                      Icon(
                        Icons.stop,
                        size: 27,
                      )

                  )
                      : IconButton(onPressed: () {
                    if (editorController.editVideoDataList.isNotEmpty ||
                        editorController.editAudioDataList.isNotEmpty) {
                      editorController.selectFirstMediaSelected();
                    } else {

                    }
                    setState(() {});
                  }, icon: BlinkingIcon(),),


                ),
                Positioned(
                    top: 5.h,
                    child: Text('Editor', style: TextStyle(),)
                ),
                BackWidget()
              ],
            ),
            Obx(() {
              return Visibility(
                visible: editorController.isloadingSubmit.value,
                child: SizedBox.expand(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Stack(
                      children: [
                        Align(
                          child: Lottie.asset(
                              "assets/json/Y8IBRQ38bK.json", height: 10.h),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: editorController.isloadingAssetConvert.value,
                child: SizedBox.expand(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Stack(
                      children: [
                        Align(
                          child: Lottie.asset(
                              "assets/json/Y8IBRQ38bK.json", height: 10.h),
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
    );
  }
  Widget _buildContainer({required EditDataModel model,required int index}) {
    return Container(
      key: Key('$index'), // Unique key for each container
      height: 100.0,
      child: Row(
        children: [
          Container(
            width: model.width,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              model.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
          GestureDetector(
            onPanStart: (details) {
              _resizeTimer?.cancel();
              _lastPanUpdateDx = details.localPosition.dx;
              _currentResizingIndex = index;
            },
            onPanUpdate: (details) {
              if (_currentResizingIndex == index) {
                setState(() {
                  double deltaDx = details.localPosition.dx - _lastPanUpdateDx;
                  _lastPanUpdateDx = details.localPosition.dx;

                  _isForward = deltaDx > 0;

                  model.width += deltaDx;
                  if (model.width < 30.0) {
                    model.width = 30.0;
                  }

                  if (_resizeTimer == null) {
                    _resizeTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
                      setState(() {
                        double scrollOffset = _listScrollControllerImage.offset;
                        double containerWidth = _getContainerWidth(index);
                        double screenWidth = MediaQuery.of(context).size.width;

                        if (_isForward) {
                          model.width += 0.4; // Reduced speed
                          if (scrollOffset + screenWidth < containerWidth) {
                            double newOffset = scrollOffset + 1; // Reduced speed
                            _listScrollControllerImage.jumpTo(newOffset);
                          }
                        } else {
                          model.width -= 0.4; // Reduced speed
                          if (model.width < 30.0) {
                            model.width = 30.0;
                          }
                          if (scrollOffset > 0) {
                            double newOffset = scrollOffset - 1; // Reduced speed
                            _listScrollControllerImage.jumpTo(newOffset);
                          }
                        }
                      });
                    });
                  }
                });
              }
            },
            onPanEnd: (details) {
              _resizeTimer?.cancel();
              _resizeTimer = null;
              _currentResizingIndex = -1;
            },
            child: Container(
              color: Colors.red,
              width: 30.0,
              height: 100.0,
              child: Icon(
                Icons.drag_handle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfiniteScrollContainer() {
    return Container(
      key: ValueKey('orange'),
      width: 100000.0,
      color: Colors.transparent,
    );
  }

  double _getContainerWidth(int index , ) {
    double width = 0.0;
    for (int i = 0; i <= index; i++) {
      width +=   editorController.editImageDataList[i].width;
    }
    width += 16 * (index + 1); // Add margin for each container
    return width;
  }

  @override
  void dispose() {

    _resizeTimer?.cancel();
    super.dispose();
  }
}

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
              totalSeconds: controllerVideo.value.duration.inSeconds.toInt() +
                  1,
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


class BlinkingIcon extends StatefulWidget {
  @override
  _BlinkingIconState createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon> {
  double _opacity = 1.0;
  Timer? _timer;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _opacity = _isVisible ? 0.4 : 1.0;
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 900),
        child: Icon(Icons.play_arrow)
    );
  }
}