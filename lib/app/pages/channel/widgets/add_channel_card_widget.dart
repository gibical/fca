import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:sizer/sizer.dart';

import '../../share_account/logic.dart';

class AddChannelCardWidget extends StatefulWidget {
  const AddChannelCardWidget({super.key});

  @override
  State<AddChannelCardWidget> createState() => _AddChannelCardWidgetState();
}

class _AddChannelCardWidgetState extends State<AddChannelCardWidget> {
  final _logic = Get.find<ShareAccountLogic>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
            side: BorderSide(color: Colors.white.withOpacity(0.4), width: 0.7)),
        height: 6.h,
        minWidth: double.infinity,
        onPressed: () {

         _logic.showAddProgramBottomSheet();
         // _logic.sendRequestAddProgram();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Porgram'.tr,
              style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.grayLightColor.withOpacity(0.5),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Icon(Icons.add,
                color: AppColor.grayLightColor.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}
