//
// import 'package:flutter/material.dart';
// class SyncListView extends StatelessWidget {
//   final ScrollController scrollController;
//   final int itemCount;
//   final Color color1;
//
//   final double itemWidth;
//   final double maxValue;
//   final double minValue;
//
//   const SyncListView({
//     required this.scrollController,
//     required this.itemCount,
//     required this.color1,
//
//     required this.itemWidth,
//     required this.maxValue,
//     required this.minValue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     int totalItemCount = ((maxValue - minValue) / (itemWidth / 10)).round();
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       controller: scrollController,
//       itemCount: totalItemCount,
//       itemBuilder: (context, index) {
//         if (index < itemCount) {
//           return Container(
//             color: color1 ,
//             height: 50,
//             width: itemWidth,
//           );
//         } else {
//           return Container(
//             color: Colors.transparent,
//             height: 50,
//             width: itemWidth * itemWidth,
//           );
//         }
//       },
//     );
//   }
// }


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../logic.dart';

class SyncListView extends StatefulWidget {
  final ScrollController scrollController;
  final int itemCount;
  final Widget child;
  final MediaSuitController suitController;
  final double itemWidth;
  final double maxValue;
  final double minValue;

  const SyncListView({
    required this.scrollController,
    required this.itemCount,


    required this.itemWidth,
    required this.maxValue,
    required this.minValue, required this.suitController, required this.child,
  });

  @override
  State<SyncListView> createState() => _SyncListViewState();
}

class _SyncListViewState extends State<SyncListView> {
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
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery
        .of(context)
        .size
        .height;

    int totalItemCount = ((widget.maxValue - widget.minValue) / (widget.itemWidth / 10)).round();
    return SizedBox(
      height: h * 0.050,
      child: ReorderableListView.builder(
        scrollController: widget.scrollController,

        itemCount:
        widget.suitController.editVideoDataList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        if (index < widget.itemCount) {
          return widget;
        } else {
          return Container(
            color: Colors.white.withOpacity(0.3),
            height: 50,
            width: widget.itemWidth * widget.itemWidth,
          );
        }
        },
        proxyDecorator: (child, index, animation) =>
            _proxyDecorator(child, index, animation,
                Colors.purple, Colors.purple.shade300),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = widget.suitController
                .editVideoDataList
                .removeAt(oldIndex);
            widget.suitController.editVideoDataList
                .insert(newIndex, item);
          });
        },
      ),
    );
  }
}

