// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// class CustomRulerTimelineOtherAssetsWidget1 extends StatefulWidget {
//   final double value;
//   final double minValue;
//   final double maxValue;
//   final int majorTick;
//   final int minorTick;
//   final Function(double)? onChanged;
//   final Color? activeColor;
//   final Color? inactiveColor;
//   final int labelValuePrecision;
//   final int tickValuePrecision;
//   final bool linearStep;
//   final int totalSteps;
//   final ScrollController? scrollController;
//   final ScrollController? listScrollController;
//   final double minPaddingValue;
//   final double maxPaddingValue;
//
//   CustomRulerTimelineOtherAssetsWidget1({
//     required this.value,
//     required this.minValue,
//     required this.maxValue,
//     required this.majorTick,
//     required this.minorTick,
//     required this.onChanged,
//     this.activeColor,
//     this.inactiveColor,
//     this.labelValuePrecision = 2,
//     this.tickValuePrecision = 1,
//     this.linearStep = true,
//     required this.totalSteps,
//     this.scrollController,
//     this.listScrollController,
//     required this.minPaddingValue,
//     required this.maxPaddingValue,
//   });
//
//   @override
//   _CustomRulerTimelineOtherAssetsWidget1State createState() =>
//       _CustomRulerTimelineOtherAssetsWidget1State();
// }
//
// class _CustomRulerTimelineOtherAssetsWidget1State
//     extends State<CustomRulerTimelineOtherAssetsWidget1> {
//   late double _sliderValue;
//   bool _isRulerScrolling = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _sliderValue = widget.value;
//     if (widget.scrollController != null) {
//       widget.scrollController!.addListener(_rulerScrollListener);
//     }
//     if (widget.listScrollController != null) {
//       widget.listScrollController!.addListener(_listScrollListener);
//     }
//   }
//
//   @override
//   void dispose() {
//     if (widget.scrollController != null) {
//       widget.scrollController!.removeListener(_rulerScrollListener);
//     }
//     if (widget.listScrollController != null) {
//       widget.listScrollController!.removeListener(_listScrollListener);
//     }
//     super.dispose();
//   }
//
//   @override
//   void didUpdateWidget(CustomRulerTimelineOtherAssetsWidget1 oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Update _sliderValue when the value property changes
//     if (oldWidget.value != widget.value) {
//       setState(() {
//         _sliderValue = widget.value;
//       });
//     }
//   }
//
//   void _rulerScrollListener() {
//     if (!_isRulerScrolling) {
//       _isRulerScrolling = true;
//       final newPosition = widget.scrollController!.offset;
//       final divisions = (widget.majorTick - 1) * widget.minorTick + widget.majorTick;
//       final stepWidth = MediaQuery.of(context).size.width / divisions;
//       final newSliderValue = newPosition / stepWidth;
//
//       // Ensure the slider value does not exceed the maximum value
//       final maxSliderValue = widget.maxValue;
//       if (newSliderValue > maxSliderValue) {
//         setState(() {
//           _sliderValue = maxSliderValue;
//         });
//         if (widget.onChanged != null) {
//           widget.onChanged!(maxSliderValue);
//         }
//         if (widget.listScrollController != null) {
//           final newPosition = maxSliderValue * (MediaQuery.of(context).size.width / divisions);
//           widget.listScrollController!.jumpTo(newPosition);
//         }
//       } else {
//         setState(() {
//           _sliderValue = newSliderValue;
//         });
//         if (widget.onChanged != null) {
//           widget.onChanged!(newSliderValue);
//         }
//         if (widget.listScrollController != null) {
//           final newPosition = newSliderValue * (MediaQuery.of(context).size.width / divisions);
//           widget.listScrollController!.jumpTo(newPosition);
//         }
//       }
//     }
//     _isRulerScrolling = false;
//   }
//
//   void _listScrollListener() {
//     if (!_isRulerScrolling) {
//       _isRulerScrolling = true;
//       final newPosition = widget.listScrollController!.offset;
//       final divisions =
//           (widget.majorTick - 1) * widget.minorTick + widget.majorTick;
//       final stepWidth = MediaQuery.of(context).size.width / divisions;
//       final newSliderValue = newPosition / stepWidth;
//
//       // Ensure the slider value stays within the minimum and maximum values
//       final minSliderValue = widget.minValue;
//       final maxSliderValue = widget.maxValue;
//       final clampedValue = newSliderValue.clamp(minSliderValue, maxSliderValue);
//
//       setState(() {
//         _sliderValue = clampedValue;
//       });
//
//       if (widget.scrollController != null) {
//         // Adjust the position of the other scroll controller
//         final newPosition = clampedValue * (MediaQuery.of(context).size.width / divisions);
//         widget.scrollController!.jumpTo(newPosition);
//       }
//     }
//     _isRulerScrolling = false;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final allocatedHeight = MediaQuery.of(context).size.height;
//     final allocatedWidth = MediaQuery.of(context).size.width;
//     final divisions =
//         (widget.majorTick - 1) * widget.minorTick + widget.majorTick;
//     final double valueHeight =
//     allocatedHeight * 0.05 < 41 ? 23 : allocatedHeight * 0.05;
//     final double tickHeight =
//     allocatedHeight * 0.025 < 20 ? 20 : allocatedHeight * 0.020;
//     final labelOffset = allocatedWidth / divisions / 2;
//
//     return Column(
//       children: [
//         SliderTheme(
//           data: SliderThemeData(
//             trackHeight: allocatedHeight * 0.011 < 9
//                 ? 9
//                 : allocatedHeight * 0.011,
//             activeTickMarkColor: widget.activeColor ?? Colors.purple,
//             inactiveTickMarkColor:
//             widget.inactiveColor ?? Colors.purple.shade50,
//             activeTrackColor: widget.activeColor ?? Colors.purple,
//             inactiveTrackColor:
//             widget.inactiveColor ?? Colors.purple.shade50,
//             thumbColor: Colors.transparent,
//             overlayColor: widget.activeColor == null
//                 ? Colors.purple.withOpacity(0.1)
//                 : widget.activeColor!.withOpacity(0.1),
//             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
//             trackShape: CustomTrackShape(),
//             showValueIndicator: ShowValueIndicator.never,
//             valueIndicatorTextStyle: TextStyle(
//               fontSize: 12,
//             ),
//           ),
//           child: Slider(
//             value: _sliderValue,
//             min: widget.minValue,
//             max: widget.maxValue,
//             divisions: divisions - 1,
//             onChanged: (val) {
//               // Update the value and notify the parent widget
//               setState(() {
//                 _sliderValue = val;
//               });
//               if (widget.onChanged != null) {
//                 widget.onChanged!(val);
//               }
//               if (widget.listScrollController != null) {
//                 final newPosition =
//                     val * (MediaQuery.of(context).size.width / divisions);
//                 widget.listScrollController!.jumpTo(newPosition);
//               }
//             },
//             label: _sliderValue.toStringAsFixed(widget.labelValuePrecision),
//           ),
//         ),
//         Container(
//           color: Colors.grey.withOpacity(0.3),
//           height: 40,
//           child: SingleChildScrollView(
//             controller: widget.scrollController,
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate(
//                 widget.totalSteps,
//                     (index) => Container(
//                   alignment: Alignment.bottomCenter,
//                   width: 3.w,
//                   margin: EdgeInsets.only(
//                     left: index == 0 ? 0 : widget.minPaddingValue,
//                     right: index == widget.totalSteps - 1 ? 0 : widget.maxPaddingValue ,
//                   ),
//                   child: Column(
//                     children: [
//                       Transform.scale(
//                         scale: .7,
//                         child: Container(
//                           alignment: Alignment.bottomCenter,
//                           height: tickHeight,
//                           child: VerticalDivider(
//                             indent: index % (widget.minorTick + 1) == 0 ? 1 : 6,
//                             thickness: 1.2,
//                             color: (index / (widget.totalSteps - 1) * widget.maxValue)
//                                 .roundToDouble() ==
//                                 _sliderValue.roundToDouble()
//                                 ? widget.activeColor ?? Colors.purple
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         alignment: Alignment.bottomCenter,
//                         height: valueHeight-28,
//                         child: index % (widget.minorTick + 1) == 0
//                             ? Text(
//                           '${(index / (widget.totalSteps - 1) * widget.maxValue + 1).round()}',
//                           style: TextStyle(fontSize: 8, color: Colors.white),
//                           textAlign: TextAlign.center,
//                         )
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
// }
//
// class CustomTrackShape extends RectangularSliderTrackShape {
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final double trackHeight = sliderTheme.trackHeight!;
//     final double trackLeft = offset.dx;
//     final double trackTop = offset.dy + (parentBox.size.height - trackHeight);
//     final double trackWidth = parentBox.size.width;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
// }
import 'package:flutter/material.dart';

class CustomRulerTimelineOtherAssetsWidget1 extends StatefulWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final int majorTick;
  final int minorTick;
  final Function(double)? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final int labelValuePrecision;
  final int tickValuePrecision;
  final bool linearStep;
  final int totalSeconds; // Total seconds
  final ScrollController? scrollController;
  final ScrollController? listScrollController;
  final double minPaddingValue;
  final double maxPaddingValue;

  CustomRulerTimelineOtherAssetsWidget1({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.majorTick,
    required this.minorTick,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.labelValuePrecision = 2,
    this.tickValuePrecision = 1,
    this.linearStep = true,
     required this.totalSeconds, // Changed to totalSeconds
    this.scrollController,
    this.listScrollController,
    required this.minPaddingValue,
    required this.maxPaddingValue,
  });

  @override
  _CustomRulerTimelineOtherAssetsWidget1State createState() =>
      _CustomRulerTimelineOtherAssetsWidget1State();
}

