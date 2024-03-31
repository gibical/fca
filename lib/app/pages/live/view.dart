import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/live/logic.dart';
import 'package:mediaverse/app/pages/live/widgets/custom_video_live_widget.dart';
import 'package:sizer/sizer.dart';
import '../../common/app_route.dart';
import '../home/logic.dart';
import '../home/widgets/bset_item_explore_widget.dart';

class LiveScreen extends StatefulWidget {
  LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  HomeLogic logic = Get.find<HomeLogic>();

  LiveController liveController = Get.find<LiveController>();

  late Widget videoWidget;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('_LiveScreenState.initState = ${liveController.liveDetails?['link'] ?? ''}');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {

      return liveController.isLoadingLive.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [

                SliverToBoxAdapter(
                  child: SizedBox(
                    child: Column(
                      children: [

                        VideoLiveWidget(
                            videoUrl: liveController.liveDetails?['link'] ?? ''),
                        SizedBox(height: 2.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.sp),
                                child: SizedBox(
                                  height: 5.h,
                                  width: 10.w,
                                  child: Image.network(
                                    liveController.liveDetails?['thumbnail'] ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                liveController.liveDetails?['title'] ?? '',
                                style: GoogleFonts.inter(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState) {
                                          return Container(
                                            height: 55.h,
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryDarkColor.withOpacity(0.5),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.sp),
                                                topRight: Radius.circular(20.sp),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 4.h),
                                                Text('Record live' , style: GoogleFonts.inter(
                                                  fontSize: 19,
                                                  color: AppColor.primaryDarkColor
                                                ),),
                                                SizedBox(height: 4.h),
                                                for (int index = 0; index < liveController.titles.length; index++)
                                                  CustomItemRecordBottomSheet(
                                                    width: MediaQuery.of(context).size.width,
                                                    isSelected: liveController.selectedIndex == index,
                                                    onTap: () {
                                                      setState(() {
                                                        liveController.selectedIndex = index;
                                                      });
                                                    },
                                                    title: liveController.titles[index],
                                                  ),

                                                Spacer(),
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 1.h),
                                                  child: Obx((){
                                                    return SizedBox(
                                                      height: 60,
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.sp),
                                                          ),
                                                          backgroundColor: AppColor.primaryLightColor,
                                                        ),
                                                        onPressed: () {
                                                          liveController.postTimeRecord(liveController.liveDetails?['id']);

                                                        },
                                                        child:liveController.isLoadingRecord.value ?CircularProgressIndicator(color: Colors.white,): Text('Start recording' , style: GoogleFonts.inter(
                                                            color: Colors.white,
                                                            fontSize: 15
                                                        ),)
                                                      ),
                                                    );
                                                  })
                                                ),
                                                SizedBox(height: 2.h),
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                    },
                                  );
                                }, icon: Image.asset(AppIcon.recIcon , scale: 5.5, color: Colors.white,),
                              ),

                              IconButton(onPressed: (){
                                liveController.takeScreenShot();
                              },
                                  icon: Image.asset(AppIcon.screenshotIcon , scale: 5.8, color: Colors.white,)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.5.w,
                      ),
                      child: Text(
                        'Other Channel',
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 21.h,
                      child: ListView.builder(
                          itemCount: logic.channels.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final channelId = logic.channels[index].id;
                                Get.offAndToNamed(PageRoutes.LIVE,
                                    arguments: {'channelId': channelId});
                              },
                              child: BestChannelsWidget(
                                  model: logic.channels.elementAt(index)),
                            );
                          }),
                    )
                  ],
                )),
              ],
            );
    }));
  }
}




class CustomItemRecordBottomSheet extends StatelessWidget {
  const CustomItemRecordBottomSheet({
    Key? key,
    required this.title,
    required this.width,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final double width;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool selected = isSelected;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 1.h),
        child: Container(
          height: 60,
          width: width,
          decoration: BoxDecoration(
            color: selected
           ?   AppColor.blueDarkColor.withOpacity(0.8) : AppColor.blueDarkColor.withOpacity(0.1)
           ,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$title Minutes',
              style: GoogleFonts.inter(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
