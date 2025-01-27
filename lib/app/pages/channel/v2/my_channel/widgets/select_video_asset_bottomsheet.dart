import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/widgets/appbar_btn.dart';
import '../../../../home/widgets/mini_video_widget.dart';

class SelectVideoAssetBottomsheet extends StatefulWidget {
  const SelectVideoAssetBottomsheet({super.key});

  @override
  State<SelectVideoAssetBottomsheet> createState() =>
      _SelectVideoAssetBottomsheetState();
}

class _SelectVideoAssetBottomsheetState
    extends State<SelectVideoAssetBottomsheet> {
  MyChannelController logic = Get.find<MyChannelController>();

  int? selectedAsset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (logic.videoContentModels.isEmpty) {
      logic.getVideoAsset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarBTNWidgetAll(
                      iconName: 'remove',
                      onTap: () {
                        Get.back();
                      }),
                  Text(
                    "my_channel_16".tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 10.w,
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Obx(() {
                return Expanded(
                    child: logic.isLoadingAssets.value
                        ? Center(
                      child: Lottie.asset(
                          "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                          height: 9.h),
                    )
                        : GridView.builder(
                        itemCount: logic.videoContentModels.length,
                        itemBuilder: (s, i) {
                          bool? _isSelcetd;
                          if (selectedAsset != null) {
                            _isSelcetd = (selectedAsset == i);
                          }
                          return MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              selectedAsset = i;
                              setState(() {

                              });
                            },
                            child: IgnorePointer(
                              child: MiniVideoWidget(
                                model: logic.videoContentModels.elementAt(i),
                                height: 40.w, selectedAsset: _isSelcetd,),
                            ),
                          );
                        },
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 9 / 10)));
              }),
              Opacity(
                opacity: (selectedAsset == null) ? 0.4 : 1,
                child: Container(
                  width: 100.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(500)
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (selectedAsset != null) {
                        Get.back(result: logic.videoContentModels.elementAt(
                            selectedAsset!));
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500)),
                    child: Center(child: Text("my_channel_17".tr,
                      style: TextStyle(fontWeight: FontWeight.w500),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
