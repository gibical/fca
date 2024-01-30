import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';


class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(
       child: Column(
         children: [
           SizedBox(
             height: 7.h,
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 30.0),
             child: Container(
               height: 7.h,
               width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
                 child: Row(
                   children: [
                     Text('Inventory' , style: FontStyleApp.bodyMedium.copyWith(
                       color: Colors.grey
                     ),),

                     SizedBox(
                       width: 2.w,
                     ),

                     Container(
                       height: 3.5.h,
                       width: 1,
                       color: Colors.grey,
                     ),
                     SizedBox(
                       width: 3.w,
                     ),
                     Text('200', style: FontStyleApp.bodyLarge.copyWith(
                         color: Colors.white,
                         fontWeight: FontWeight.w700
                     ),),
                     Spacer(),
                     Text('History' , style: FontStyleApp.bodyMedium.copyWith(
                         color: AppColor.primaryLightColor,
                       fontWeight: FontWeight.w600
                     ),),
                   ],
                 ),
               ),
               decoration: BoxDecoration(
                 color: Colors.grey.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(15.sp),
                 border: Border.all(
                   color: AppColor.grayLightColor.withOpacity(0.1)
                 )
               ),
             ),
           ),
           SizedBox(
             height: 5.h,
           ),
           Stack(
         alignment: Alignment.center,
         children: [
           SizedBox(
               width: 100.w,
               height: 40.h,
               child: SvgPicture.asset(AppIcon.cardIcon)
           ),
           Container(
             height: 40.h,
             width: 56.w,

             decoration: BoxDecoration(
                 color: Color(0xff4E4E61),
                 borderRadius:  BorderRadius.circular(15.sp)
             ),
           ),






           Positioned(
             bottom: 3.5.h,
             child: SvgPicture.asset(AppIcon.chipIcon),
           ),

           Container(
             height: 40.h,
             width: 56.w,
             child: PageView.builder(
                 itemCount: 10,
                 itemBuilder: (context , index){return Column(
               children: [
                 SizedBox(
                   height: 2.h,
                 ),
                 SvgPicture.asset(AppIcon.mastercardIcon , height: 60),
                 SizedBox(
                   height: 7.h,
                 ),
                 SizedBox(
                   height: 10.h,
                   width: 56.w,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('Ma Nakhli' , style: FontStyleApp.bodyMedium.copyWith(
                             color: Color(0xffCCCCFF)
                         ),),
                         Text('08/28' , style: FontStyleApp.bodyMedium.copyWith(
                             color: Color(0xffCCCCFF)
                         ),),
                       ],),
                   ),
                 ),

                 Text('*** *** *** 2197' , style: FontStyleApp.titleSmall.copyWith(
                     color: Colors.white,
                     fontWeight: FontWeight.w700
                 ),),
               ],
             );}),
           )



         ],
       ),
           SizedBox(
             height: 3.h,
           ),
           GestureDetector(
             child: Container(
               margin: EdgeInsets.symmetric(horizontal: 23.w),
               height: 7.h,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Add card' , style: FontStyleApp.bodyLarge.copyWith(
                     color: Colors.grey
                   ),),
                   SizedBox(width: 2.w,),
                   SvgPicture.asset(AppIcon.addIcon , height: 16,      color: Colors.grey)
                 ],
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12.sp),
                 border: Border.all(
                   color: Colors.grey.withOpacity(0.5),
                 )
               ),
             ),
           ),
           SizedBox(
             height: 4.h,
           ),
           GestureDetector(
             child: Container(
               margin: EdgeInsets.symmetric(horizontal: 14.w),
               height: 7.h,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Add inventory' , style: FontStyleApp.bodyLarge.copyWith(
                     color: Colors.grey
                   ),),
                   SizedBox(width: 2.w,),
                   SvgPicture.asset(AppIcon.addIcon , height: 16,      color: Colors.grey)
                 ],
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12.sp),
                 border: Border.all(
                   color: Colors.grey.withOpacity(0.5),
                 )
               ),
             ),
           ),
         ],
       ),
     )
    );
  }
}
