// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:mediaverse/app/common/app_color.dart';
// import 'package:mediaverse/app/common/app_config.dart';
// import 'package:mediaverse/app/pages/media_suit/logic.dart';
// import 'package:sizer/sizer.dart';
//
// class TimeLineWidget extends StatefulWidget {
//   EditDataModel model;
//   Color color;
//   String name;
//   Key key;
//   int index;
//   Function() removeItem;
//
//   TimeLineWidget(
//       {required this.model,
//         required this.color,
//         required this.name,
//         required this.key,
//         required this.index,
//         required this.removeItem});
//
//   @override
//   State<TimeLineWidget> createState() => _TimeLineWidgetState();
// }
//
// class _TimeLineWidgetState extends State<TimeLineWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final mediaController = Get.find<MediaSuitController>();
//     final selectedVideoIndex = mediaController.selectedVideoIndex.value;
//     final selectedImageIndex = mediaController.selectedImageIndex.value;
//     final selectedAudioIndex = mediaController.selectedAudioIndex.value;
//     final selectedTextIndex = mediaController.selectedTextIndex.value;
//
//     Color color;
//     if (widget.color == Colors.purple) {
//       color = Colors.purple;
//     } else if (widget.color == Colors.orange) {
//       color = Colors.orange;
//     } else if (widget.color == Colors.red) {
//       color = Colors.red;
//     } else if (widget.color == Colors.green) {
//       color = Colors.green;
//     }
//
//     return GestureDetector(
//       key: widget.key,
//       onTap: () {
//
//
//         if (widget.color == Colors.purple) {
//           mediaController.selectedVideoIndex.value =
//           mediaController.selectedVideoIndex.value == widget.index ? null : widget.index;
//           mediaController.selectedImageIndex.value = null;
//           mediaController.selectedAudioIndex.value = null;
//           mediaController.selectedTextIndex.value = null;
//         } else if (widget.color == Colors.orange) {
//           mediaController.selectedImageIndex.value =
//           mediaController.selectedImageIndex.value == widget.index ? null : widget.index;
//           mediaController.selectedVideoIndex.value = null;
//           mediaController.selectedAudioIndex.value = null;
//           mediaController.selectedTextIndex.value = null;
//         } else if (widget.color == Colors.red) {
//           mediaController.selectedAudioIndex.value =
//           mediaController.selectedAudioIndex.value == widget.index ? null : widget.index;
//           mediaController.selectedVideoIndex.value = null;
//           mediaController.selectedImageIndex.value = null;
//           mediaController.selectedTextIndex.value = null;
//         } else if (widget.color == Colors.green) {
//           mediaController.selectedTextIndex.value =
//           mediaController.selectedTextIndex.value == widget.index ? null : widget.index;
//           mediaController.selectedVideoIndex.value = null;
//           mediaController.selectedImageIndex.value = null;
//           mediaController.selectedAudioIndex.value = null;
//         }
//         setState(() {});
//       },
//
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: Constant.animatiomDuration),
//         width: widget.model.witdh,
//         height: widget.model.hight,
//         decoration: BoxDecoration(
//           color: widget.color,
//           border: Border.all(
//             color:  Colors.white,
//
//             width: 2,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Center(child: Text(widget.name)),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.dialog(
//                       Dialog(
//                         backgroundColor: AppColor.primaryDarkColor,
//                         child: SizedBox(
//                           height: 159,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 7.w,
//                               vertical: 3.h,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(widget.name),
//                                 SizedBox(
//                                   height: 1.h,
//                                 ),
//                                 Text(
//                                   'Delete this media?',
//                                   style: TextStyle(
//                                     color: Colors.white.withOpacity(0.7),
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         widget.removeItem();
//                                         Get.back();
//                                       },
//                                       child: Text(
//                                         'Yes',
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 7.w,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.back();
//                                       },
//                                       child: Text('No'),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   child: AnimatedOpacity(
//                     opacity: 1
//                     ,
//                     duration:
//                     Duration(milliseconds: Constant.animatiomDuration),
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         width: 6.w,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                             size: 10.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   onPanUpdate: _onHorizontalDragUpdate,
//                   child: AnimatedOpacity(
//                     opacity:  1
//                  ,
//                     duration:
//                     Duration(milliseconds: Constant.animatiomDuration),
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         width: 5.w,
//                         height: 3.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(5),
//                             bottomLeft: Radius.circular(5),
//                           ),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.arrow_forward_ios_sharp,
//                             color: Colors.black,
//                             size: 8.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void _onHorizontalDragUpdate(DragUpdateDetails details) {
//     setState(() {
//       widget.model.witdh += details.delta.dx;
//       // height += details.delta.dy;
//     });
//   }
// }
//
//
//
//




