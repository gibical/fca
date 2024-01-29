import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';


class OwnershipTabScreen extends StatefulWidget {

  @override
  State<OwnershipTabScreen> createState() => _OwnershipTabScreenState();
}

class _OwnershipTabScreenState extends State<OwnershipTabScreen>    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return GetBuilder<HomeLogic>(


        builder: (logic) {
          return Stack(
            children: [

              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  AllTabScreen(),
                  ImageTabScreen(),
                  VideoTabScreen(),
                  SoundTabScreen(
                  ),
                  TextTabScreen(


                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11.sp),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),

                      child: Container(
                        height: 60,
                        color: theme.secondary,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TabBar(

                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            overlayColor: MaterialStateProperty.all(
                                Colors.transparent),
                            enableFeedback: false,
                            indicatorWeight: 2,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: AppColor.primaryLightColor,
                            unselectedLabelColor: Color(0xff666680),
                            labelColor: AppColor.primaryLightColor,
                            dividerColor: Colors.transparent,
                            tabs: [
                              _buildTab(context, AppIcon.imageIcon, 0, true),
                              _buildTab(context, AppIcon.imageIcon, 1, false),
                              _buildTab(context, AppIcon.videoIcon, 2, false),
                              _buildTab(context, AppIcon.soundIcon, 3, false),
                              _buildTab(context, AppIcon.textIcon, 4, false),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                return Visibility(
                  //visible: false,
                  visible: widget.homeLogic.isloading.value,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Lottie.asset(
                          "assets/json/Y8IBRQ38bK.json", height: 18.h),
                    ),
                  ),
                );
              })

            ],
          );
        });
  }

  Widget _buildTab(BuildContext context, String icon, int tabIndex,
      bool isLabel) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLabel ? Text('All') : SvgPicture.asset(
            height: 2.h,
            icon,
            color: tabIndex == _selectedTabIndex
                ? AppColor.primaryLightColor
                : Color(0xff666680),),

        ],
      ),
    );
  }
}
