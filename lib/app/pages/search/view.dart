import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:mediaverse/app/pages/search/widgets/custom_tab_bar_search.dart';
import 'package:mediaverse/app/widgets/custom_app_bar_widget.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';


class SearchScreen extends StatefulWidget{
   SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isAdvancedSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  fillColor: AppColor.grayLightColor,
                  filled: true,
                  hintText: 'Search in all media',
                  hintStyle: TextStyle(
                    color: AppColor.primaryDarkColor.withOpacity(0.2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.sp),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.2.w,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColor.grayLightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SvgPicture.asset(AppIcon.closeIcon),
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomTabBarSearchWidget(),
    );


    //   Scaffold(
    //   backgroundColor: AppColor.grayLightColor,
    //   body: CustomScrollView(
    //     slivers: [
    //
    //       SliverAppBar(
    //
    //         automaticallyImplyLeading: false,
    //         backgroundColor: Colors.white,
    //         pinned: false,
    //         toolbarHeight: 13.h,
    //         title: Column(
    //           children: [
    //
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: TextField(
    //                     decoration: InputDecoration(
    //                       contentPadding: EdgeInsets.symmetric(
    //                         horizontal: 10,
    //                         vertical: 13,
    //                       ),
    //                       fillColor: AppColor.grayLightColor,
    //                       filled: true,
    //                       hintText: 'Search in all media',
    //                       hintStyle: TextStyle(
    //                         color: AppColor.primaryDarkColor.withOpacity(0.2),
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(7.sp),
    //                         borderSide: BorderSide.none,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   width: 7,
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     Get.back();
    //                   },
    //                   child: Container(
    //                     height: 50,
    //                     width: 50,
    //                     decoration: BoxDecoration(
    //                       color: AppColor.grayLightColor,
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Center(
    //                       child: SvgPicture.asset(AppIcon.closeIcon),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 2.5.h,
    //             ),
    //             Container(
    //               height: 0.5,
    //               width: double.infinity,
    //               color: AppColor.primaryDarkColor.withOpacity(0.2),
    //             ),
    //
    //           ],
    //         ),
    //
    //       ),
    //
    //       SliverToBoxAdapter(
    //         child: Column(
    //           children: [
    //
    //             Container(
    //                color: AppColor.whiteColor,
    //               height: 5.h,
    //               child: Padding(
    //                 padding: const EdgeInsets.only(left: 25 , right: 15),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text('Search in all media' , style: TextStyle(
    //                         color: Colors.black
    //                     ),),
    //                     IconButton(
    //                       icon: Icon(Icons.arrow_drop_down),
    //                       onPressed: () {
    //                         setState(() {
    //                           isAdvancedSearchVisible =
    //                           !isAdvancedSearchVisible;
    //                         });
    //                       },
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //
    //
    //
    //             Container(
    //               height: 1.h,
    //               color: Colors.white,
    //             ),
    //             if (isAdvancedSearchVisible)
    //               Container(
    //                   color: Colors.white,
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(left: 20 , right: 20),
    //                     child: Column(
    //                       children: [
    //                         TextField(
    //                           decoration: InputDecoration(
    //                             contentPadding: EdgeInsets.symmetric(
    //                               horizontal: 10,
    //                               vertical: 13,
    //                             ),
    //                             fillColor: AppColor.grayLightColor,
    //                             filled: true,
    //                             hintText: 'Search in all media',
    //                             hintStyle: TextStyle(
    //                               color: AppColor.primaryDarkColor.withOpacity(0.2),
    //                             ),
    //                             border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(7.sp),
    //                               borderSide: BorderSide.none,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height: 1.h),
    //                         TextField(
    //                           decoration: InputDecoration(
    //                             contentPadding: EdgeInsets.symmetric(
    //                               horizontal: 10,
    //                               vertical: 13,
    //                             ),
    //                             fillColor: AppColor.grayLightColor,
    //                             filled: true,
    //                             hintText: 'Search in all media',
    //                             hintStyle: TextStyle(
    //                               color: AppColor.primaryDarkColor.withOpacity(0.2),
    //                             ),
    //                             border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(7.sp),
    //                               borderSide: BorderSide.none,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 1.h,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //
    //           //  CustomTabBarWidget(),
    //
    //
    //           ],
    //         ),
    //       ),
    //
    //     ],
    //   ),
    //
    // );
  }
}
