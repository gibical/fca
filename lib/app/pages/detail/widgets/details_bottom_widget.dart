import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:mediaverse/app/pages/detail/widgets/youtube_bottomsheet.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../../../common/app_color.dart';
import '../../../common/app_config.dart';

class DetailsBottomWidget extends StatefulWidget {
  DetailController detailController;
  PostType postType;

  DetailsBottomWidget(this.detailController,this.postType);

  @override
  State<DetailsBottomWidget> createState() => _DetailsBottomWidgetState();
}

class _DetailsBottomWidgetState extends State<DetailsBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 22.h,
      decoration: BoxDecoration(
          color: "191b47".toColor(),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.sp),
            topLeft: Radius.circular(15.sp),
          ),
          border: Border(
              top: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 0.6),
              left: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 0.8),

              right: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 0.1)
          )
      ),

      padding: EdgeInsets.all(16),
      child: Column(

        children: [
          Container(
            width: 100.w,
            height: 7.h,
            decoration: BoxDecoration(
                color: Color(0xff4E4E61).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.sp),
                border: Border(
                    top: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 0.6),
                    left: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 0.8),

                    right: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 0.1)
                )
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),

              ),
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              onPressed: (){

                Get.bottomSheet(YoutubeShareBottomSheet(widget.detailController,false),backgroundColor: AppColor.primaryDarkColor);

              },

              child: Row(
                children: [
                  Expanded(child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            '${Constant.getDropDownByPlan(widget.detailController.detailss!['license_type'].toString())}'),
                      ),

                    ],
                  )),
                  if(!widget.detailController.detailss!['license_type'].toString().contains("1"))  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(!widget.detailController.detailss!['license_type'].toString().contains("1"))    Text("${(widget.detailController.detailss!['price']/100).toString()} €"),
                      if(!widget.detailController.detailss!['license_type'].toString().contains("1"))  SizedBox(width: 3.w,),
                    ],
                  ),
                  Icon(Icons.share,color: Colors.white.withOpacity(0.7),)
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          Container(
              width: 100.w,
              height: 6.h,
              decoration: BoxDecoration(
                  color: Color(0xff4E4E61).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100.sp),
                  border: Border(
                      top: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.6),
                      left: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.8),

                      right: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.1)
                  )
              ),

              child: MaterialButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000)
                ),
                onPressed: () {
                  widget.detailController.sendToEditProfile(widget.postType);
                },
                child: Center(
                  child: Text("Edit information",
                    style: TextStyle(color: "83839C".toColor()),),
                ),
              )
          ),

        ],
      ),
    );
  }
}
