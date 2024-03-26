import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import '../../media_suit/logic.dart';
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
        return imageController.isLoadingImages.value ? Center(child: CircularProgressIndicator(),): Stack(
          children: [
            CustomScrollView(
              slivers: [
               CustomAppBarVideoAndImageDetailWidget(selectedItem: imageController.imageDetails, isVideo: false,detailController: imageController,),
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
                            Image.asset("assets/images/avatar.jpeg",width: 4.w,),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text('${imageController.imageDetails?['user']['username']}' , style: FontStyleApp.bodySmall.copyWith(
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
                        GestureDetector(
                          onTap: (){
                            Get.find<MediaSuitController>().setDataEditImage(imageController.imageDetails?['name'] ?? '');
                            Get.toNamed(PageRoutes.MEDIASUIT);
                          },
                          child:  Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                        Wrap(
                          children: [
                            //
                         CardMarkSinglePageWidget(label: 'Suffix', type: "Somethi"),
                         CardMarkSinglePageWidget(label: 'Type', type: imageController.imageDetails!['file']['extension']),
                     //    CardMarkSinglePageWidget(label: 'Language', type: "en"),

                          ],
                        ),
                        // Wrap(
                        //   children: [
                        //
                        //
                        //     CardMarkSinglePageWidget(label: 'Suffix' , type: '${selectedItem['suffix']}'),
                      if(imageController.imageDetails?['asset']!=null)  CardMarkSinglePageWidget(label: 'Type' , type: imageController.getTypeString(imageController.imageDetails?['type'])),
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
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            Obx(() {
              return Visibility(
                visible: imageController.isEditAvaiblae.isTrue,

                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
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
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              Expanded(child: Text(
                                  '${Constant.getDropDownByPlan(imageController.imageDetails!['plan'].toString())}')),
                            if(!imageController.imageDetails!['plan'].toString().contains("1"))  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${imageController.imageDetails!['price'].toString()} €"),
                                  SizedBox(width: 3.w,),
                                  SvgPicture.asset("assets/images/download.svg"),
                                ],
                              )
                            ],
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
                                imageController.sendToEditProfile(PostType.image);
                              },
                              child: Center(
                                child: Text("Edit information",
                                  style: TextStyle(color: "83839C".toColor()),),
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ),
              );
            })

          ],
        );
      })


    );
  }


}
