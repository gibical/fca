import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/widgets/custom_app_bar_widget.dart';
import 'package:sizer/sizer.dart';


class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBarWidget(),
      backgroundColor: theme.primaryColor,
      bottomNavigationBar: BuyCardWidget(),
    );
  }
}

Widget BuyCardWidget(){
  return Container(
    height: 13.h,
    color: AppColor.whiteColor,
    child: Padding(
      padding: const EdgeInsets.only(left: 18.0 , right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Monthly: 20" , style: TextStyle(
                color: AppColor.primaryDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              Row(

                children: [
                  SvgPicture.asset(AppIcon.detail4Icon),
                  SizedBox(
                    width: 4.5.w,
                  ),
                  SvgPicture.asset(AppIcon.detail3Icon),
                  SizedBox(
                    width: 4.5.w,
                  ),
                 SvgPicture.asset(AppIcon.detail1Icon),
                  SizedBox(
                    width: 4.5.w,
                  ),
                 SvgPicture.asset(AppIcon.detail2Icon),


                ],
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
            width: 38.w,
            child: ElevatedButton(
                onPressed: (){
                  if (AppTheme().getCurrentTheme() == ThemeMode.light) {
                    AppTheme.changeTheme(ThemeMode.dark);
                  } else {
                    AppTheme.changeTheme(ThemeMode.light);
                  }
                },
                child: Text('buy' , style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),),
             style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.3.sp)),
               backgroundColor: AppColor.primaryLightColor
             ),
            ),
          )
        ],
      ),
    ),
  );
}
