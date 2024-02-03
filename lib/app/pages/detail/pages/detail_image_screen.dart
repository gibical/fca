import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:sizer/sizer.dart';

import '../logic.dart';

class DetailImageScreen extends StatelessWidget {
  const DetailImageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColor.primaryDarkColor,
      bottomNavigationBar: BuyCardWidget(price: 20),
      body: GetBuilder<DetailController>(
        builder: (controller){
          var selectedItem = controller.selectedItem.value;
          return CustomScrollView(
            slivers: [
              CustomAppBarVideoAndImageDetailWidget(selectedItem: selectedItem, isVideo: false,),
              SliverToBoxAdapter(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 6.5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text('${selectedItem['name']}', style: FontStyleApp.titleMedium.copyWith(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w600
                      ),),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('${selectedItem['description']}' , style: FontStyleApp.bodyMedium.copyWith(
                        color: AppColor.grayLightColor.withOpacity(0.8),
                      ),),

                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius:3.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text('Ralph Edwards' , style: FontStyleApp.bodySmall.copyWith(
                              color: AppColor.grayLightColor.withOpacity(0.8),
                              fontSize: 13
                          ),),
                          Spacer(),
                          Text('8:15' , style: FontStyleApp.bodySmall.copyWith(
                              color: AppColor.grayLightColor.withOpacity(0.8),
                              fontSize: 13
                          ),),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Wrap(
                        children: [


                          CardMarkSinglePageWidget(label: 'Suffix' , type: '${selectedItem['suffix']}'),
                          CardMarkSinglePageWidget(label: 'Type' , type: '${selectedItem['type']}'),
                          CardMarkSinglePageWidget(label: 'Lanuage' , type: '${selectedItem['language']}'),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        height: 17.5.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border(
                                top: BorderSide(color: Colors.white.withOpacity(0.3) , width: 0.6),
                                left: BorderSide(color: Colors.white.withOpacity(0.3) , width: 0.8),

                                right: BorderSide(color: Colors.white.withOpacity(0.3) , width: 0.1)
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:6.w , vertical: 2.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Comments' , style: FontStyleApp.bodyLarge.copyWith(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Spacer(),
                                  Text('56' , style: FontStyleApp.bodyMedium.copyWith(
                                    color: AppColor.whiteColor.withOpacity(0.5),

                                  ),),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(

                                children: [
                                  CircleAvatar(
                                    radius: 19,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 5.h,
                                      child: TextField(

                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.black54,
                                            hintText: 'Add a comment...',
                                            contentPadding: EdgeInsets.symmetric(vertical: 8 ,horizontal: 10),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }


}
