import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../gen/model/json/FromJsonGetNewCountries.dart';
import '../common/app_color.dart';

class CountryPickerBottomSheet extends StatelessWidget {

  List<CountryModel> model;


  CountryPickerBottomSheet(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 100.w,
      height: 50.h,///
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryLightColor),
          borderRadius: BorderRadius.circular(10),
        color: "000033".toColor(),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),

            child: Text("viewall_2".tr,style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13.sp
            ),),
          ),
          SizedBox(height: 3.h,),
          Expanded(
            child: ListView.builder(

                itemCount: model.length,
                itemBuilder: (s,i){
            
                  CountryModel index = model.elementAt(i);
                  return MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    onPressed: (){

                      Get.back(result: index);
                    },
                    child: Container(

                      width: 100.w,
                      height: 4.h,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          ClipRRect(

                            child: CountryFlag.fromCountryCode(index.iso.toString()
                              ,height: 2.h,width: 6.w,),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          SizedBox(width: 3.w,),
                          Expanded(
                            child: Row(
                              children: [
                                Container(child: Text(index.name.toString(),style: TextStyle(
                    fontSize: 8.sp
                    ),)),
                                Expanded(
                                  child: Text("  -  ${index.iso}",style: TextStyle(
                                    color: Colors.white.withOpacity(0.5)
                                  ),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
            }),
          )
        ],
      ),

    );
  }
}
