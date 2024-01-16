import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../widgets/custom_grid_view_widget.dart';


class TextTabScreen extends StatelessWidget {
  const TextTabScreen({super.key , required this.introBoxWidget});
 final Widget introBoxWidget;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return   Scaffold(
        backgroundColor: theme.background,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:  CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 11.h)),
               SliverToBoxAdapter(
                child:      Text(
                  'Latest',
                  style: FontStyleApp.titleLarge.copyWith(
                    color: AppColor.whiteColor
                  )
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 1.5.h)),
              SliverList.builder(
                  itemCount: 5,
                  itemBuilder: (context , index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0 , bottom: 8.0 ),
                      child: Container(
                            height: 13.h,
                            width: MediaQuery.of(context).size.width ,
                            decoration: BoxDecoration(
                              color:AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(14.sp),
                              border: Border.all(
                                  color:  AppColor.primaryDarkColor.withOpacity(0.2),
                                  width: 0.4
                              ),
                            ),
                            child: Row(
                                children: [
                                  Container(
                                    height: 13.h,
                                    width: MediaQuery.of(context).size.width / 3.8,
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryDarkColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Center(
                                      child: introBoxWidget,
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.all(9.sp),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Best worlld cup messi mo...' , style: TextStyle(
                                            color: Colors.black
                                        ),),
                                        const SizedBox(height: 4,),
                                        Text('this is a clip from best momen...' , style: TextStyle(
                                          color:  AppColor.primaryDarkColor.withOpacity(0.2),
                                        ),),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 10,
                                            ),
                                            const SizedBox(width: 4,),
                                            Text('Jak paul' , style: TextStyle(
                                              color:  AppColor.primaryDarkColor.withOpacity(0.2),
                                            ),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                          ),


                    );
                  }),

              SliverPadding(padding: EdgeInsets.only(top: 12.h)),
            ],
          ),
        )
    );
  }
}
