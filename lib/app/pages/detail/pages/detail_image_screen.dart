import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/back_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import '../../media_suit/logic.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/details_bottom_widget.dart';
import '../widgets/report_botton_sheet.dart';
import '../widgets/youtube_bottomsheet.dart';

class DetailImageScreen extends StatelessWidget {
   DetailImageScreen({super.key});
   var imageController = Get.put(DetailController(2),tag: "${DateTime.now().microsecondsSinceEpoch}");

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: ()async{
          if(Get.arguments['idAssetMedia'] == "idAssetMedia"){
            Get.offAllNamed(PageRoutes.WRAPPER);
          }else{
            Get.back();
          }


          return false;
        },
      child: Scaffold(

        backgroundColor: AppColor.primaryDarkColor,
        bottomNavigationBar: Obx(() {
            if (imageController.isLoadingImages.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (imageController.imageDetails != null &&
                  imageController.imageDetails!.containsKey('asset') &&
                  imageController.imageDetails!['asset'] != null &&
                  imageController.imageDetails!['asset'].containsKey('license_type')) {
                int plan = imageController.imageDetails!['asset']['license_type'];
                print(plan);
                if (plan == 1) {
                  return SizedBox();
                } else if (plan == 2 || plan == 3) {
                  return BuyCardWidget(
                      selectedItem: imageController.imageDetails,
                      title: imageController.imageDetails!['asset']['license_type'] == 2
                          ? 'Ownership'
                          : imageController.imageDetails!['asset']['license_type'] == 3
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
                   Text('${imageController.imageDetails?['media']['name']}', style: FontStyleApp.titleMedium.copyWith(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w600
                            ),),

                          SizedBox(
                            height: 1.h,
                          ),
                          Text('${imageController.imageDetails?['media']['description']}' , style: FontStyleApp.bodyMedium.copyWith(
                            color: AppColor.grayLightColor.withOpacity(0.8),
                          ),),

                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Container(

                                child:imageController.imageDetails?['user']['image_url'] == null ?CircleAvatar(
                          backgroundColor:
                          AppColor.primaryLightColor,
                          ): CircleAvatar(
                                  backgroundColor: AppColor.blueDarkColor,
                                  backgroundImage:
                                  NetworkImage(imageController.imageDetails?['user']['image_url']),
                                ),
                                width: 5.w,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                             if(imageController.imageDetails?['user']!=null) Text('${imageController.imageDetails?['user']['username']}' , style: FontStyleApp.bodySmall.copyWith(
                                  color: AppColor.grayLightColor.withOpacity(0.8),
                                  fontSize: 13
                              ),),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  Get.bottomSheet(ReportBottomSheet(imageController));
                                },
                                child: Text('details_6'.tr , style: FontStyleApp.bodySmall.copyWith(
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
                              Get.find<MediaSuitController>().setDataEditImage(imageController.imageDetails?['media']['name'] ?? '' , imageController.imageDetails?['file']['url'] , imageController.imageDetails!['file_id'].toString());
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
                          // CardMarkSinglePageWidget(label: 'details_7'.tr, type: "Somethi"),
                        //   CardMarkSinglePageWidget(label: 'Type', type: imageController.imageDetails!['file']['extension']),
                       //    CardMarkSinglePageWidget(label: 'Language', type: "en"),

                            ],
                          ),
                          // Wrap(
                          //   children: [
                          //
                          //
                          //     CardMarkSinglePageWidget(label: 'Suffix' , type: '${selectedItem['suffix']}'),
                        if(imageController.imageDetails?['asset']!=null)  CardMarkSinglePageWidget(label: 'details_8'.tr , type: imageController.getTypeString(imageController.imageDetails?['media_type'])),
                          //     CardMarkSinglePageWidget(label: 'Lanuage' , type: '${selectedItem['language']}'),
                          //   ],
                          // ),
                          SizedBox(
                            height: 4.h,
                          ),
                          GestureDetector(
                            onTap: (){
                              String itemId = imageController.imageDetails?['asset_id'];
                              print(itemId);
                              Get.toNamed(PageRoutes.COMMENT, arguments: {'id': itemId,"logic":imageController});
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
                    child: DetailsBottomWidget(imageController, PostType.image),
                  ),
                );
              }),

              BackWidget(idAssetMedia: Get.arguments['idAssetMedia'] == "idAssetMedia",)

            ],
          );
        })


      ),
    );
  }


}
