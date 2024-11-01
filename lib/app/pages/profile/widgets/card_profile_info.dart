



import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:sizer/sizer.dart';


class CardProfileInfoWidget extends StatelessWidget {

  ProfileControllers logic;

  CardProfileInfoWidget(this.logic);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 140.0 , left: 15 , right: 15),
      child: Row(
        children: [
        if(logic.isassetInit.value)  CardProfileInfoItem(title: '${logic.assetsModel.assets.toString()}' , subTitle: 'Assets'),
          if(logic.isassetInit.value)    CardProfileInfoItem(title: '${logic.assetsModel.salesNumber.toString()}', subTitle: 'Sales'),
          if(logic.isassetInit.value)   CardProfileInfoItem(title: '${(double.parse(logic.assetsModel.salesVolume.toString())/100).toString()} €' , subTitle: 'Volume'),



        ],
      ),
    );
  }
}

class CardProfileInfoItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const CardProfileInfoItem({
    super.key, required this.title, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:24),
              child: Container(

                height: 1.5,
                color: AppColor.primaryLightColor,
              ),
            ),
            Container(

              height: 8.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.55.sp),
                border: Border(
               //   left: BorderSide(width: 1.5, color: AppColor.grayLightColor.withOpacity(0.2), ),
                ),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title , style: FontStyleApp.titleSmall.copyWith(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 2,),
                  Text(subTitle,style: FontStyleApp.bodySmall.copyWith(
                    color: AppColor.grayLightColor.withOpacity(0.7)
                  )),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
