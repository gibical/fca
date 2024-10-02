
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_config.dart';
import '../logic.dart';


class EditeBoxWidget extends StatefulWidget {
  const EditeBoxWidget({
    Key? key,
    required this.index,
    required this.model,
    required this.scrollController,
    required this.color,
    required this.removeItem,
  }) : super(key: key);

  final EditDataModel model;
  final int index;
  final ScrollController scrollController;
  final Color? color;
  final Function() removeItem;

  @override
  State<EditeBoxWidget> createState() => _EditeBoxWidgetState();
}

class _EditeBoxWidgetState extends State<EditeBoxWidget> {
  Timer? _resizeTimer;

  double _lastPanUpdateDx = 0.0;
  int _currentResizingIndex = -1;
  bool _isTransparentContainerAdded = true;
  bool _isForward = true;

  MediaSuitController editorController = Get.find<MediaSuitController>();
  bool isSelected = false;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!_isTransparentContainerAdded &&
        widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 50) {
      setState(() {
        if (editorController.editImageDataList.isEmpty ||
            editorController.editImageDataList.last.width != 500.0) {
          editorController.editImageDataList
              .add(EditDataModel('', 'urlMedia', null, '', 0));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedVideoIndex = editorController.selectedVideoIndex.value;
    final selectedImageIndex = editorController.selectedImageIndex.value;
    final selectedAudioIndex = editorController.selectedAudioIndex.value;
    final selectedTextIndex = editorController.selectedTextIndex.value;

    isSelected = widget.color == Colors.purple
        ? selectedVideoIndex == widget.index
        : widget.color == Colors.orange
            ? selectedImageIndex == widget.index
            : widget.color == Colors.red
                ? selectedAudioIndex == widget.index
                : selectedTextIndex == widget.index;
    return GetBuilder<MediaSuitController>(builder: (c) {
      return AnimatedOpacity(

        opacity: isSelected ? 1.0 : 0.3,
        duration: Duration(milliseconds: Constant.animatiomDuration),
        child: Row(
          children: [
            Container(
              height: 100.0,
              color: Colors.white,
              width: 1,
            ),
            Container(
              key: widget.key,
              height: 100.0,
              child: Stack(
                children: [
                  Container(
                    width: widget.model.width +  editorController.maxPaddingValue -editorController.minPaddingValue,
                    color: widget.color,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      widget.model.name ,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  isSelected && editorController.isTrimming
                      ? Positioned(
                          left: widget.model.startTrim * 30.0,
                          top: 0,
                          bottom: 0,
                          right: (widget.model.second - widget.model.endTrim) *
                              30.0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 100,
                                color: Colors.black.withOpacity(0.6),


                              ),
                              Positioned(
                                left: 0,

                                child: GestureDetector(
                                    onPanUpdate: (details) {
                                      setState(() {
                                        widget.model.startTrim +=
                                            details.delta.dx / 30.0;
                                        // if (widget.model.startTrim < 0) {
                                        //   widget.model.startTrim = 0;
                                        // }
                                        // if (widget.model.startTrim >
                                        //     widget.model.endTrim) {
                                        //   widget.model.startTrim =
                                        //       widget.model.endTrim;
                                        // }
                                        if (( widget.model.endTrim -  widget.model.startTrim) < 2.0) {
                                          widget. model.startTrim = widget. model.endTrim - 2.0;
                                        }


                                        if ( widget.model.startTrim < 0) {
                                          widget.model.startTrim = 0;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: MediaQuery.of(context).size.height * 0.050,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 1.7
                                          )
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    )),
                              ),
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                    onPanUpdate: (details) {
                                      setState(() {
                                        widget.model.endTrim +=
                                            details.delta.dx / 30.0;
                                        // if (widget.model.endTrim >
                                        //     widget.model.second) {
                                        //   widget.model.endTrim =
                                        //       widget.model.second;
                                        // }
                                        // if (widget.model.endTrim <
                                        //     widget.model.startTrim) {
                                        //   widget.model.endTrim =
                                        //       widget.model.startTrim;
                                        // }
                                        if (( widget.model.endTrim -  widget.model.startTrim) <
                                            2.0) {
                                          widget.model.endTrim =  widget.model.startTrim + 2.0;
                                        }


                                        if ( widget.model.endTrim >  widget.model.second) {
                                          widget.model.endTrim =  widget.model.second;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: MediaQuery.of(context).size.height * 0.050,

                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.7
                                        )
                                      ),

                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  isSelected && editorController.isTrimming == false
                      ? Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onPanStart: (details) {
                              _resizeTimer?.cancel();
                              _lastPanUpdateDx = details.localPosition.dx;
                              _currentResizingIndex = widget.index;
                              setState(() {
                                editorController.isResizing = true;
                              });
                            },
                            onPanUpdate: (details) {
                              if (_currentResizingIndex == widget.index) {
                                setState(() {
                                  double deltaDx = details.localPosition.dx -
                                      _lastPanUpdateDx;
                                  _lastPanUpdateDx = details.localPosition.dx;

                                  widget.model.second += deltaDx / 30.0;
                                  if (widget.model.second < 3.0) {
                                    widget.model.second = 3.0;
                                  }

                                  _resizeTimer?.cancel();
                                  _resizeTimer = Timer.periodic(
                                      Duration(milliseconds: 16), (timer) {
                                    setState(() {});
                                  });
                                });
                              }
                            },
                            onPanEnd: (details) {
                              _resizeTimer?.cancel();
                              _resizeTimer = null;
                              _currentResizingIndex = -1;
                              setState(() {
                                editorController.isResizing = false;
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  color: widget.color,
                                  width: 30.0,
                                  height: 100.0,
                                ),
                                Container(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 30.0,
                                  height: 100.0,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.white,
                                      size: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  isSelected && editorController.isTrimming == false
                      ? Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: AppColor.primaryDarkColor,
                                  child: SizedBox(
                                    height: 159,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7.w,
                                        vertical: 3.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(widget.model.name),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            'Delete this media?',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  widget.removeItem();
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Text('No'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              editorController.selectedTextIndex.value = null;
                              editorController.selectedVideoIndex.value = null;
                              editorController.selectedImageIndex.value = null;
                              editorController.selectedAudioIndex.value = null;
                            },
                            child: AnimatedOpacity(
                              opacity: isSelected ? 1.0 : 0.2,
                              duration: Duration(
                                  milliseconds: Constant.animatiomDuration),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 6.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: isSelected
                                        ? Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 10.sp,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Container(
              height: 100.0,
              color: Colors.white,
              width: 1,
            ),
          ],
        ),
      );
    });
  }

  double _getContainerWidth(int index) {
    double width = 0.0;
    for (int i = 0; i <= index; i++) {
      width += editorController.editImageDataList[i].width;
    }
    width += 16 * (index + 1); // Add margin for each container
    return width;
  }
}
