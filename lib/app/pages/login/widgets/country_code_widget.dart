import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/logic.dart';
import 'package:mediaverse/app/widgets/country_picker.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetNewCountries.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

Widget CountryCodeWidget(context, LoginController controller) {
  final textTheme = Theme
      .of(context)
      .textTheme;
  return Obx(() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      //   alignment: Alignment.center,
      children: [
        SizedBox(
          width: 3.w,
        ),
        GestureDetector(
          onTap: () async{
            CountryModel? model = await Get.bottomSheet(
                CountryPickerBottomSheet(controller.countries));
            if (model != null) {
              controller.code.value = model;
            }
          },
          child: IgnorePointer(
            ignoring: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    controller.code.value.iso.toString(),
                    height: 2.h,
                    width: 6.w,
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Text(controller.code.value.dialingCode.toString()),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 28,
          width: 1.5,
          color: AppColor.whiteColor.withOpacity(0.2),
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  });
}
