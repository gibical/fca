
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/signup/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetNewCountries.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../widgets/country_picker.dart';

Widget CustomTextFieldPlusWidget(
    {required String hintText,
    required String titleText,
    required bool needful,
     Widget? suffix,
    bool isLarge = false,
      bool? isFocus,
      Function()? onTap,

    required context,
    TextEditingController? textEditingController}) {
  final textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.sp),
          border: Border.all(color: "353542".toColor())),
      height: isLarge ? 130 : 53,
      child: TextFormField(
        minLines: isLarge ? 5 : 1,
        maxLines: isLarge ? 6 : 1,
        controller: textEditingController ?? TextEditingController(),
        showCursor: true,


        onTap: isFocus == true ?onTap:(){

        },
        style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor),
        decoration: InputDecoration(
          hintText: hintText,
          suffix:suffix??null,

          hintStyle: textTheme.bodyMedium?.copyWith(
            color: AppColor.whiteColor.withOpacity(0.2),
          ),
          // contentPadding: EdgeInsets.only( left: 8 , right: 8  ),
          fillColor: Color(0xff0E0E12).withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9.sp),
              borderSide: BorderSide.none),
        ),
      ),
    ),
  );
}

Widget CustomTDropDownPlusWidget(
    {required String hintText,
    required String titleText,
    required bool needful,
    bool isLarge = false,
    required context,
    required List<String> models,
    TextEditingController? textEditingController}) {
  final textTheme = Theme.of(context).textTheme;
  return GestureDetector(
    onTap: () {
      _runCustomSelectBottomSheet(models, textEditingController, titleText);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.sp),
            border: Border.all(color: "353542".toColor())),
        height: isLarge ? 130 : 53,
        child: TextFormField(
          enabled: false,
          minLines: isLarge ? 5 : 1,
          maxLines: isLarge ? 6 : 1,
          controller: textEditingController ?? TextEditingController(),
          showCursor: true,
          style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: AppColor.whiteColor.withOpacity(0.2),
              ),
              // contentPadding: EdgeInsets.only( left: 8 , right: 8  ),
              fillColor: Color(0xff0E0E12).withOpacity(0.5),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.sp),
                  borderSide: BorderSide.none),
              suffixIcon: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: "666680".toColor(),
                    size: 10.sp,
                  ))),
        ),
      ),
    ),
  );
}

Widget CustomShowAndPickCountry(
    {required String hintText,
    required String titleText,
    required CountryModel? countryModel,
    required List<CountryModel> countries,
    required bool needful,
    required dynamic signlogic,
    bool isLarge = false,
    required context,
    required List<String> models,
    TextEditingController? textEditingController}) {

  try {
    print('CustomShowAndPickCountry = ${countryModel!.iso}');
  }  catch (e) {
    // TODO
  }
  final textTheme = Theme.of(context).textTheme;
  return GestureDetector(
    onTap: () async{
      CountryModel? model = await Get.bottomSheet(
          CountryPickerBottomSheet(countries));
      if (model != null) {
      textEditingController!.text = model.name.toString();
      signlogic.countryModel =model;

      signlogic.update();
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.sp),color: Color(0xff0E0E12).withOpacity(0.5),
            border: Border.all(color: "353542".toColor())),
        height: isLarge ? 130 : 53,
        child: Row(
          children: [
            SizedBox(width: 3.w,),
            if(countryModel!=null) Container(

                child: CountryFlag.fromCountryCode(countryModel.iso.toString(),
                  width: 30,
                  height: 15,)),
            if(countryModel!=null) Container(

                margin: EdgeInsets.only(left: 3.w),
                child: Text(countryModel.name.toString(),style: TextStyle(
                    color: Colors.white
                ),)),
            if(countryModel==null) Container(

                margin: EdgeInsets.only(left: 3.w),
                child: Text("signup_10_1".tr,style: TextStyle(
                    color: Colors.white
                ),)),

            Expanded(
              child: TextFormField(
                enabled: false,
                minLines: isLarge ? 5 : 1,
                maxLines: isLarge ? 6 : 1,
                controller: textEditingController ?? TextEditingController(),
                showCursor: true,
                style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor),
                decoration: InputDecoration(
              
              
                    suffix: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child:Row(
                        children: [
               
                         
                        ],
                      ) ,
                    ),
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: AppColor.whiteColor.withOpacity(0.2),
                    ),
                    // contentPadding: EdgeInsets.only( left: 8 , right: 8  ),
                    fillColor: Color(0xff0E0E12).withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.sp),
                        borderSide: BorderSide.none),
                    suffixIcon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: "666680".toColor(),
                          size: 10.sp,
                        ))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget CustomShowAndPickLanguage(
    {required String hintText,
    required String titleText,
    required String? languageModel,
    required Map<String, dynamic> countries,
    required bool needful,
    required dynamic signlogic,
    bool isLarge = false,
    required context,
    required List<String> models,
    TextEditingController? textEditingController}) {

  try {
  }  catch (e) {
    // TODO
  }
  final textTheme = Theme.of(context).textTheme;
  return GestureDetector(
    onTap: () async{
      String? model = await Get.bottomSheet(
          LangaugePickerBottomSheet(countries));
      if (model != null) {
      textEditingController!.text = countries[languageModel].toString();
      signlogic.languageModel =model;

      signlogic.update();
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.sp),color: Color(0xff0E0E12).withOpacity(0.5),
            border: Border.all(color: "353542".toColor())),
        height: isLarge ? 130 : 53,
        child: Row(
          children: [
            SizedBox(width: 3.w,),

            if(languageModel!=null) Container(

                margin: EdgeInsets.only(left: 3.w),
                child: Text(countries[languageModel],style: TextStyle(
                    color: Colors.white
                ),)),
            if(languageModel==null) Container(

                margin: EdgeInsets.only(left: 3.w),
                child: Text("viewall_1".tr,style: TextStyle(
                    color: Colors.white
                ),)),

            Expanded(
              child: TextFormField(
                enabled: false,
                minLines: isLarge ? 5 : 1,
                maxLines: isLarge ? 6 : 1,
                controller: textEditingController ?? TextEditingController(),
                showCursor: true,
                style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor),
                decoration: InputDecoration(


                    suffix: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child:Row(
                        children: [


                        ],
                      ) ,
                    ),
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: AppColor.whiteColor.withOpacity(0.2),
                    ),
                    // contentPadding: EdgeInsets.only( left: 8 , right: 8  ),
                    fillColor: Color(0xff0E0E12).withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.sp),
                        borderSide: BorderSide.none),
                    suffixIcon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: "666680".toColor(),
                          size: 10.sp,
                        ))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void _runCustomSelectBottomSheet(List<String> models,
    TextEditingController? textEditingController, String title) {
  Get.bottomSheet(Container(
    width: 100.w,
    height: 50.h,
    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    decoration: BoxDecoration(
        color: "474755".toColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 3.h,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (s, p) {
            return InkWell(
              onTap: () {
                try {
                  textEditingController!.text = models.elementAt(p);
                } catch (e) {
                  // TODO
                }
                Get.back();
              },
              child: Container(
                width: 100.w,
                height: 4.h,
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      models.elementAt(p),
                      style: TextStyle(color: Colors.white.withOpacity(0.4)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100.w,
                      height: 1,
                      color: Colors.white.withOpacity(0.15),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: models.length,
        ))
      ],
    ),
  ));
}
