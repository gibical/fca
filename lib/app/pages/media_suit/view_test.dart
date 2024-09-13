import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gibical/app/pages/media_suit/test.dart';
import 'package:gibical/app/pages/media_suit/widget/audio_player_widget.dart';
import 'package:gibical/app/pages/media_suit/widget/time_line_model.dart';
import 'package:gibical/app/pages/media_suit/widget/video_player_online_widget.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import 'logic.dart';

class MediaSuitScreen extends StatefulWidget {
  @override
  _MediaSuitScreenState createState() => _MediaSuitScreenState();
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
    int totalItemCount = ((maxValue - minValue) / (itemWidth / 10)).round();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    Widget _proxyDecorator(Widget child, int index, Animation<double> animation, Color color, Color shadowColor) {
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
      backgroundColor: const Color(0xff000033),
      body: GestureDetector(
        onTap: () {
          editorController.selectedTextIndex.value = null;
          editorController.selectedVideoIndex.value = null;
          editorController.selectedImageIndex.value = null;
          editorController.selectedAudioIndex.value = null;
          setState(() {});
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
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.1),
                      Container(
                        color: const Color(0xff000033),
                        child: Obx(
                              () => Column(
                            children: [
                              Obx(() {
                                final selectedVideoIndex = editorController.selectedVideoIndex.value;
                                final selectedImageIndex = editorController.selectedImageIndex.value;
                                final selectedAudioIndex = editorController.selectedAudioIndex.value;
                                final selectedTextIndex = editorController.selectedTextIndex.value;

                                if (selectedVideoIndex != null && editorController.isWaitingAssetConvert.isFalse) {
                                  return VideoPlayerEditor(
                                    key: UniqueKey(),
                                    scrollController: _rulerScrollController,
                                    mediaSuitController: editorController,
                                    videoUrls: [
                                      editorController.editVideoDataList[selectedVideoIndex].urlMedia
                                    ],
                                  );
                                } else if (selectedImageIndex != null && editorController.isWaitingAssetConvert.isFalse) {
                                  return SizedBox(
                                    height: 33.h,
                                    width: double.infinity,
                                    child: Image.network(
                                      editorController.editImageDataList[selectedImageIndex].urlMedia!,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else if (selectedAudioIndex != null && editorController.isWaitingAssetConvert.isFalse) {
                                  return SizedBox(
                                    height: 30.h,
                                    child: AudioPlayerWidget(
                                      urlAudio: editorController.editAudioDataList[selectedAudioIndex].urlMedia!,
                                    ),
                                  );
                                } else if (selectedTextIndex != null && editorController.isWaitingAssetConvert.isFalse) {
                                  return SizedBox(
                                    height: 27.h,
                                    child: Text(
                                      editorController.editTextDataList[selectedTextIndex].name.toUpperCase(),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    child: Text(
                                      'Media has not been selected yet!',
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(0.3),
                                        fontSize: 13,
                                      ),
                                    ),
                                  );
                                }
                              }),
                              editorController.selectedVideoIndex.value != null
                                  ? const SizedBox()
                                  : CustomRulerTimelineOtherAssetsWidget1(
                                minValue: minValue,
                                maxValue: maxValue,
                                value: value,
                                majorTick: 10,
                                minorTick: 1,
                                labelValuePrecision: 0,
                                tickValuePrecision: 0,
                                onChanged: (val) => setState(() {
                                  value = val;
                                  actualValue = val.roundToDouble();
                                }),
                                activeColor: AppColor.primaryLightColor,
                                inactiveColor: AppColor.primaryLightColor.withOpacity(0.2),
                                linearStep: true,
                                totalSeconds: ((maxValue - minValue) / 1).toInt() + 1,
                                scrollController: _rulerScrollController,
                                maxPaddingValue: editorController.maxPaddingValue,
                                minPaddingValue: editorController.minPaddingValue,
                              ),
                              const Divider(color: Colors.grey),
                              // Custom widget for the Reorderable ListView
                              _buildReorderableList(
                                controller: _listScrollControllerVideo,
                                itemCount: editorController.editVideoDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.purple,
                                dataList: editorController.editVideoDataList,
                                selectedIndex: editorController.selectedVideoIndex,
                              ),
                              const Divider(color: Colors.grey),
                              _buildReorderableList(
                                controller: _listScrollControllerImage,
                                itemCount: editorController.editImageDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.orange,
                                dataList: editorController.editImageDataList,
                                selectedIndex: editorController.selectedImageIndex,
                              ),
                              const Divider(color: Colors.grey),
                              _buildReorderableList(
                                controller: _listScrollControllerAudio,
                                itemCount: editorController.editAudioDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.red,
                                dataList: editorController.editAudioDataList,
                                selectedIndex: editorController.selectedAudioIndex,
                              ),
                              const Divider(color: Colors.grey),
                              _buildReorderableList(
                                controller: _listScrollControllerText,
                                itemCount: editorController.editTextDataList.length,
                                totalItemCount: totalItemCount,
                                color: Colors.green,
                                dataList: editorController.editTextDataList,
                                selectedIndex: editorController.selectedTextIndex,
                              ),
                              const Divider(color: Colors.grey),
                              SizedBox(height: 1.h),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: SizedBox(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  child: SliderTheme(
                                    data: const SliderThemeData(
                                      overlayColor: Colors.transparent,
                                      overlayShape: RoundSliderThumbShape(),
                                      rangeTrackShape: RectangularRangeSliderTrackShape(),
                                      rangeThumbShape: RoundRangeSliderThumbShape(elevation: 0),
                                      thumbColor: Colors.transparent,
                                    ),
                                    child: RangeSlider(
                                      values: RangeValues(editorController.minPaddingValue, editorController.maxPaddingValue),
                                      min: 10,
                                      max: 80,
                                      onChanged: (RangeValues values) {
                                        setState(() {
                                          editorController.minPaddingValue = values.start > 25 ? 25 : values.start;
                                          editorController.maxPaddingValue = values.end < 30 ? 30 : values.end;
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
                            IconButton(onPressed: () {}, icon: const Icon(Icons.add, size: 27)),
                            Obx(() {
                              List<ActionEditorModel>? currentActions;
                              if (editorController.selectedVideoIndex.value != null) {
                                currentActions = editorController.videoAction;
                              } else if (editorController.selectedAudioIndex.value != null) {
                                currentActions = editorController.audioAction;
                              } else if (editorController.selectedTextIndex.value != null) {
                                currentActions = editorController.textAction;
                              }

                              return currentActions != null
                                  ? PopupMenuButton(
                                color: Colors.grey.withOpacity(0.8),
                                child: const Icon(Icons.menu),
                                itemBuilder: (context) {
                                  return List.generate(currentActions!.length, (index) {
                                    var model = currentActions![index];
                                    return PopupMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text('${model.nameItem}')),
                                      ),
                                      onTap: () {
                                        model.onTap();
                                      },
                                    );
                                  });
                                },
                              )
                                  : const SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Other UI elements (Stop Button, Close Button, Done Button, etc.)
              ],
            ),
            Obx(() {
              return Visibility(
                visible: editorController.isloadingSubmit.value,
                child: SizedBox.expand(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: const Center(
                      child: CircularProgressIndicator(),
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

  // Custom widget for reusable ReorderableListView.builder
  Widget _buildReorderableList({
    required ScrollController controller,
    required int itemCount,
    required int totalItemCount,
    required Color color,
    required RxList<EditDataModel> dataList,
    required dynamic selectedIndex,
  }) {
    return Obx(
          () => SizedBox(
        height: MediaQuery.of(context).size.height * 0.050,
        child: ReorderableListView.builder(
          scrollDirection: Axis.horizontal,
          scrollController: controller,
          itemCount: dataList.length + totalItemCount,
          itemBuilder: (context, index) {
            if (index < dataList.length) {
              var model = dataList[index];
              return GestureDetector(
                key: ValueKey('item_$index'),
                onTap: () {
                  setState(() {
                    selectedIndex.value = index;
                  });
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
              return _buildInfiniteScrollContainer();
            }
          },
          proxyDecorator: (child, index, animation) =>
              _proxyDecorator(child, index, animation, color, color.withOpacity(0.5)),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) newIndex -= 1;
              final item = dataList.removeAt(oldIndex);
              dataList.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }

  Widget _buildInfiniteScrollContainer() {
    return Container(
      key: const ValueKey('orange'),
      width: 100000.0,
      color: Colors.transparent,
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