class _CustomRulerTimelineOtherAssetsWidget1State
    extends State<CustomRulerTimelineOtherAssetsWidget1> {
  late double _sliderValue;
  bool _isRulerScrolling = false;

  @override
  void initState() {
    super.initState();
    // _sliderValue = widget.value;
    // if (widget.scrollController != null) {
    //   widget.scrollController!.addListener(_rulerScrollListener);
    // }
    // if (widget.listScrollController != null) {
    //   widget.listScrollController!.addListener(_listScrollListener);
    // }
    _sliderValue = widget.value.clamp(widget.minValue, widget.maxValue);
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_rulerScrollListener);
    }
    if (widget.listScrollController != null) {
      widget.listScrollController!.addListener(_listScrollListener);
    }
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_rulerScrollListener);
    }
    if (widget.listScrollController != null) {
      widget.listScrollController!.removeListener(_listScrollListener);
    }
    super.dispose();
  }

  // @override
  // void didUpdateWidget(CustomRulerTimelineOtherAssetsWidget1 oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // Update _sliderValue when the value property changes
  //   if (oldWidget.value != widget.value) {
  //     setState(() {
  //       _sliderValue = widget.value;
  //     });
  //   }
  // }
  @override
  void didUpdateWidget(CustomRulerTimelineOtherAssetsWidget1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _sliderValue = widget.value.clamp(widget.minValue, widget.maxValue);
      });
    }
  }

  // void _rulerScrollListener() {
  //   if (!_isRulerScrolling) {
  //     _isRulerScrolling = true;
  //     final newPosition = widget.scrollController!.offset;
  //     final divisions = widget.totalSeconds;
  //     final stepWidth = 10.0; // 10 pixels for each second
  //     final newSliderValue = newPosition / stepWidth;
  //
  //     // Ensure the slider value does not exceed the maximum value
  //     final maxSliderValue = widget.maxValue;
  //     if (newSliderValue > maxSliderValue) {
  //       setState(() {
  //         _sliderValue = maxSliderValue;
  //       });
  //       if (widget.onChanged != null) {
  //         widget.onChanged!(maxSliderValue);
  //       }
  //       if (widget.listScrollController != null) {
  //         final newPosition = maxSliderValue * stepWidth;
  //         widget.listScrollController!.jumpTo(newPosition);
  //       }
  //     } else {
  //       setState(() {
  //         _sliderValue = newSliderValue;
  //       });
  //       if (widget.onChanged != null) {
  //         widget.onChanged!(newSliderValue);
  //       }
  //       if (widget.listScrollController != null) {
  //         final newPosition = newSliderValue * stepWidth;
  //         widget.listScrollController!.jumpTo(newPosition);
  //       }
  //     }
  //   }
  //   _isRulerScrolling = false;
  // }
  void _rulerScrollListener() {
    if (!_isRulerScrolling) {
      _isRulerScrolling = true;
      final newPosition = widget.scrollController!.offset;
      final stepWidth = 10.0;
      final newSliderValue = (newPosition / stepWidth)
          .clamp(widget.minValue, widget.maxValue);

      setState(() {
        _sliderValue = newSliderValue;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(newSliderValue);
      }
      if (widget.listScrollController != null) {
        widget.listScrollController!
            .jumpTo(newSliderValue * stepWidth);
      }
    }
    _isRulerScrolling = false;
  }

  void _listScrollListener() {
    if (!_isRulerScrolling) {
      _isRulerScrolling = true;
      final newPosition = widget.listScrollController!.offset;
      final stepWidth = 10.0;
      final newSliderValue = (newPosition / stepWidth)
          .clamp(widget.minValue, widget.maxValue);

      setState(() {
        _sliderValue = newSliderValue;
      });
      if (widget.scrollController != null) {
        widget.scrollController!
            .jumpTo(newSliderValue * stepWidth);
      }
    }
    _isRulerScrolling = false;
  }

  // void _listScrollListener() {
  //   if (!_isRulerScrolling) {
  //     _isRulerScrolling = true;
  //     final newPosition = widget.listScrollController!.offset;
  //     final divisions = widget.totalSeconds;
  //     final stepWidth = 10.0; // 10 pixels for each second
  //     final newSliderValue = newPosition / stepWidth;
  //
  //     // Ensure the slider value stays within the minimum and maximum values
  //     final minSliderValue = widget.minValue;
  //     final maxSliderValue = widget.maxValue;
  //     final clampedValue = newSliderValue.clamp(minSliderValue, maxSliderValue);
  //
  //     setState(() {
  //       _sliderValue = clampedValue;
  //     });
  //
  //     if (widget.scrollController != null) {
  //       // Adjust the position of the other scroll controller
  //       final newPosition = clampedValue * stepWidth;
  //       widget.scrollController!.jumpTo(newPosition);
  //     }
  //   }
  //   _isRulerScrolling = false;
  // }

  @override
  Widget build(BuildContext context) {
    final allocatedHeight = MediaQuery.of(context).size.height;
    final allocatedWidth = MediaQuery.of(context).size.width;
    final divisions = widget.totalSeconds;
    final double valueHeight =
    allocatedHeight * 0.05 < 41 ? 23 : allocatedHeight * 0.05;
    final double tickHeight =
    allocatedHeight * 0.025 < 20 ? 20 : allocatedHeight * 0.020;
    final labelOffset = 10.0 / 2; // Half of the 10 pixels step width

    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: allocatedHeight * 0.011 < 9
                ? 9
                : allocatedHeight * 0.011,
            activeTickMarkColor: widget.activeColor ?? Colors.purple,
            inactiveTickMarkColor:
            widget.inactiveColor ?? Colors.purple.shade50,
            activeTrackColor: widget.activeColor ?? Colors.purple,
            inactiveTrackColor:
            widget.inactiveColor ?? Colors.purple.shade50,
            thumbColor: Colors.transparent,
            overlayColor: widget.activeColor == null
                ? Colors.purple.withOpacity(0.1)
                : widget.activeColor!.withOpacity(0.1),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
            trackShape: CustomTrackShape(),
            showValueIndicator: ShowValueIndicator.never,
            valueIndicatorTextStyle: TextStyle(
              fontSize: 12,
            ),
          ),
          child: Slider(
            value: _sliderValue,
            min: widget.minValue,
            max: widget.maxValue,
            divisions: divisions - 1,
            onChanged: (val) {
              setState(() {
                _sliderValue = val.clamp(widget.minValue, widget.maxValue);
              });
              if (widget.onChanged != null) {
                widget.onChanged!(val.clamp(widget.minValue, widget.maxValue));
              }
              if (widget.listScrollController != null) {
                final newPosition = val * 10.0;
                widget.listScrollController!.jumpTo(newPosition);
              }
            },

            // onChanged: (val) {
            //   // Update the value and notify the parent widget
            //   setState(() {
            //     _sliderValue = val;
            //   });
            //   if (widget.onChanged != null) {
            //     widget.onChanged!(val);
            //   }
            //   if (widget.listScrollController != null) {
            //     final newPosition =
            //         val * 10.0; // 10 pixels for each second
            //     widget.listScrollController!.jumpTo(newPosition);
            //   }
            // },
            label: _sliderValue.toStringAsFixed(widget.labelValuePrecision),
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(0.3),
          height: 45,
          child: SingleChildScrollView(
            controller: widget.scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                widget.totalSeconds,
                    (index) => Container(
                  alignment: Alignment.bottomCenter,
                  width: 20.0, // 10 pixels for each second
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : widget.minPaddingValue,
                    right: index == widget.totalSeconds - 1 ? 0 : widget.maxPaddingValue - 30,
                  ),
                  child: Column(
                    children: [
                      Transform.scale(
                        scale: .7,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: tickHeight,
                          child: VerticalDivider(
                            indent: index % (widget.minorTick + 1) == 0 ? 1 : 6,
                            thickness: 1.2,
                            color: (index.toDouble() + 1.0) ==
                                _sliderValue.roundToDouble()
                                ? widget.activeColor ?? Colors.purple
                                : Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: valueHeight-28,
                        child: index % (widget.minorTick + 1) == 0
                            ? Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight);
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
