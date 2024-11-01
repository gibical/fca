import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/home/tabs/all/view.dart';
import 'package:mediaverse/app/pages/home/tabs/image/view.dart';
import 'package:mediaverse/app/pages/home/tabs/sound/view.dart';
import 'package:mediaverse/app/pages/home/tabs/text/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/view.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';
import 'package:mediaverse/app/pages/profile/widgets/GridMainWidget.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:mediaverse/app/pages/search/tabs/imageWidget.dart';
import 'package:mediaverse/app/pages/search/tabs/soundWidget.dart';
import 'package:mediaverse/app/pages/search/tabs/txt.dart';
import 'package:mediaverse/app/pages/search/tabs/vidPage.dart';
import 'package:mediaverse/app/pages/search/widgets/custom_tab_bar_search.dart';
import 'package:mediaverse/app/widgets/custom_app_bar_widget.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  bool isAdvancedSearchVisible = false;
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final TextEditingController _searcController = TextEditingController();
  final TextEditingController _tagOrPlanController = TextEditingController();

  final SearchLogic _logic = Get.put(SearchLogic());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return GetBuilder(
      init: _logic,
      builder: (controller) => Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 25.h,
          // backgroundColor: AppColor.whiteColor,
          backgroundColor: AppColor.primaryDarkColor,
          automaticallyImplyLeading: false,
          title: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: !_logic.isAdvancedSearchVisible ? 15.h : 22.h,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searcController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 13,
                          ),
                          fillColor: Colors.black45,
                          filled: true,
                          hintText: 'search_11'.tr,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.sp),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _logic.searchMedia(
                                  _tagOrPlanController.text.trim(),
                                  _searcController.text.trim());
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.2.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _logic.showAdvanceTextField();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            _logic.isAdvancedSearchVisible
                                ? AppIcon.upIcon
                                : AppIcon.settingIcon,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_logic.isAdvancedSearchVisible)
                  SizedBox(
                    height: 1.h,
                  ),
                if (_logic.isAdvancedSearchVisible)
                  Obx(
                    () => Row(
                      children: [
                        PopupMenuButton(
                          color: AppColor.blueDarkColor,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child:  Text("search_13".tr),
                                onTap: () {
                                  _logic.isTag.value = false;
                                },
                              ),
                              PopupMenuItem(
                                child:  Text("search_12".tr),
                                onTap: () {
                                  _logic.isTag.value = true;
                                },
                              ),
                            ];
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_drop_down),
                              Text(_logic.isTag.value ? "${"search_12".tr} :" : "${"search_13".tr} :"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3.5.w,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _tagOrPlanController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 13,
                              ),
                              fillColor: Colors.black45,
                              filled: true,
                              hintText:
                                  '${"search_14".tr} ${_logic.isTag.value ? "search_12".tr
                                      : "search_13".tr}',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.sp),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 2.5.h,
                ),
                Expanded(
                  child: Container(
                    color: theme.secondary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.w,
                      vertical: 1.h,
                    ),
                    child: TabBar(
                      physics: const BouncingScrollPhysics(),
                      controller: _tabController,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      enableFeedback: false,
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColor.primaryLightColor,
                      unselectedLabelColor: const Color(0xff666680),
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
              ],
            ),
          ),
        ),
        body: Obx(
          () => _logic.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: allItems(),
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: _logic.pictureLST.length,
                      itemBuilder: (context, index) {
                        return GridPostView( _logic.pictureLST[index]);
                      },
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: _logic.bestVideos.length,
                      itemBuilder: (context, index) {
                        return GridPostView( _logic.bestVideos[index]);
                      },
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: _logic.audioLST.length,
                      itemBuilder: (context, index) {
                        return GridPostView( _logic.audioLST[index]);
                      },
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: _logic.txtLST.length,
                      itemBuilder: (context, index) {
                        return GridPostView( _logic.txtLST[index]);
                      },
                    ),
                  ],
                ),
        ),
      ),
    );

    //   Scaffold(
    //   backgroundColor: AppColor.grayLightColor,
    //   body: CustomScrollView(
    //     slivers: [
    //
    //       SliverAppBar(
    //
    //         automaticallyImplyLeading: false,
    //         backgroundColor: Colors.white,
    //         pinned: false,
    //         toolbarHeight: 13.h,
    //         title: Column(
    //           children: [
    //
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: TextField(
    //                     decoration: InputDecoration(
    //                       contentPadding: EdgeInsets.symmetric(
    //                         horizontal: 10,
    //                         vertical: 13,
    //                       ),
    //                       fillColor: AppColor.grayLightColor,
    //                       filled: true,
    //                       hintText: 'Search in all media',
    //                       hintStyle: TextStyle(
    //                         color: AppColor.primaryDarkColor.withOpacity(0.2),
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(7.sp),
    //                         borderSide: BorderSide.none,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   width: 7,
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     Get.back();
    //                   },
    //                   child: Container(
    //                     height: 50,
    //                     width: 50,
    //                     decoration: BoxDecoration(
    //                       color: AppColor.grayLightColor,
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Center(
    //                       child: SvgPicture.asset(AppIcon.closeIcon),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 2.5.h,
    //             ),
    //             Container(
    //               height: 0.5,
    //               width: double.infinity,
    //               color: AppColor.primaryDarkColor.withOpacity(0.2),
    //             ),
    //
    //           ],
    //         ),
    //
    //       ),
    //
    //       SliverToBoxAdapter(
    //         child: Column(
    //           children: [
    //
    //             Container(
    //                color: AppColor.whiteColor,
    //               height: 5.h,
    //               child: Padding(
    //                 padding: const EdgeInsets.only(left: 25 , right: 15),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text('Search in all media' , style: TextStyle(
    //                         color: Colors.black
    //                     ),),
    //                     IconButton(
    //                       icon: Icon(Icons.arrow_drop_down),
    //                       onPressed: () {
    //                         setState(() {
    //                           isAdvancedSearchVisible =
    //                           !isAdvancedSearchVisible;
    //                         });
    //                       },
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //
    //
    //
    //             Container(
    //               height: 1.h,
    //               color: Colors.white,
    //             ),
    //             if (isAdvancedSearchVisible)
    //               Container(
    //                   color: Colors.white,
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(left: 20 , right: 20),
    //                     child: Column(
    //                       children: [
    //                         TextField(
    //                           decoration: InputDecoration(
    //                             contentPadding: EdgeInsets.symmetric(
    //                               horizontal: 10,
    //                               vertical: 13,
    //                             ),
    //                             fillColor: AppColor.grayLightColor,
    //                             filled: true,
    //                             hintText: 'Search in all media',
    //                             hintStyle: TextStyle(
    //                               color: AppColor.primaryDarkColor.withOpacity(0.2),
    //                             ),
    //                             border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(7.sp),
    //                               borderSide: BorderSide.none,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height: 1.h),
    //                         TextField(
    //                           decoration: InputDecoration(
    //                             contentPadding: EdgeInsets.symmetric(
    //                               horizontal: 10,
    //                               vertical: 13,
    //                             ),
    //                             fillColor: AppColor.grayLightColor,
    //                             filled: true,
    //                             hintText: 'Search in all media',
    //                             hintStyle: TextStyle(
    //                               color: AppColor.primaryDarkColor.withOpacity(0.2),
    //                             ),
    //                             border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(7.sp),
    //                               borderSide: BorderSide.none,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 1.h,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //
    //           //  CustomTabBarWidget(),
    //
    //
    //           ],
    //         ),
    //       ),
    //
    //     ],
    //   ),
    //
    // );
  }

  List<Widget> allItems() {
    List<Widget> s = [];
    try {
      if (_logic.item.all!.isNotEmpty) {
        for (var element in _logic.item.all!) {
          s.add(GridPostView(element));
        }
      }
    }  catch (e) {
      // TODO
    }

    return s;
  }

  Widget _buildTab(
      BuildContext context, String icon, int tabIndex, bool isLabel) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLabel
              ?  Text('search_15'.tr)
              : SvgPicture.asset(
                  height: 2.h,
                  icon,
                  color: tabIndex == _selectedTabIndex
                      ? AppColor.primaryLightColor
                      : const Color(0xff666680),
                ),
        ],
      ),
    );
  }
}
