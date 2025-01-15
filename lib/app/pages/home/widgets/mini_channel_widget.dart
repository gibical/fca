import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

class MiniChannelWidget extends StatelessWidget {

  bool _isPermiuim = true;
  double? height;

  MiniChannelWidget({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(


      width: 100.w,
      child: Row(

        children: [
          Container(
            width: 20.w,
            height: 15.w+1.5.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5000),
                    child: Container(
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                          color: Colors.green
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(

                    margin: EdgeInsets.only(
                        top: (15.w-(1.5.h/2))
                    ),
                    width: 7.w,
                    height: 1.5.h,
                    decoration: BoxDecoration(
                        color: "B71D18".toColor(),
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child: Center(child: Text("Live",style: TextStyle(fontSize: 6.sp,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("CNN",style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Expanded(
                  child: Text("Here, we explore a variety of topics that inspire creativity and foster community engagement. Join us for insightful discussions, tutorials, and much more!",
                    style: TextStyle(
                    fontWeight: FontWeight.w300,color: "#9C9CB8".toColor()
                  ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
