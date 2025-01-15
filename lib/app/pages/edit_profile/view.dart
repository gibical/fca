import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_switch.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../../common/widgets/appbar_btn.dart';
import '../login/widgets/custom_text_field.dart';
import '../plus_section/widget/custom_plan_text_filed.dart';
import 'logic.dart';

class EditProfilePage extends StatefulWidget {

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DetailController detailController = Get.arguments[0];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(
        EditProfileLogic(detailController, detailController.id));
    final state = logic.state;
    dynamic details;
    switch (Get.arguments[1] as PostType) {
      case PostType.image:
      // TODO: Handle this case.
        details = detailController.imageDetails;

      case PostType.video:
      // TODO: Handle this case.
        details = detailController.videoDetails;

      case PostType.audio:
      // TODO: Handle this case.
        details = detailController.musicDetails;

      case PostType.text:
      // TODO: Handle this case.
        details = detailController.textDetails;
      case PostType.channel:
        // TODO: Handle this case.
    }

    logic.startPageFunction(details, PostType.text);
    return Scaffold(
      backgroundColor: AppColor.secondaryDark,
      body: SafeArea(
        child:








        Obx(() {

          if(logic.isloading1.value ){
            return   CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight: 10.h,
                  surfaceTintColor: Colors.transparent,
                  pinned: true
                  ,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          AppbarBTNWidget(iconName: 'back1', onTap: () {
                            Get.back();
                          }),

                          Text('Edit' , style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          AppbarBTNWidget(iconName: 'tick', onTap: () {



                          }),

                        ],
                      ),
                    ),
                  ),
                  backgroundColor: AppColor.secondaryDark,
                ),

                //--
                SliverToBoxAdapter(
                    child: Padding(
                      padding:  EdgeInsets.only(top: Get.height / 2 - 100),
                      child: Center(
                        child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                            backgroundColor: AppColor.primaryColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    )
                ),
                //--

              ],
            );
          }else{

          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                toolbarHeight: 10.h,
                surfaceTintColor: Colors.transparent,
                pinned: true
                ,
                automaticallyImplyLeading: false,
                flexibleSpace: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        AppbarBTNWidget(iconName: 'back1', onTap: () {
                          Get.back();
                        }),

                        Text('Edit' , style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),),
                        AppbarBTNWidget(iconName: 'tick', onTap: () { logic.sendMainRequest(); } , isLoading:logic.isloading  ),

                      ],
                    ),
                  ),
                ),
                backgroundColor: AppColor.secondaryDark,
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 1.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    height: 20.h,
                    width: 20.h,
                    decoration: BoxDecoration(
                        color: '0F0F26'.toColor(),
                        borderRadius: BorderRadius.circular(8.82.sp)
                    ),
                    child: Center(
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.82.sp),
                          child: CachedNetworkImage(imageUrl: '${detailController.videoDetails!['thumbnails']['525x525']}' ,fit: BoxFit.cover, errorWidget: (context, url, error) {
                            return Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                                backgroundColor: AppColor.primaryColor.withOpacity(0.2),
                              ),
                            );
                          },
                          placeholder: (context, url) {
                          return  Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                                backgroundColor: AppColor.primaryColor.withOpacity(0.2),
                              ),
                            );
                          },
                          ) , ),
                    ),
                  ),
                ),
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextField(


                      controller: logic.assetsEditingController,
                      decoration: InputDecoration(

                        filled: true,


                        fillColor: '#0F0F26'.toColor(),
                        contentPadding: EdgeInsets.symmetric(vertical: 13 , horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(8.sp)
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(8.sp)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(8.sp)
                        ),

                      ),
                    )
                ),
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),

              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextField(

                      maxLines: 4,
                      controller: logic.assetsDescreptionEditingController,
                      decoration: InputDecoration(

                        filled: true,

                        fillColor: '#0F0F26'.toColor(),
                        contentPadding: EdgeInsets.symmetric(vertical: 13 , horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(8.sp)
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(8.sp)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(8.sp)
                        ),

                      ),
                    )
                ),
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),

              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child:  fieldEditAssetWidget(title: 'Category', onTap: () {

                    _runCustomSelectBottomEditeAssetSheet( title:'Category' ,models: [
                      "editprof_29".tr,
                      "editprof_30".tr,
                      "editprof_31".tr,
                      "editprof_32".tr,
                      "editprof_33".tr,
                      "editprof_34".tr,
                      "editprof_35".tr,
                      "editprof_36".tr,
                    ],value: logic.genreController, );

                  }, value: logic.genreController,),
                ),
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),

              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Expanded(child:  fieldEditAssetWidget(title: 'Country', onTap: () {

                        _runCustomSelectBottomEditeAssetSheet( title:'Country' ,  models: Constant.languages ,value: logic.languageController, );
                      }, value: logic.languageController,),),
                      SizedBox(width: 10,),
                      Expanded(child:  fieldEditAssetWidget(title: 'Language', onTap: () {
                        _runCustomSelectBottomEditeAssetSheet( title:'Select a language' ,     models: Constant.languages,value: logic.languageController, );

                      }, value: logic.languageController,),),
                    ],
                  ),
                ),
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),

              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Is this content public?' , style: TextStyle(
                        color: '9C9CB8'.toColor()
                      ),),

                     GetBuilder<EditProfileLogic>(builder: (controller) {
                       return  CustomSwitchWidget(
                         value: logic.isEditEditingController.text == 'true',
                         onChanged: (value) {

                           logic.isEditEditingController.text = value.toString();

                           logic.update();

                         },
                       );
                     },)

                    ],
                  ),
                ),
              ),
              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),

              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: fieldEditAssetWidget(title: 'Full Ownership', onTap: () {
                    _runCustomSelectBottomEditeAssetSheet(

                      priceController: logic.priceController,
                      isLicenceType: true,
                      isSearchBox: false,
                      title:'Licence type' ,models: [
                      "editprof_13".tr,
                      "editprof_14".tr,
                      "editprof_15".tr
                    ],value: logic.planController,);
                  }, value: logic.planController,),
                ),
              ),

              //SizedBox
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 2.h,
                ),

              ),

            ],
          );
        })
      )




    );
  }

  Widget fieldEditAssetWidget({required String title , required Function() onTap ,required TextEditingController? value}) {
    return Material(

      color: '#0F0F26'.toColor(),
      borderRadius: BorderRadius.circular(8.sp),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.sp),
        splashColor: Colors.white.withOpacity(0.02),
        onTap: onTap,
        child: TextField(
          enabled: false,

          style: TextStyle(
            color: Colors.white,
            fontSize: 13.5,
          ),
          controller: value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 13 , horizontal: 10),
              hintText: title,
              hintStyle: TextStyle(
                  fontSize: 13.5,
                color: '9C9CB8'.toColor()
              ),
              suffixIcon: Transform.scale(
                  scale: 0.5,

                  child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg')),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(title , style: TextStyle(
        //         color: '#9C9CB8'.toColor()
        //     ),),
        //
        //     SvgPicture.asset('assets/mediaverse/icons/arrow.svg')
        //   ],
        // ),

      ),
    );
  }


  void _runCustomSelectBottomEditeAssetSheet({
    required List<String> models,
    required String title,
    required TextEditingController? value,
     TextEditingController? priceController,
    bool isSearchBox = true,
    bool isLicenceType = false,
  }) {
    List<String> filteredModels = List.from(models);
    final TextEditingController searchController = TextEditingController();

    Get.bottomSheet(
      elevation: 0,
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: "#0F0F26".toColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg'),
                            ),
                          ),
                          Spacer(),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 24),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 3.h),

                      if (isSearchBox)
                        TextField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              filteredModels = models
                                  .where((item) =>
                                  item.toLowerCase().contains(query.toLowerCase()))
                                  .toList();
                            });
                          },
                          style: TextStyle(
                            decorationColor: Colors.transparent,
                            decoration: TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                            fillColor: '#17172E'.toColor(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                        ),
                      SizedBox(height: isSearchBox ? 2.h : 0),

                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 75),
                          itemCount: filteredModels.length,
                          itemBuilder: (context, index) {
                            final item = filteredModels[index];
                            final isSelected = value?.text == item;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  value?.text = item;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 3.h,
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        if (isLicenceType)
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: isSelected
                                                    ? '2563EB'.toColor()
                                                    : '9C9CB8'.toColor(),
                                                width: isSelected ? 5.5 : 1,
                                              ),
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Checkbox(
                                              value: isSelected,
                                              activeColor: Colors.white,
                                              onChanged: (_) {},
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(6),
                                                side: BorderSide(
                                                  color: '9C9CB8'.toColor(),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : '9C9CB8'.toColor(),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (item == "editprof_14".tr && isSelected)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextField(
                                        textDirection: TextDirection.ltr,
                                        controller:  priceController,
                                        decoration: InputDecoration(
                                          hintText: '00.00',
                                          hintTextDirection: TextDirection.ltr,
                                          hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                                          fillColor: '#17172E'.toColor(),
                                          filled: true,
                                          suffixIcon: IconButton(onPressed: null, icon: Text('EUR' , style: TextStyle(

                                            color: '9C9CB8'.toColor()
                                          ),),),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.sp),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        '0F0F26'.toColor(),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: '0F0F26'.toColor(),
                        blurRadius: 50,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Material(
                          color: '2563EB'.toColor(),
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            splashColor: Colors.white.withOpacity(0.03),
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Text('Confirm'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }




}
