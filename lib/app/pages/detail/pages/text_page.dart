import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/widgets/appbar_btn.dart';


class TextPage extends StatelessWidget {

  final String title ;
  final String text ;
  const TextPage({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              toolbarHeight: 10.h,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppbarBTNWidget(
                          iconName: 'back1',
                          onTap: () {
                            Get.back();
                          }),
                      Spacer(),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Spacer(),
                     SizedBox(
                       height: 24,
                       width: 24,
                     ),
                    ],
                  ),
                ),
              ),
              backgroundColor: AppColor.secondaryDark,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(text , style: TextStyle(
                  color: '9C9CB8'.toColor(),
                  height: 2
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
