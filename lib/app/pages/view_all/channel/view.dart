import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/plus_section/widget/custom_plan_text_filed.dart';
import 'package:mediaverse/app/pages/view_all/channel/widgets/custom_select_bottom_sheet.dart';
import 'package:mediaverse/app/pages/view_all/channel/widgets/selectItemFiltrWidgt.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import 'logic.dart';

class ViewAllChannelScreen extends GetView<ViewAllChannelController> {
   ViewAllChannelScreen({Key? key}) : super(key: key);
TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: GetBuilder<ViewAllChannelController>(
          init: ViewAllChannelController(1),

          builder: (controller){
        if (controller.isLoadingChannel == false) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  height: controller.busy ? 28.h : 14.h,
                  duration: const Duration(milliseconds: 400),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  color: AppColor.grayLightColor.withOpacity(0.2),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: SvgPicture.asset(AppIcon.backIcon),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: SizedBox(
                                height: 6.h,
                                child: TextField(
                                  onChanged: (value) {
                                    controller.filterChannels(value);
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                    ),
                                    fillColor: AppColor.blueDarkColor.withOpacity(0.2),
                                    filled: true,
                                    suffixIcon: Transform.scale(
                                      scale: .4,
                                      child: SvgPicture.asset(
                                        AppIcon.searchIcon,
                                        color: Colors.white,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.sp),
                                      borderSide: BorderSide(
                                        color: AppColor.whiteColor.withOpacity(0.1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.sp),
                                      borderSide: BorderSide(
                                        color: AppColor.whiteColor.withOpacity(0.1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.sp),
                                      borderSide: BorderSide(
                                        color: AppColor.whiteColor.withOpacity(0.1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              height: 6.h,
                              width: 12.w,
                              child: GestureDetector(
                                onTap: () {
                                  controller.showFilterAppBar();
                                },
                                child:controller.busy ?        Transform.scale(
                                    scale: .4,
                                    child: SvgPicture.asset(AppIcon.downIcon , color: AppColor.whiteColor,)): Icon(Icons.filter_alt_off_outlined, size: 15.sp),
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.blueDarkColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(
                                  color: AppColor.whiteColor.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ],
                        ),
                    
                        if (controller.busy)
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 1.w),
                            child: Column(

                              children: [
                                SizedBox(height: 2.h),
                                selectFilterItem(
                                  onTap: (){
                                    final languageMap = {
                                      'fr': 'French',
                                      'en': 'English',
                                      'ar': 'Arabic',
                                      'tr': 'Turkish',
                                    };

                                    runCustomSelectBottomSheet(languageMap, textEditingController, 'Selected language', (selectedLanguage) {
                                      controller.filterChannels(selectedLanguage);
                                    });

                                  },
                                  title: 'viewall_1'.tr
                                ),
                                SizedBox(height: 2.h),
                                selectFilterItem(
                                    onTap: (){
                                      final countryMap = {
                                        'fr': 'France',
                                        'en': 'England',
                                        'ar': 'Arabia',
                                        'tr': 'Turkey',
                                      };

                                      runCustomSelectBottomSheet(countryMap, textEditingController, 'Selected Country', (selectedCountry) {
                                        controller.filterChannels(selectedCountry);
                                      });
                                    },
                                    title: 'viewall_2'.tr
                                ),

                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcon.liveIcon),
                      SizedBox(width: 2.w),
                      Text(
                        'viewall_3'.tr,
                        style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                sliver: SliverList.builder(
                  itemCount: controller.filteredChannels.length > 0
                      ? controller.filteredChannels.length
                      : controller.channels.length,
                  itemBuilder: (context, index) {
                    final channelModel = controller.filteredChannels.isNotEmpty
                        ? controller.filteredChannels[index]
                        : controller.channels[index];
                    return GestureDetector(
                      onTap: (){
                        final channelId = controller.filteredChannels[index]['id'];
                        Get.toNamed(PageRoutes.LIVE , arguments: {'channelId': channelId},preventDuplicates: false);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 1.h,
                          horizontal: 4.w,
                        ),
                        height: 11.h,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: SizedBox(
                                height: 8.h,
                                width: 16.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(13.sp),
                                  child: Image.network(
                                    channelModel['thumbnail'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    channelModel['title'] ?? '...',
                                    style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(fontSize: 13.sp),
                                  ),
                                  Spacer(),
                                  Text(
                                    channelModel['country'] ?? '...',
                                    style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.whiteColor.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(12.sp),
                          color: AppColor.whiteColor.withOpacity(0.1),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }

      })



    );
  }




}

