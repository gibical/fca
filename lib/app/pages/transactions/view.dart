import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/gen/model/json/walletV2/FromJsomGetBills.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetTransactions.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/font_style.dart';
import 'logic.dart';

class TransactionsPage extends StatefulWidget {
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  Map<int, String> relationTypeDescriptions = {
    1: 'Manual transaction by the operator',
    2: 'Online payment',
    3: 'Asset transition',
    4: 'Asset subscription',
    5: 'Asset transition commission',
    6: 'Asset subscription commission',
    8: 'File sharing',
    9: 'Text to image',
    10: 'Audio to text',
    11: 'Translate audio',
    12: 'Edit video',
    13: 'Video to audio',
    14: 'Translate text',
    15: 'Text to audio',
    16: 'Edit audio',
    17: 'Create album',
    18: 'Text to text',
    19: 'Record channel',
    20: 'Audio to image',
  };

    final logic = Get.put(TransactionsLogic());


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.    getWalletBalance();

    }

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return logic.isloading.value?Scaffold(
        backgroundColor: AppColor.blueDarkColor,

        body: Container(

          child: Center(
            child:  Lottie.asset("assets/json/Y8IBRQ38bK.json",height: 10.h),
          ),
        ),
      ): Scaffold(
        backgroundColor: AppColor.blueDarkColor,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () {
            Get.back();
          },
              icon: SvgPicture.asset(AppIcon.backIcon)),
          title: Text('transaction_1'.tr, style: FontStyleApp.titleMedium.copyWith(
              color: AppColor.whiteColor
          ),),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
                itemCount: logic.list.length,
                itemBuilder: (context, index) {
                  return MassageItemWidget(logic.list.elementAt(index));
                }),
          ],
        ),
      );
    });
  }

    Padding MassageItemWidget(BilingModel elementAt) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
        child: Container(

          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff4E4E61).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.sp),
              border: Border(
                left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3), width: 0.4),
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w,),
                child: Row(
                  children: [
                    Text(' ${elementAt.relationType}', style: FontStyleApp.bodyMedium.copyWith(
                        color: Colors.white
                    ),),

                  ],
                ),
              ),
              SizedBox(
                height: 0.8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  elementAt.createdAt??"",
                  style: FontStyleApp.bodyMedium.copyWith(
                    color: Colors.grey.withOpacity(0.7),
                  ),),
              ),
              SizedBox(
                height: 1.5.h,
              ),
            ],
          ),
        ),
      );
    }
}
