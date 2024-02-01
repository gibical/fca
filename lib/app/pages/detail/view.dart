import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/widgets/custom_app_bar_widget.dart';
import 'package:sizer/sizer.dart';


class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColor.primaryDarkColor,
      bottomNavigationBar: BuyCardWidget(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 27.h,
                  width: double.infinity,
                  child: Transform.scale(
                      scale: 0.15,
                      child: SvgPicture.asset(AppIcon.playIcon)),
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp) , bottomRight: Radius.circular(25.sp)),
                    image: DecorationImage(image: AssetImage('assets/images/test.png' ), fit: BoxFit.cover ,),

                  ),
                ),
                Container(
                  height: 27.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp) , bottomRight: Radius.circular(25.sp)),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.66),
                          Colors.black.withOpacity(0.3),
                      Colors.transparent,

                    ])

                  ),
                ),
                Positioned(
                    bottom: 15,
                    left: 25,
                    child: SvgPicture.asset(AppIcon.videoIcon , color: Colors.white60,))
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 6.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text('Model clothes are expensive' , style: FontStyleApp.titleMedium.copyWith(
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600
                  ),),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text('Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat. more...' , style: FontStyleApp.bodyMedium.copyWith(
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
                      CardMarkSinglePageWidget(label: 'Genre' , type: 'Sci-fi'),
                      CardMarkSinglePageWidget(label: 'Type' , type: 'Clip'),
                      CardMarkSinglePageWidget(label: 'Lanuage' , type: 'En'),
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
      ),
    );
  }


}





Widget CardMarkSinglePageWidget({required String label , required String type }) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      height: 5.h,
      width: 40.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey.withOpacity(0.5)
          ),
          borderRadius: BorderRadius.circular(10.sp)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label , style: FontStyleApp.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.5)
            ),),
            SizedBox(
              width: 2.w,
            ),
            Container(
                height: 2.3.h,
                width: 1,
                color: Colors.white.withOpacity(0.5)
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(type , style: FontStyleApp.bodyMedium.copyWith(
                color: Colors.white
            ),),
          ],
        ),
      ),
    ),
  );
}
Widget BuyCardWidget(){
  return Container(
    height: 22.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topRight: Radius.circular(16.sp) , topLeft: Radius.circular(16.sp)),
      color: Colors.white.withOpacity(0.1),
    ),
    child:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 7.5.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.11),
                borderRadius: BorderRadius.circular(15)
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Text("Monthly: 20" , style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                    SizedBox(
                      height: 1.8.h,
                    ),
                    Spacer(),
                    SvgPicture.asset(AppIcon.detail4Icon , color: Colors.white,),
                    SizedBox(
                      width: 4.5.w,
                    ),

                    SvgPicture.asset(AppIcon.detail1Icon , color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0 , vertical: 10),
            child: SizedBox(
              height: 6.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  if (AppTheme().getCurrentTheme() == ThemeMode.light) {
                    AppTheme.changeTheme(ThemeMode.dark);
                  } else {
                    AppTheme.changeTheme(ThemeMode.light);
                  }
                },
                child: Text('Buy' , style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),),
                style: ElevatedButton.styleFrom(
                    shadowColor: AppColor.primaryLightColor.withOpacity(0.4),
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.3.sp)),
                    backgroundColor: AppColor.primaryLightColor
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