//////v2
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:mediaverse/app/common/app_color.dart';
// import 'package:mediaverse/app/common/app_config.dart';
// import 'package:mediaverse/app/pages/media_suit/logic.dart';
// import 'package:sizer/sizer.dart';
//
// class TimeLineWidget extends StatefulWidget {
//   EditDataModel model;
//   Color color;
//   String name;
//   Key key;
//   int index;
//   Function() removeItem;
//
//   TimeLineWidget({
//     required this.model,
//     required this.color,
//     required this.name,
//     required this.key,
//     required this.index,
//     required this.removeItem,
//   });
//
//   @override
//   State<TimeLineWidget> createState() => _TimeLineWidgetState();
// }
//
// class _TimeLineWidgetState extends State<TimeLineWidget> {
//   bool isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaController = Get.find<MediaSuitController>();
//
//     final selectedVideoIndex = mediaController.selectedVideoIndex.value;
//     final selectedImageIndex = mediaController.selectedImageIndex.value;
//     final selectedAudioIndex = mediaController.selectedAudioIndex.value;
//     final selectedTextIndex = mediaController.selectedTextIndex.value;
//
//     isSelected = widget.color == Colors.purple
//         ? selectedVideoIndex == widget.index
//         : widget.color == Colors.orange
//         ? selectedImageIndex == widget.index
//         : widget.color == Colors.red
//         ? selectedAudioIndex == widget.index
//         : selectedTextIndex == widget.index;
//     int tapCount = 0;
//     return GestureDetector(
//       key: widget.key,
//       onTap: () {
//         setState(() {
//           if (isSelected) {
//             // If already selected, do nothing
//             return;
//           } else {
//             // If not selected, select it and deselect others
//             if (widget.color == Colors.purple) {
//               mediaController.selectedVideoIndex.value = widget.index;
//               mediaController.selectedImageIndex.value = null;
//               mediaController.selectedAudioIndex.value = null;
//               mediaController.selectedTextIndex.value = null;
//             } else if (widget.color == Colors.orange) {
//               mediaController.selectedImageIndex.value = widget.index;
//               mediaController.selectedVideoIndex.value = null;
//               mediaController.selectedAudioIndex.value = null;
//               mediaController.selectedTextIndex.value = null;
//
//             } else if (widget.color == Colors.red) {
//               mediaController.selectedAudioIndex.value = widget.index;
//               mediaController.selectedVideoIndex.value = null;
//               mediaController.selectedImageIndex.value = null;
//               mediaController.selectedTextIndex.value = null;
//             } else if (widget.color == Colors.green) {
//               mediaController.selectedTextIndex.value = widget.index;
//               mediaController.selectedVideoIndex.value = null;
//               mediaController.selectedImageIndex.value = null;
//               mediaController.selectedAudioIndex.value = null;
//             }
//           }
//         });
//
//         mediaController.update(); // Update GetX controller
//       },
//
//
//       child: GetBuilder<MediaSuitController>(
//         builder: (c) {
//           return AnimatedOpacity(
//             opacity: isSelected ? 1.0 : 0.3,
//             duration:
//             Duration(milliseconds: Constant.animatiomDuration),
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: Constant.animatiomDuration),
//               width: widget.model.witdh,
//               height: widget.model.hight,
//               decoration: BoxDecoration(
//                 color: widget.color,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 2,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Center(child: Text(widget.name)),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Get.dialog(
//                             Dialog(
//                               backgroundColor: AppColor.primaryDarkColor,
//                               child: SizedBox(
//                                 height: 159,
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 7.w,
//                                     vertical: 3.h,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(widget.name),
//                                       SizedBox(
//                                         height: 1.h,
//                                       ),
//                                       Text(
//                                         'Delete this media?',
//                                         style: TextStyle(
//                                           color: Colors.white.withOpacity(0.7),
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Row(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               widget.removeItem();
//                                               Get.back();
//                                             },
//                                             child: Text(
//                                               'Yes',
//                                               style: TextStyle(color: Colors.red),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 7.w,
//                                           ),
//                                           GestureDetector(
//                                             onTap: () {
//                                               Get.back();
//                                             },
//                                             child: Text('No'),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         child: AnimatedOpacity(
//                           opacity: isSelected ? 1.0 : 0.2,
//                           duration:
//                           Duration(milliseconds: Constant.animatiomDuration),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               width: 6.w,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                               ),
//                               child: Center(
//                                 child: isSelected ?Icon(
//                                   Icons.delete,
//                                   color: Colors.white,
//                                   size: 10.sp,
//                                 ):SizedBox(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       GestureDetector(
//                         onPanUpdate: _onHorizontalDragUpdate,
//                         child: AnimatedOpacity(
//                           opacity: isSelected ? 1.0 : 0.5,
//                           duration:
//                           Duration(milliseconds: Constant.animatiomDuration),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               width: 5.w,
//                               height: 3.h,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(5),
//                                   bottomLeft: Radius.circular(5),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.arrow_forward_ios_sharp,
//                                   color: Colors.black,
//                                   size: 8.sp,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }
//
//   void _onHorizontalDragUpdate(DragUpdateDetails details) {
//     setState(() {
//       widget.model.witdh += details.delta.dx;
//     });
//   }
// }
import 'dart:async';

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

class TimeLineWidget extends StatefulWidget {
  EditDataModel model;
  Color color;
  String name;

  int index;
  Function() removeItem;

  TimeLineWidget({
    required this.model,
    required this.color,
    required this.name,

    required this.index,
    required this.removeItem,
  });

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  widget.model.updateTimings((80 / 6).toInt(), 0);
  }
  @override
  Widget build(BuildContext context) {
    final mediaController = Get.find<MediaSuitController>();

    final selectedVideoIndex = mediaController.selectedVideoIndex.value;
    final selectedImageIndex = mediaController.selectedImageIndex.value;
    final selectedAudioIndex = mediaController.selectedAudioIndex.value;
    final selectedTextIndex = mediaController.selectedTextIndex.value;

    isSelected = widget.color == Colors.purple
        ? selectedVideoIndex == widget.index
        : widget.color == Colors.orange
        ? selectedImageIndex == widget.index
        : widget.color == Colors.red
        ? selectedAudioIndex == widget.index
        : selectedTextIndex == widget.index;



    return




      GetBuilder<MediaSuitController>(
          builder: (c) {
            return AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.3,
              duration:
              Duration(milliseconds: Constant.animatiomDuration),
              child: AnimatedContainer(
                duration: Duration(milliseconds: Constant.animatiomDuration),
            //    width: (mediaController.maxPaddingValue + mediaController.minPaddingValue )* 3 + widget.model.witdh  ,
                width: (mediaController.maxPaddingValue + mediaController.minPaddingValue) * 3 +
                    (mediaController.editVideoDataList.contains(widget.model)
                        ? widget.model.defaultWidthVideo!
                        : widget.model.width),
                height: widget.model.height,
                decoration: BoxDecoration(
                  color: widget.color,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(child: Text(widget.name , style: GoogleFonts.inter().copyWith(
                      fontSize: 9
                    ),)),
                    Row(
                      children: [
                        isSelected ?     GestureDetector(
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
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(widget.name),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          'Delete this media?',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.7),
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
                                                style: TextStyle(color: Colors.red),
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
                            mediaController.selectedTextIndex
                                .value = null;
                            mediaController.selectedVideoIndex
                                .value = null;
                            mediaController.selectedImageIndex
                                .value = null;
                            mediaController.selectedAudioIndex
                                .value = null;
                          },
                          child: AnimatedOpacity(
                            opacity: isSelected ? 1.0 : 0.2,
                            duration:
                            Duration(milliseconds: Constant.animatiomDuration),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 6.w,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: isSelected ?Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 10.sp,
                                  ):SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ) : SizedBox(),
                        Spacer(),
                        GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              widget.model.width += details.delta.dx;

                              if (widget.model.width < 80) {
                                widget.model.width = 80;
                              }
                             widget.model.updateTimings((80 / 6).toInt(), 0 );
                            });
                          },
                          child: AnimatedOpacity(
                            opacity: isSelected ? 1.0 : 0.5,
                            duration:
                            Duration(milliseconds: Constant.animatiomDuration),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 5.w,
                                height: 3.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.black,
                                    size: 8.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: widget.model.isloading,
                      child: SizedBox.expand(

                        child: Container(
                          color: Colors.black.withOpacity(0.85),
                          child: Center(
                            child: Lottie.asset("assets/json/Y8IBRQ38bK.json"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      );

  }

}

class EditeBoxWidget extends StatefulWidget {
  const EditeBoxWidget({
    Key? key,
    required this.index,
    required this.model,

    required this.scrollController, required this.color, required this.removeItem,
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


    if ( widget.model.defaultWidthVideo != null) {
      widget.model.width = widget.model.defaultWidthVideo!;
    }

    widget.scrollController.addListener(_scrollListener);
    widget.model.updateTimings((80 / 6).toInt(), 0);
  }

  void _scrollListener() {
    if (!_isTransparentContainerAdded &&
        widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 50) {
      setState(() {
        if (editorController.editImageDataList.isEmpty ||
            editorController.editImageDataList.last.width != 500.0) {
          editorController.editImageDataList.add(
              EditDataModel('', 'urlMedia', null, ''  , 0)
          );
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
    return GetBuilder<MediaSuitController>(builder: (c){
      return AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.3,
        duration:
        Duration(milliseconds: Constant.animatiomDuration),
        child: Container(
          key: widget.key,

          height: 100.0,
          child: Row(
            children: [
              isSelected ?     GestureDetector(
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(widget.model.name),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                'Delete this media?',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
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
                                      style: TextStyle(color: Colors.red),
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
                  editorController.selectedTextIndex
                      .value = null;
                  editorController.selectedVideoIndex
                      .value = null;
                  editorController.selectedImageIndex
                      .value = null;
                  editorController.selectedAudioIndex
                      .value = null;
                },
                child: AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.2,
                  duration:
                  Duration(milliseconds: Constant.animatiomDuration),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 6.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Center(
                        child: isSelected ?Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 10.sp,
                        ):SizedBox(),
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(),
              Container(
                width: (editorController.maxPaddingValue + editorController.minPaddingValue) * 2 + widget.model.width,
                color: widget.color,
                alignment: Alignment.center,
                child: Text(
                  widget.model.name ,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              GestureDetector(
                onPanStart: (details) {
                  _resizeTimer?.cancel();
                  _lastPanUpdateDx = details.localPosition.dx;
                  _currentResizingIndex = widget.index;
                },
                onPanUpdate: (details) {
                  if (_currentResizingIndex == widget.index) {
                    setState(() {
                      double deltaDx = details.localPosition.dx - _lastPanUpdateDx;
                      _lastPanUpdateDx = details.localPosition.dx;

                      _isForward = deltaDx > 0;

                      widget.model.width += deltaDx;
                      if (widget.model.width < 30.0) {
                        widget.model.width = 30.0;
                      }

                      if (_resizeTimer == null) {
                        _resizeTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
                          setState(() {
                            double scrollOffset = widget.scrollController.offset;
                            double containerWidth = _getContainerWidth(widget.index);
                            double screenWidth = MediaQuery.of(context).size.width;

                            if (_isForward) {
                              widget.model.width += 0.5;
                              if (scrollOffset + screenWidth < containerWidth) {
                                double newOffset = scrollOffset + 0.5;
                                widget.scrollController.jumpTo(newOffset);
                              }
                            } else {
                              widget.model.width -= 0.5;
                              if (widget.model.width < 30.0) {
                                widget.model.width = 30.0;
                              }
                              if (scrollOffset > 0) {
                                double newOffset = scrollOffset - 0.5;
                                widget.scrollController.jumpTo(newOffset);
                              }
                            }
                          });
                        });
                      }
                      widget.model.updateTimings((80 / 6).toInt(), 0 );
                    });
                  }
                },
                onPanEnd: (details) {
                  _resizeTimer?.cancel();
                  _resizeTimer = null;
                  _currentResizingIndex = -1;
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

            ],
          ),
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
