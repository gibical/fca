import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

Widget CustomGridImageWidget(){
  return SliverGrid.builder(
      gridDelegate:  SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),

      itemCount: 10,
      itemBuilder: (context  , index){
        return Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.sp),
                    ));
      }
  );



    // GridView.custom(
    //   gridDelegate: SliverQuiltedGridDelegate(
    //     crossAxisCount: 4,
    //     mainAxisSpacing: 5,
    //     crossAxisSpacing: 5,
    //     repeatPattern: QuiltedGridRepeatPattern.inverted,
    //     pattern: [
    //       QuiltedGridTile(2, 2),
    //       QuiltedGridTile(1, 1),
    //       QuiltedGridTile(1, 1),
    //       QuiltedGridTile(1, 2),
    //     ],
    //   ),
    //   childrenDelegate: SliverChildBuilderDelegate(
    //       childCount: 5,
    //           (context, index) => Container(
    //         height: 80,
    //         decoration: BoxDecoration(
    //           color: Colors.orange,
    //           borderRadius: BorderRadius.circular(10.sp),
    //         ),
    //       )
    //   ),
    // ),

}

