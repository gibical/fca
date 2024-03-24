import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/pages/profile/view.dart';

import '../../common/app_color.dart';
import 'logic.dart';


class MediaSuitScreen extends StatefulWidget {
  const MediaSuitScreen({super.key});

  @override
  State<MediaSuitScreen> createState() => _MediaSuitScreenState();
}

class _MediaSuitScreenState extends State<MediaSuitScreen> {

  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;
    final editorController = Get.find<MediaSuitController>();
    final w = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Color(0xff000033),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              bottom: h * 0.17,
              left: 0,
              right: 0,
              child: SizedBox(
                  width: w,
                  child: SvgPicture.asset('assets/images/line_editor.svg' , fit:BoxFit.cover,))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: h * 0.27,

                    decoration: BoxDecoration(
                        color: AppColor.primaryLightColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(18)
                    ),

                  ),
                ),
                SizedBox(height: h * 0.1),
                Container(
                  height: h * 0.3,
                  color: Color(0xff000033),

                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 1,

                            width: double.infinity,
                          ),
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                            width: double.infinity,
                          ),
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                            width: double.infinity,
                          ),
                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                            width: double.infinity,
                          ),

                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                            width: double.infinity,
                          ),

                          Container(
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                            width: double.infinity,
                          ),
                        ],
                      ),
                      //Video Time Line
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.08 -4.5),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editVideoDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editVideoDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.deepPurple,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.13 -4.5),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editAudioDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editAudioDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.orange.shade400,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.18 -4.5 ),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editImageDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editImageDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.redAccent,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),
                      Obx(() =>       Padding(
                        padding:  EdgeInsets.only(top: h * 0.22 + 4.5),
                        child: SizedBox(
                          height: h * 0.050,
                          child: ListView.builder(

                              itemCount: editorController.editTextDataList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context , index){
                                String name = editorController.editTextDataList[index].name;
                                return Container(

                                  padding:EdgeInsets.symmetric(horizontal: 10) ,

                                  color: Colors.lightGreen,
                                  child: Center(child: Text(name)),
                                );
                              }),
                        ),
                      ),),


                    ],
                  ),
                ),

                SizedBox(height: h * 0.02),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){

                        Get.to(ProfileScreen() , arguments: 'edit_screen');
                      },
                          icon: Icon(Icons.add , size: 27,)),
                      IconButton(onPressed: (){      print('menu');},
                          icon: SvgPicture.asset('assets/icons/menu_editor.svg')),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        width: w,
                        child: SvgPicture.asset('assets/images/box_editor.svg' , fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          IconButton(onPressed: (){
                            Get.back();
                          },
                              icon: Icon(Icons.close , size: 27,)),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.done ,  size: 27)),


                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),


        ],
      ),
    );
  }
}