

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:mediaverse/app/pages/setting/widget/delete_account_widget.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/font_style.dart';
import '../home/logic.dart';
import '../logins/view.dart';
import '../sessions/view.dart';
import 'general_information.dart';

class AccountPage extends StatelessWidget {

  ProfileControllers logic = Get.find<HomeLogic>().profileController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,

      body:   Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          
              
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 7.5.w),
          
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back,color: "666680".toColor(),)),
                    Text("setting_1".tr,style: TextStyle(color: Colors.white),),
                    Container(
                      width: 16.w,
                    )
                  ],
                ),
              ),
              SizedBox(height: 4.h),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.5.w),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ItemAccountScreenWidget(title: 'setting_2'.tr, onTap: () {
                        Get.to(GeneralInformationPage());

                      },),
                      ItemAccountScreenWidget(title: 'setting_3'.tr, onTap: () {
                        Get.to(LoginsPage());

                      },),
                      ItemAccountScreenWidget(title: 'setting_4'.tr, onTap: () {
                        Get.to(SessionsPage());
                      },),
                ItemAccountScreenWidget(title: 'setting_5'.tr, onTap: () {
                  Get.toNamed(PageRoutes.CHANGEPASSWORD);
                  },),

          
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
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ItemAccountScreenWidget(title: 'setting_6'.tr, onTap: () {
                        _logOut();
                      },),
          
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
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ItemAccountScreenWidget(title: 'setting_6_1'.tr, onTap: () {
                        deleteAccountConfirmation();

                      },color: Colors.red,),

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

            ],
          ),
        ),
      ),
    );
  }
  void deleteAccountConfirmation() {
    Get.bottomSheet(
DeleteAccountWidget()
    );
  }

  void _logOut() async{

    var box  = GetStorage();
    box.write("islogin", false);
    Get.offAllNamed(PageRoutes.SPLASH,);
  }
}

class ItemSettingScreenWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final double iconSize;
  final bool? boxMassage;
  final Function() onTap;
  const ItemSettingScreenWidget({
    super.key, required this.icon, required this.title, required this.subTitle, required this.iconSize,  this.boxMassage, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
class ItemAccountScreenWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  Color? color;


  ItemAccountScreenWidget({required this.title,required this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 500,
      child: SizedBox(
        height: 8.h,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(title , style: FontStyleApp.titleSmall.copyWith(
                color:color?? AppColor.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined,size: 9.sp,color: color??Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}
