import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/report_botton_sheet.dart';

class DetailImageScreen extends StatelessWidget {
  const DetailImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Get.put(DetailController(),tag: "${DateTime.now().microsecondsSinceEpoch}");

    return Scaffold(

      backgroundColor: AppColor.primaryDarkColor,
      bottomNavigationBar: Obx(() {
          if (imageController.isLoadingMusic.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (imageController.imageDetails != null &&
                imageController.imageDetails!.containsKey('asset') &&
                imageController.imageDetails!['asset'] != null &&
                imageController.imageDetails!['asset'].containsKey('plan')) {
              int plan = imageController.imageDetails!['asset']['plan'];
              print(plan);
              if (plan == 1) {
                return SizedBox();
              } else if (plan == 2 || plan == 3) {
                return BuyCardWidget(
                    selectedItem: imageController.imageDetails,
                    title: imageController.imageDetails!['asset']['plan'] == 2
                        ? 'Ownership'
                        : imageController.imageDetails!['asset']['plan'] == 3
                        ? 'Subscribe'
                        : '',
                    price: imageController.imageDetails!['asset']['price']
                );

              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }
        }),
      body:Obx((){
        return imageController.isLoadingImages.value ? Center(child: CircularProgressIndicator(),): CustomScrollView(
          slivers: [
           CustomAppBarVideoAndImageDetailWidget(selectedItem: imageController.imageDetails, isVideo: false,),
            SliverToBoxAdapter(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text('${imageController.imageDetails?['name']}', style: FontStyleApp.titleMedium.copyWith(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600
                    ),),
                    SizedBox(
                      height: 1.h,
                    ),
                    // Text('${selectedItem['description']}' , style: FontStyleApp.bodyMedium.copyWith(
                    //   color: AppColor.grayLightColor.withOpacity(0.8),
                    // ),),

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
                        GestureDetector(
                          onTap: (){
                            Get.bottomSheet(ReportBottomSheet(imageController));
                          },
                          child: Text('Report' , style: FontStyleApp.bodySmall.copyWith(
                              color: AppColor.grayLightColor.withOpacity(0.8),
                              fontSize: 13
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    // Wrap(
                    //   children: [
                    //
                    //
                    //     CardMarkSinglePageWidget(label: 'Suffix' , type: '${selectedItem['suffix']}'),
                  if(imageController.imageDetails?['asset']!=null)  CardMarkSinglePageWidget(label: 'Type' , type: imageController.getTypeString(imageController.imageDetails?['asset']['type'])),
                    //     CardMarkSinglePageWidget(label: 'Lanuage' , type: '${selectedItem['language']}'),
                    //   ],
                    // ),
                    SizedBox(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        int itemId = imageController.imageDetails?['asset_id'];
                        print(itemId);
                        Get.toNamed(PageRoutes.COMMENT, arguments: {'id': itemId});
                      },
                      child: CustomCommentSinglePageWidget(),
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
      })


    );
  }


}
