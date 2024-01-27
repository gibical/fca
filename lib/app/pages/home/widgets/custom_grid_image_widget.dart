import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

Widget CustomGridImageWidget(List<dynamic> mostviews){
  var sizeWith = (33.w-20);
  return Container(
    width: 100.w,
    child:
    Row(
      children: [
        Column(
          children: [
            Container(
              width: sizeWith,
              height: sizeWith,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (mostviews[0]['asset']['thumbnails'].toString().length>3)?Image.network("${mostviews[0]['asset']['thumbnails']['336x366']}", fit: BoxFit.cover)
                    :Image.asset("assets/images/tum_video.jpeg", fit: BoxFit.cover),
              ),

              margin: EdgeInsets.only(bottom: 10),
            ),
            Container(
              width: sizeWith,
              height: sizeWith,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (mostviews[1]['asset']['thumbnails'].toString().length>3)?Image.network("${mostviews[1]['asset']['thumbnails']['336x366']}", fit: BoxFit.cover)
                    :Image.asset("assets/images/tum_video.jpeg", fit: BoxFit.cover),
              ),

              margin: EdgeInsets.only(bottom: 10),
            ),
            Container(
              width: sizeWith,
              height: sizeWith,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (mostviews[2]['asset']['thumbnails'].toString().length>3)?Image.network("${mostviews[2]['asset']['thumbnails']['336x366']}", fit: BoxFit.cover)
                    :Image.asset("assets/images/tum_video.jpeg", fit: BoxFit.cover),
              ),

            ),
          ],
        ),
        Expanded(child: Column(

          children: [
            Container(




              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (mostviews[3]['asset']['thumbnails'].toString().length>3)?Image.network("${mostviews[3]['asset']['thumbnails']['336x366']}", fit: BoxFit.cover)
                    :Image.asset("assets/images/tum_video.jpeg", fit: BoxFit.cover),
              ),

              margin: EdgeInsets.only(bottom: 10),
              height: sizeWith*2+10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: sizeWith,
                  height: sizeWith,

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (mostviews[4]['asset']['thumbnails'].toString().length>3)?Image.network("${mostviews[4]['asset']['thumbnails']['336x366']}", fit: BoxFit.cover)
                        :Image.asset("assets/images/tum_video.jpeg", fit: BoxFit.cover),
                  ),

                  //margin: EdgeInsets.,
                ),
                Container(
                  width: sizeWith,
                  height: sizeWith,

                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (mostviews[5]['asset']['thumbnails'].toString().length>3)?Image.network("${mostviews[5]['asset']['thumbnails']['336x366']}", fit: BoxFit.cover)
                        :Image.asset("assets/images/tum_video.jpeg", fit: BoxFit.cover),
                  ),

                  margin: EdgeInsets.all(1.w),
                ),
              ],
            ),
          ],
        ))
      ],
    )
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

