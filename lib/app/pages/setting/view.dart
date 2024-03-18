

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/font_style.dart';
import '../home/logic.dart';
import 'account_page.dart';

class SettingScreen extends StatelessWidget {

  ProfileControllers logic = Get.find<HomeLogic>().profileController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
         automaticallyImplyLeading: false,
         toolbarHeight: 15.h,
        flexibleSpace:   Stack(
          alignment: Alignment.topCenter,
          children: [

            Container(
              height: 10.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [

                    Colors.white,
                    AppColor.primaryLightColor,
                    AppColor.primaryLightColor,
                  ])
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: 7.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration:BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.blueDarkColor,
                    ) ,
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: CircleAvatar(
                        backgroundColor:AppColor.blueDarkColor,
                        backgroundImage: AssetImage('assets/images/profile.png'),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Positioned(
              left: 5,
              top: 10.5.h,
              child: IconButton(onPressed: (){
                Get.back();
              },
                icon: SvgPicture.asset(AppIcon.backIcon)),
            ),
          ],
        ),



      ),
      body:   Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 1.h),
            Text('${logic.model.firstName??""} ${logic.model.lastName??""}' , style: FontStyleApp.titleSmall.copyWith(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 0.5.h),
            Text('${logic.model.email??""} ', style: FontStyleApp.bodyMedium.copyWith(
              color: AppColor.whiteColor.withOpacity(0.2),
            ),),
            SizedBox(height: 3.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 7.5.w),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    ItemSettingScreenWidget(
                      onTap: (){
                       Get.to(AccountPage());
                      },
                        icon: AppIcon.account1Icon,
                        title: 'Account',
                        subTitle: '${logic.model.username??""} ',
                        iconSize: 21,
                    ),
                    ItemSettingScreenWidget(icon: AppIcon.emailIcon,
                      title: 'Massage',
                      onTap: (){
                        Get.toNamed(PageRoutes.MASSAGE);
                      },
                      subTitle: '۰' ,
                      iconSize: 18,
                      boxMassage: true,
                    ),
                    ItemSettingScreenWidget(
                      onTap: (){
                        print('Wallet');
                      },
                      icon: AppIcon.wallet1Icon, title: 'Wallet', subTitle: '${logic.walletModel.balance}' ?? '' , iconSize: 18,),


                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xff4E4E61).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.sp),
                  border: Border(
                    top: BorderSide(color: Colors.grey.withOpacity(0.4) , width: 0.9),
                    left: BorderSide(color: Colors.grey.withOpacity(0.4) , width: 0.5),
                  )
                ),
              ),

            ),
            SizedBox(height: 4.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 7.5.w),
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ItemSettingScreenWidget(
                        onTap: (){
                          print('Analytics');
                        },
                        icon: AppIcon.AnalyticsIcon, title: 'Analytics', subTitle: '' , iconSize: 19,
                      enable: false,),
                      ItemSettingScreenWidget(
                        onTap: (){
                          print('Share');
                        },
                        icon: AppIcon.shareIcon,
                        title: 'Share account',
                        subTitle: '',
                        iconSize: 19,enable: false,
                      ),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff4E4E61).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16.sp),
                    border: Border(
                      top: BorderSide(color: Colors.grey.withOpacity(0.4) , width: 0.9),
                      left: BorderSide(color: Colors.grey.withOpacity(0.4) , width: 0.5),
                    )
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}

class ItemSettingScreenWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final double iconSize;
  final bool enable;
  final bool? boxMassage;
  final Function() onTap;
  const ItemSettingScreenWidget({
    super.key, required this.icon, required this.title, required this.subTitle, required this.iconSize,
    this.boxMassage, required this.onTap, this.enable=true,
  });

  @override
  Widget build(BuildContext context) {
    return this.enable? GestureDetector(

      onTap: onTap,
      child: SizedBox(
        height: 8.h,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(icon , height: iconSize,),
              SizedBox(width: 4.w),
              Text(title , style: FontStyleApp.titleSmall.copyWith(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2 , horizontal: 8),
                decoration: BoxDecoration(
                  color:boxMassage == true ?  Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text(subTitle , style: FontStyleApp.bodyMedium.copyWith(
                  color: boxMassage == true ? Colors.black:AppColor.grayLightColor.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),),
              ),
            ],
          ),
        ),
      ),
    ):InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: 8.h,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(icon , height: iconSize,),
              SizedBox(width: 4.w),
              Text(title , style: FontStyleApp.titleSmall.copyWith(
                color: AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2 , horizontal: 8),
                decoration: BoxDecoration(
                  color:boxMassage == true ?  Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text(subTitle , style: FontStyleApp.bodyMedium.copyWith(
                  color: boxMassage == true ? Colors.black:AppColor.grayLightColor.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
