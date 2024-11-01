

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:sizer/sizer.dart';



class UploadScreen extends StatefulWidget {
   UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? selctedCoverImage;

  Future pickImage()async{
     final imagePath = await   ImagePicker().pickImage(source: ImageSource.gallery);
     if(imagePath == null)return;
     setState(() {
       selctedCoverImage =File(imagePath.path);
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Information' , style:  Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 6.w ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Text('Title' , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextField(
                showCursor: false,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 15),
          
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1
                    ),
                  ),
          
                  focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(
                        color: AppColor.primaryLightColor,
                        width: 1
                    ),
                  ),
                  disabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1
                    ),
                  ),
          
                  hintText: 'your title...',
                  fillColor: AppColor.blueDarkColor,
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Text('Add cover' , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),),
              SizedBox(
                height: 0.5.h,
              ),
              Text('Minimum 300px width minimum 300px ' , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),),
              SizedBox(
                height: 2.5.h,
              ),
             GestureDetector(
               onTap: (){
                 pickImage();
               },
                child: selctedCoverImage != null ? Container(
                  height: 20.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(selctedCoverImage!) , fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(14.sp),
                      border: Border.all(
                          color: Colors.white10.withOpacity(0.2)
                      )
                  ),
                ) : Container(
                  height: 20.h,
                  width: 45.w,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppIcon.addImageIcon , height: 30),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text('your cover...' , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                          color: Colors.grey.withOpacity(0.2),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                        ),),
          
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.blueDarkColor,
                    borderRadius: BorderRadius.circular(14.sp),
                    border: Border.all(
                      color: Colors.white10.withOpacity(0.2)
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                child: Text('Language' , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              SizedBox(
                height: 1.5.h,
              ),
            Container(
            padding:  EdgeInsets.symmetric(vertical: 0.6.h , horizontal: 5.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.blueDarkColor,
              borderRadius: BorderRadius.circular(10.sp)
            ),
            child: DropdownButton<String>(
          
              //elevation: 5,
              style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
          
              items: <String>[
                'FA',
                'EN',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Please choose a langauage",
                style:  Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              underline: SizedBox(),
              icon: SizedBox(),
              onChanged: (_) {
          
              },
            ),
          ),
              SizedBox(
                height: 4.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                child: Text('Write a caption' , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 15),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1
                    ),
                  ),

                  focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(
                        color: AppColor.primaryLightColor,
                        width: 1
                    ),
                  ),
                  disabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1
                    ),
                  ),

                  hintText: 'your title...',
                  fillColor: AppColor.blueDarkColor,
                ),
                maxLines: 5,
                minLines: 2,
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BoxCircleUploadButtons(onTap: (){} , icon: AppIcon.uploadIcon , title: 'Save &\nPublish'),
                  BoxCircleUploadButtons(onTap: (){} , icon: AppIcon.shareIcon , title: 'Save &\nShare'),
                  BoxCircleUploadButtons(onTap: (){} , icon: AppIcon.saveIcon , title: 'Save\n'),
          
          
                ],
              ),
              SizedBox(
                height: 5.5.h,
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }










  Widget BoxCircleUploadButtons({required Function() onTap, required String icon , required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(AppIcon.boxcircleIcon),
                        SvgPicture.asset(icon),
                      ],
                    ),
          SizedBox(
            height: 1.h,
          ),
          Text(title , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),),
        ],
      ),
    );
  }
}
