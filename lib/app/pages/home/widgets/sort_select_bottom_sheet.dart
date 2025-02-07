import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../models/sort_type.dart';

class SortSelectBottomSheet extends StatefulWidget {

  int selected ;

  SortSelectBottomSheet(this.selected);

  @override
  State<SortSelectBottomSheet> createState() => _SortSelectBottomSheetState();
}

class _SortSelectBottomSheetState extends State<SortSelectBottomSheet> {

  Map<SortType,String> _models = {
    SortType.newset:"home_18".tr,
    SortType.mostviewed:"home_19".tr,
    SortType.mostsold:"home_20".tr,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),

      ),
      padding: EdgeInsets.all(16),
      child: Column(

        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.close)),
              Text("home_16".tr),
              Text("home_17".tr,style: TextStyle(
                color: AppColor.primaryLightColor
              ),),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _models.length,
              itemBuilder: (s,i){
                return CustomCheckbox(isChecked: widget.selected==i, onChanged: (){
                  widget.selected = i;
                  setState(() {

                  });
                  Get.back(result: i);
                }, title: _models.values.elementAt(i));
              },
            ),
          )
        ],
      ),
    );
  }
}
class CustomCheckbox extends StatefulWidget {
  bool isChecked ;

  String title;
  Function onChanged;

  CustomCheckbox({required this.isChecked, required this.onChanged, required this.title});


  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: GestureDetector(
        onTap: () {
      
          widget.onChanged.call();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: widget.isChecked ? AppColor.primaryLightColor: Colors.transparent,
                border: Border.all(color:widget.isChecked?AppColor.primaryLightColor: Colors.white, width: 1),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(1.0.w),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.circular(500)
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              widget.title,
              style: TextStyle(
                color:!widget.isChecked ?Colors.white.withOpacity(0.4): Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}