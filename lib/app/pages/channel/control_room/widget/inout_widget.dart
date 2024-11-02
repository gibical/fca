import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 100.w,

          child: SingleChildScrollView(
            padding: EdgeInsets.only(
        top: 4.h,left: 16,right: 16
        ),
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("channel_1".tr,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                          
                                fontSize: 17.sp
                              ),),
                              SizedBox(width: 3.w,),
                              Container(
                                width: 15.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryLightColor,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "channel_2".tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.more_vert,color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100.w,
                          height: 25.h,
                          child: Image.asset("assets/${F.assetTitle}/images/all_tools_7.png",fit: BoxFit.fitWidth,),
                        ),
                      ),
                      SizedBox(height: 2.h,),
            
                      Row(
                        children: [
                          Expanded(
                            child: Text("https://www.freepik.com/premium.freepik.com/premium.freepik.com/premium.freepik.com/premium",
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: "666680".toColor(),),),
                          ),
                          SizedBox(width: 16.w,),
            
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_8.svg'),
                          SizedBox(width: 3.w,),
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_9.svg'),
            
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Input 1",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
            
                                fontSize: 17.sp
                              ),),
                              SizedBox(width: 3.w,),
                              Container(
                                width: 15.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryLightColor,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "ON AIR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.more_vert,color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100.w,
                          height: 25.h,
                          child: Image.asset("assets/${F.assetTitle}/images/all_tools_7.png",fit: BoxFit.fitWidth,),
                        ),
                      ),
                      SizedBox(height: 2.h,),
            
                      Row(
                        children: [
                          Expanded(
                            child: Text("https://www.freepik.com/premium.freepik.com/premium.freepik.com/premium.freepik.com/premium",
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: "666680".toColor(),),),
                          ),
                          SizedBox(width: 16.w,),
            
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_8.svg'),
                          SizedBox(width: 3.w,),
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_9.svg'),
            
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Input 1",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
            
                                fontSize: 17.sp
                              ),),
                              SizedBox(width: 3.w,),
                              Container(
                                width: 15.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryLightColor,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "ON AIR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.more_vert,color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100.w,
                          height: 25.h,
                          child: Image.asset("assets/${F.assetTitle}/images/all_tools_7.png",fit: BoxFit.fitWidth,),
                        ),
                      ),
                      SizedBox(height: 2.h,),
            
                      Row(
                        children: [
                          Expanded(
                            child: Text("https://www.freepik.com/premium.freepik.com/premium.freepik.com/premium.freepik.com/premium",
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: "666680".toColor(),),),
                          ),
                          SizedBox(width: 16.w,),
            
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_8.svg'),
                          SizedBox(width: 3.w,),
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_9.svg'),
            
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Input 1",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
            
                                fontSize: 17.sp
                              ),),
                              SizedBox(width: 3.w,),
                              Container(
                                width: 15.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryLightColor,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "ON AIR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.more_vert,color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100.w,
                          height: 25.h,
                          child: Image.asset("assets/${F.assetTitle}/images/all_tools_7.png",fit: BoxFit.fitWidth,),
                        ),
                      ),
                      SizedBox(height: 2.h,),
            
                      Row(
                        children: [
                          Expanded(
                            child: Text("https://www.freepik.com/premium.freepik.com/premium.freepik.com/premium.freepik.com/premium",
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: "666680".toColor(),),),
                          ),
                          SizedBox(width: 16.w,),
            
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_8.svg'),
                          SizedBox(width: 3.w,),
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_9.svg'),
            
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Input 1",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
            
                                fontSize: 17.sp
                              ),),
                              SizedBox(width: 3.w,),
                              Container(
                                width: 15.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryLightColor,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    "ON AIR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.more_vert,color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100.w,
                          height: 25.h,
                          child: Image.asset("assets/${F.assetTitle}/images/all_tools_7.png",fit: BoxFit.fitWidth,),
                        ),
                      ),
                      SizedBox(height: 2.h,),
            
                      Row(
                        children: [
                          Expanded(
                            child: Text("https://www.freepik.com/premium.freepik.com/premium.freepik.com/premium.freepik.com/premium",
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: "666680".toColor(),),),
                          ),
                          SizedBox(width: 16.w,),
            
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_8.svg'),
                          SizedBox(width: 3.w,),
                          SvgPicture.asset('assets/${F.assetTitle}/images/all_tools_9.svg'),
            
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
